using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using Unity.VisualScripting.Antlr3.Runtime;
using UnityEngine;

namespace Unity.VisualScripting.Dependencies.NCalc;

public class Expression
{
	protected readonly string OriginalExpression;

	protected Dictionary<string, IEnumerator> ParameterEnumerators;

	private Dictionary<string, object> _parameters;

	private static bool _cacheEnabled = true;

	private static Dictionary<string, WeakReference> _compiledExpressions = new Dictionary<string, WeakReference>();

	private static readonly ReaderWriterLock Rwl = new ReaderWriterLock();

	public EvaluateOptions Options { get; set; }

	public string Error { get; private set; }

	public LogicalExpression ParsedExpression { get; private set; }

	public Dictionary<string, object> Parameters
	{
		get
		{
			return _parameters ?? (_parameters = new Dictionary<string, object>());
		}
		set
		{
			_parameters = value;
		}
	}

	public static bool CacheEnabled
	{
		get
		{
			return _cacheEnabled;
		}
		set
		{
			_cacheEnabled = value;
			if (!CacheEnabled)
			{
				_compiledExpressions = new Dictionary<string, WeakReference>();
			}
		}
	}

	public event EvaluateFunctionHandler EvaluateFunction;

	public event EvaluateParameterHandler EvaluateParameter;

	private Expression()
	{
		Parameters["null"] = (Parameters["NULL"] = null);
	}

	public Expression(string expression, EvaluateOptions options = EvaluateOptions.None)
		: this()
	{
		if (string.IsNullOrEmpty(expression))
		{
			throw new ArgumentException("Expression can't be empty", "expression");
		}
		expression = expression.Replace('"', '\'');
		OriginalExpression = expression;
		Options = options;
	}

	public Expression(LogicalExpression expression, EvaluateOptions options = EvaluateOptions.None)
		: this()
	{
		if (expression == null)
		{
			throw new ArgumentException("Expression can't be null", "expression");
		}
		ParsedExpression = expression;
		Options = options;
	}

	public void UpdateUnityTimeParameters()
	{
		Dictionary<string, object> parameters = Parameters;
		object value = (Parameters["DT"] = Time.deltaTime);
		parameters["dt"] = value;
		Dictionary<string, object> parameters2 = Parameters;
		value = (Parameters["Second"] = 1f / Time.deltaTime);
		parameters2["second"] = value;
	}

	public bool HasErrors()
	{
		try
		{
			if (ParsedExpression == null)
			{
				ParsedExpression = Compile(OriginalExpression, (Options & EvaluateOptions.NoCache) == EvaluateOptions.NoCache);
			}
			return ParsedExpression != null && Error != null;
		}
		catch (Exception ex)
		{
			Error = ex.Message;
			return true;
		}
	}

	public object Evaluate(Flow flow)
	{
		if (HasErrors())
		{
			throw new EvaluationException(Error);
		}
		if (ParsedExpression == null)
		{
			ParsedExpression = Compile(OriginalExpression, (Options & EvaluateOptions.NoCache) == EvaluateOptions.NoCache);
		}
		EvaluationVisitor evaluationVisitor = new EvaluationVisitor(flow, Options);
		evaluationVisitor.EvaluateFunction += EvaluateFunction;
		evaluationVisitor.EvaluateParameter += EvaluateParameter;
		evaluationVisitor.Parameters = Parameters;
		if ((Options & EvaluateOptions.IterateParameters) == EvaluateOptions.IterateParameters)
		{
			int num = -1;
			ParameterEnumerators = new Dictionary<string, IEnumerator>();
			foreach (object value in Parameters.Values)
			{
				if (!(value is IEnumerable enumerable))
				{
					continue;
				}
				int num2 = 0;
				foreach (object item in enumerable)
				{
					_ = item;
					num2++;
				}
				if (num == -1)
				{
					num = num2;
				}
				else if (num2 != num)
				{
					throw new EvaluationException("When IterateParameters option is used, IEnumerable parameters must have the same number of items.");
				}
			}
			foreach (string key in Parameters.Keys)
			{
				if (Parameters[key] is IEnumerable enumerable2)
				{
					ParameterEnumerators.Add(key, enumerable2.GetEnumerator());
				}
			}
			List<object> list = new List<object>();
			for (int i = 0; i < num; i++)
			{
				foreach (string key2 in ParameterEnumerators.Keys)
				{
					IEnumerator enumerator5 = ParameterEnumerators[key2];
					enumerator5.MoveNext();
					Parameters[key2] = enumerator5.Current;
				}
				ParsedExpression.Accept(evaluationVisitor);
				list.Add(evaluationVisitor.Result);
			}
			return list;
		}
		ParsedExpression.Accept(evaluationVisitor);
		return evaluationVisitor.Result;
	}

	public static LogicalExpression Compile(string expression, bool noCache)
	{
		LogicalExpression logicalExpression = null;
		if (_cacheEnabled && !noCache)
		{
			try
			{
				Rwl.AcquireReaderLock(-1);
				if (_compiledExpressions.ContainsKey(expression))
				{
					WeakReference weakReference = _compiledExpressions[expression];
					logicalExpression = weakReference.Target as LogicalExpression;
					if (weakReference.IsAlive && logicalExpression != null)
					{
						return logicalExpression;
					}
				}
			}
			finally
			{
				Rwl.ReleaseReaderLock();
			}
		}
		if (logicalExpression == null)
		{
			NCalcParser nCalcParser = new NCalcParser(new CommonTokenStream(new NCalcLexer(new ANTLRStringStream(expression))));
			logicalExpression = nCalcParser.ncalcExpression().value;
			if (nCalcParser.Errors != null && nCalcParser.Errors.Count > 0)
			{
				throw new EvaluationException(string.Join(Environment.NewLine, nCalcParser.Errors.ToArray()));
			}
			if (_cacheEnabled && !noCache)
			{
				try
				{
					Rwl.AcquireWriterLock(-1);
					_compiledExpressions[expression] = new WeakReference(logicalExpression);
				}
				finally
				{
					Rwl.ReleaseWriterLock();
				}
				CleanCache();
			}
		}
		return logicalExpression;
	}

	private static void CleanCache()
	{
		List<string> list = new List<string>();
		try
		{
			Rwl.AcquireWriterLock(-1);
			foreach (KeyValuePair<string, WeakReference> compiledExpression in _compiledExpressions)
			{
				if (!compiledExpression.Value.IsAlive)
				{
					list.Add(compiledExpression.Key);
				}
			}
			foreach (string item in list)
			{
				_compiledExpressions.Remove(item);
			}
		}
		finally
		{
			Rwl.ReleaseReaderLock();
		}
	}
}
