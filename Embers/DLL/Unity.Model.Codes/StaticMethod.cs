using System.Reflection;
using Cysharp.Threading.Tasks;

public class StaticMethod : IStaticMethod
{
	private readonly MethodInfo methodInfo;

	private readonly object[] param;

	public StaticMethod(Assembly assembly, string typeName, string methodName)
	{
		this.methodInfo = assembly.GetType(typeName).GetMethod(methodName);
		MethodInfo methodInfo = this.methodInfo;
		if (methodInfo != null)
		{
			param = new object[methodInfo.GetParameters().Length];
		}
	}

	public override void Run()
	{
		methodInfo.Invoke(null, param);
	}

	public override void Run(object a)
	{
		param[0] = a;
		methodInfo.Invoke(null, param);
	}

	public override void Run(object a, object b)
	{
		param[0] = a;
		param[1] = b;
		methodInfo.Invoke(null, param);
	}

	public override void Run(object a, object b, object c)
	{
		param[0] = a;
		param[1] = b;
		param[2] = c;
		methodInfo.Invoke(null, param);
	}

	public override T Run<T>()
	{
		return (T)methodInfo.Invoke(null, param);
	}

	public override async UniTask RunAsync()
	{
		object result = methodInfo.Invoke(null, param);
		await HandleAsyncResult(result);
	}

	public override async UniTask RunAsync(object a)
	{
		param[0] = a;
		object result = methodInfo.Invoke(null, param);
		await HandleAsyncResult(result);
	}

	public override async UniTask RunAsync(object a, object b)
	{
		param[0] = a;
		param[1] = b;
		object result = methodInfo.Invoke(null, param);
		await HandleAsyncResult(result);
	}

	public override async UniTask RunAsync(object a, object b, object c)
	{
		param[0] = a;
		param[1] = b;
		param[2] = c;
		object result = methodInfo.Invoke(null, param);
		await HandleAsyncResult(result);
	}

	private async UniTask HandleAsyncResult(object result)
	{
		if (result is UniTask uniTask)
		{
			await uniTask;
		}
	}

	public override async UniTask<T> RunAsync<T>()
	{
		object result = methodInfo.Invoke(null, param);
		return await HandleAsyncResultWithReturn<T>(result);
	}

	public override async UniTask<T> RunAsync<T>(object a)
	{
		param[0] = a;
		object result = methodInfo.Invoke(null, param);
		return await HandleAsyncResultWithReturn<T>(result);
	}

	public override async UniTask<T> RunAsync<T>(object a, object b)
	{
		param[0] = a;
		param[1] = b;
		object result = methodInfo.Invoke(null, param);
		return await HandleAsyncResultWithReturn<T>(result);
	}

	public override async UniTask<T> RunAsync<T>(object a, object b, object c)
	{
		param[0] = a;
		param[1] = b;
		param[2] = c;
		object result = methodInfo.Invoke(null, param);
		return await HandleAsyncResultWithReturn<T>(result);
	}

	private async UniTask<T> HandleAsyncResultWithReturn<T>(object result)
	{
		if (result is UniTask<T> uniTask)
		{
			return await uniTask;
		}
		if (result is UniTask uniTask2)
		{
			await uniTask2;
			return default(T);
		}
		return (T)result;
	}
}
