using System;
using System.Reflection;
using ACT.Error;
using UnityEngine;

namespace ACT;

internal class InitLuminRuntimeData : GameLoadingFlowBase
{
	private Instructions _runtimeLoadingWaitInitialize;

	private PropertyInfo _runtimeInitializationCompletedProperty;

	private PropertyInfo _gameDataInitializationStartedProperty;

	private bool _gameDataStageApplied;

	private readonly Action _onBeforeInitialize;

	internal override EGameLoadingStage Stage
	{
		get
		{
			if (!_gameDataStageApplied)
			{
				return EGameLoadingStage.InitRuntimeData;
			}
			return EGameLoadingStage.InitGameData;
		}
	}

	public InitLuminRuntimeData(Action onBeforeInitialize = null)
	{
		_onBeforeInitialize = onBeforeInitialize;
	}

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Waiting;
		try
		{
			Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
			foreach (Assembly assembly in assemblies)
			{
				if (assembly.GetName().Name.Equals("Assembly-ACT"))
				{
					object obj = AppDomain.CurrentDomain.CreateInstanceAndUnwrap(assembly.FullName, "ACT.Initialize.LuminRuntimeInitializer");
					Type type = obj.GetType();
					MethodInfo method = type.GetMethod("InitGameDataNoneParam", BindingFlags.Instance | BindingFlags.Public);
					PropertyInfo property = type.GetProperty("WaitInstruction", BindingFlags.Static | BindingFlags.Public);
					_runtimeInitializationCompletedProperty = type.GetProperty("IsRuntimeInitializationComplete", BindingFlags.Static | BindingFlags.Public);
					_gameDataInitializationStartedProperty = type.GetProperty("IsGameDataInitializationStarted", BindingFlags.Static | BindingFlags.Public);
					if (method != null && property != null)
					{
						_onBeforeInitialize?.Invoke();
						method.Invoke(obj, null);
						UpdateRuntimeLoadingStage();
						_runtimeLoadingWaitInitialize = property.GetValue(obj) as Instructions;
						_loadState = EGameLoadingState.Loading;
					}
					else
					{
						LuminErrorAOT.ReportGameLoadingError("C01-0803", "01", 0);
						_loadState = EGameLoadingState.Failed;
					}
					return;
				}
			}
			LuminErrorAOT.ReportGameLoadingError("C01-0802", "01", 0);
			_loadState = EGameLoadingState.Failed;
		}
		catch (Exception ex)
		{
			_loadState = EGameLoadingState.Failed;
			LuminErrorAOT.ReportGameLoadingError("C01-0801", "01", 0, ex.Message);
			Debug.LogException(ex);
		}
	}

	internal override void Update()
	{
		UpdateRuntimeLoadingStage();
		if (IsRuntimeInitializationComplete())
		{
			_loadState = EGameLoadingState.Succeed;
		}
	}

	private void UpdateRuntimeLoadingStage()
	{
		if (_gameDataStageApplied || _gameDataInitializationStartedProperty == null)
		{
			return;
		}
		object value = _gameDataInitializationStartedProperty.GetValue(null);
		bool flag = default;
		int num;
		if (value is bool)
		{
			flag = (bool)value;
			num = 1;
		}
		else
		{
			num = 0;
		}
		if (((uint)num & (flag ? 1u : 0u)) != 0)
		{
			GameLoadingData.CurStage = EGameLoadingStage.InitGameData;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(EGameLoadingStage.InitGameData);
			}
			_gameDataStageApplied = true;
		}
	}

	private bool IsRuntimeInitializationComplete()
	{
		if (_runtimeInitializationCompletedProperty != null)
		{
			if (_runtimeLoadingWaitInitialize == null || _runtimeLoadingWaitInitialize.Percent < 1f)
			{
				return false;
			}
			object value = _runtimeInitializationCompletedProperty.GetValue(null);
			bool flag = default;
			int num;
			if (value is bool)
			{
				flag = (bool)value;
				num = 1;
			}
			else
			{
				num = 0;
			}
			return (byte)((uint)num & (flag ? 1u : 0u)) != 0;
		}
		if (_runtimeLoadingWaitInitialize != null)
		{
			return _runtimeLoadingWaitInitialize.Percent >= 1f;
		}
		return false;
	}
}
