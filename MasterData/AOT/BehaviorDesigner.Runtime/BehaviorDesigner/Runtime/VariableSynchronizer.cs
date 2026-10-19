using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[AddComponentMenu("Behavior Designer/Variable Synchronizer")]
public class VariableSynchronizer : MonoBehaviour
{
	public enum SynchronizationType
	{
		BehaviorDesigner,
		Property,
		Animator,
		PlayMaker,
		uFrame
	}

	public enum AnimatorParameterType
	{
		Bool,
		Float,
		Integer
	}

	[Serializable]
	public class SynchronizedVariable
	{
		public SynchronizationType synchronizationType;

		public bool setVariable;

		public Behavior behavior;

		public string variableName;

		public bool global;

		public Component targetComponent;

		public string targetName;

		public bool targetGlobal;

		public SharedVariable targetSharedVariable;

		public Action<object> setDelegate;

		public Func<object> getDelegate;

		public Animator animator;

		public AnimatorParameterType animatorParameterType;

		public int targetID;

		public Action<SynchronizedVariable> thirdPartyTick;

		public Enum variableType;

		public object thirdPartyVariable;

		public SharedVariable sharedVariable;

		public SynchronizedVariable(SynchronizationType synchronizationType, bool setVariable, Behavior behavior, string variableName, bool global, Component targetComponent, string targetName, bool targetGlobal)
		{
			this.synchronizationType = synchronizationType;
			this.setVariable = setVariable;
			this.behavior = behavior;
			this.variableName = variableName;
			this.global = global;
			this.targetComponent = targetComponent;
			this.targetName = targetName;
			this.targetGlobal = targetGlobal;
		}
	}

	[SerializeField]
	private UpdateIntervalType updateInterval;

	[SerializeField]
	private float updateIntervalSeconds;

	private WaitForSeconds updateWait;

	[SerializeField]
	private List<SynchronizedVariable> synchronizedVariables = new List<SynchronizedVariable>();

	public UpdateIntervalType UpdateInterval
	{
		get
		{
			return updateInterval;
		}
		set
		{
			updateInterval = value;
			UpdateIntervalChanged();
		}
	}

	public float UpdateIntervalSeconds
	{
		get
		{
			return updateIntervalSeconds;
		}
		set
		{
			updateIntervalSeconds = value;
			UpdateIntervalChanged();
		}
	}

	public List<SynchronizedVariable> SynchronizedVariables
	{
		get
		{
			return synchronizedVariables;
		}
		set
		{
			synchronizedVariables = value;
			enabled = true;
		}
	}

	private void UpdateIntervalChanged()
	{
		StopCoroutine("CoroutineUpdate");
		if (updateInterval == UpdateIntervalType.EveryFrame)
		{
			enabled = true;
		}
		else if (updateInterval == UpdateIntervalType.SpecifySeconds)
		{
			if (Application.isPlaying)
			{
				updateWait = new WaitForSeconds(updateIntervalSeconds);
				StartCoroutine("CoroutineUpdate");
			}
			enabled = false;
		}
		else
		{
			enabled = false;
		}
	}

	public void Awake()
	{
		for (int num = synchronizedVariables.Count - 1; num > -1; num--)
		{
			SynchronizedVariable synchronizedVariable = synchronizedVariables[num];
			if (synchronizedVariable.global)
			{
				synchronizedVariable.sharedVariable = GlobalVariables.Instance.GetVariable(synchronizedVariable.variableName);
			}
			else
			{
				synchronizedVariable.sharedVariable = synchronizedVariable.behavior.GetVariable(synchronizedVariable.variableName);
			}
			string text = "";
			if (synchronizedVariable.sharedVariable == null)
			{
				text = "the SharedVariable can't be found";
			}
			else
			{
				switch (synchronizedVariable.synchronizationType)
				{
				case SynchronizationType.BehaviorDesigner:
				{
					Behavior behavior = synchronizedVariable.targetComponent as Behavior;
					if (behavior == null)
					{
						text = "the target component is not of type Behavior Tree";
						break;
					}
					if (synchronizedVariable.targetGlobal)
					{
						synchronizedVariable.targetSharedVariable = GlobalVariables.Instance.GetVariable(synchronizedVariable.targetName);
					}
					else
					{
						synchronizedVariable.targetSharedVariable = behavior.GetVariable(synchronizedVariable.targetName);
					}
					if (synchronizedVariable.targetSharedVariable == null)
					{
						text = "the target SharedVariable cannot be found";
					}
					break;
				}
				case SynchronizationType.Property:
				{
					PropertyInfo property = synchronizedVariable.targetComponent.GetType().GetProperty(synchronizedVariable.targetName);
					if (property == null)
					{
						text = "the property " + synchronizedVariable.targetName + " doesn't exist";
					}
					else if (synchronizedVariable.setVariable)
					{
						MethodInfo getMethod = property.GetGetMethod();
						if (getMethod == null)
						{
							text = "the property has no get method";
						}
						else
						{
							synchronizedVariable.getDelegate = CreateGetDelegate(synchronizedVariable.targetComponent, getMethod);
						}
					}
					else
					{
						MethodInfo setMethod = property.GetSetMethod();
						if (setMethod == null)
						{
							text = "the property has no set method";
						}
						else
						{
							synchronizedVariable.setDelegate = CreateSetDelegate(synchronizedVariable.targetComponent, setMethod);
						}
					}
					break;
				}
				case SynchronizationType.Animator:
				{
					synchronizedVariable.animator = synchronizedVariable.targetComponent as Animator;
					if (synchronizedVariable.animator == null)
					{
						text = "the component is not of type Animator";
						break;
					}
					synchronizedVariable.targetID = Animator.StringToHash(synchronizedVariable.targetName);
					Type propertyType = synchronizedVariable.sharedVariable.GetType().GetProperty("Value").PropertyType;
					if (propertyType.Equals(typeof(bool)))
					{
						synchronizedVariable.animatorParameterType = AnimatorParameterType.Bool;
					}
					else if (propertyType.Equals(typeof(float)))
					{
						synchronizedVariable.animatorParameterType = AnimatorParameterType.Float;
					}
					else if (propertyType.Equals(typeof(int)))
					{
						synchronizedVariable.animatorParameterType = AnimatorParameterType.Integer;
					}
					else
					{
						text = "there is no animator parameter type that can synchronize with " + propertyType;
					}
					break;
				}
				case SynchronizationType.PlayMaker:
				{
					Type typeWithinAssembly2 = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.VariableSynchronizer_PlayMaker");
					if (typeWithinAssembly2 != null)
					{
						MethodInfo method3 = typeWithinAssembly2.GetMethod("Start");
						if (!(method3 != null))
						{
							break;
						}
						switch ((int)method3.Invoke(null, new object[1] { synchronizedVariable }))
						{
						case 1:
							text = "the PlayMaker NamedVariable cannot be found";
							break;
						case 2:
							text = "the Behavior Designer SharedVariable is not the same type as the PlayMaker NamedVariable";
							break;
						default:
						{
							MethodInfo method4 = typeWithinAssembly2.GetMethod("Tick");
							if (method4 != null)
							{
								synchronizedVariable.thirdPartyTick = (Action<SynchronizedVariable>)Delegate.CreateDelegate(typeof(Action<SynchronizedVariable>), method4);
							}
							break;
						}
						}
					}
					else
					{
						text = "has the PlayMaker classes been imported?";
					}
					break;
				}
				case SynchronizationType.uFrame:
				{
					Type typeWithinAssembly = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.VariableSynchronizer_uFrame");
					if (typeWithinAssembly != null)
					{
						MethodInfo method = typeWithinAssembly.GetMethod("Start");
						if (!(method != null))
						{
							break;
						}
						switch ((int)method.Invoke(null, new object[1] { synchronizedVariable }))
						{
						case 1:
							text = "the uFrame property cannot be found";
							break;
						case 2:
							text = "the Behavior Designer SharedVariable is not the same type as the uFrame property";
							break;
						default:
						{
							MethodInfo method2 = typeWithinAssembly.GetMethod("Tick");
							if (method2 != null)
							{
								synchronizedVariable.thirdPartyTick = (Action<SynchronizedVariable>)Delegate.CreateDelegate(typeof(Action<SynchronizedVariable>), method2);
							}
							break;
						}
						}
					}
					else
					{
						text = "has the uFrame classes been imported?";
					}
					break;
				}
				}
			}
			if (!string.IsNullOrEmpty(text))
			{
				Debug.LogError($"Unable to synchronize {synchronizedVariable.sharedVariable.Name}: {text}");
				synchronizedVariables.RemoveAt(num);
			}
		}
		if (synchronizedVariables.Count == 0)
		{
			enabled = false;
		}
		else
		{
			UpdateIntervalChanged();
		}
	}

	public void Update()
	{
		Tick();
	}

	private IEnumerator CoroutineUpdate()
	{
		while (true)
		{
			Tick();
			yield return updateWait;
		}
	}

	public void Tick()
	{
		for (int i = 0; i < synchronizedVariables.Count; i++)
		{
			SynchronizedVariable synchronizedVariable = synchronizedVariables[i];
			switch (synchronizedVariable.synchronizationType)
			{
			case SynchronizationType.BehaviorDesigner:
				if (synchronizedVariable.setVariable)
				{
					synchronizedVariable.sharedVariable.SetValue(synchronizedVariable.targetSharedVariable.GetValue());
				}
				else
				{
					synchronizedVariable.targetSharedVariable.SetValue(synchronizedVariable.sharedVariable.GetValue());
				}
				break;
			case SynchronizationType.Property:
				if (synchronizedVariable.setVariable)
				{
					synchronizedVariable.sharedVariable.SetValue(synchronizedVariable.getDelegate());
				}
				else
				{
					synchronizedVariable.setDelegate(synchronizedVariable.sharedVariable.GetValue());
				}
				break;
			case SynchronizationType.Animator:
				if (synchronizedVariable.setVariable)
				{
					switch (synchronizedVariable.animatorParameterType)
					{
					case AnimatorParameterType.Bool:
						synchronizedVariable.sharedVariable.SetValue(synchronizedVariable.animator.GetBool(synchronizedVariable.targetID));
						break;
					case AnimatorParameterType.Float:
						synchronizedVariable.sharedVariable.SetValue(synchronizedVariable.animator.GetFloat(synchronizedVariable.targetID));
						break;
					case AnimatorParameterType.Integer:
						synchronizedVariable.sharedVariable.SetValue(synchronizedVariable.animator.GetInteger(synchronizedVariable.targetID));
						break;
					}
				}
				else
				{
					switch (synchronizedVariable.animatorParameterType)
					{
					case AnimatorParameterType.Bool:
						synchronizedVariable.animator.SetBool(synchronizedVariable.targetID, (bool)synchronizedVariable.sharedVariable.GetValue());
						break;
					case AnimatorParameterType.Float:
						synchronizedVariable.animator.SetFloat(synchronizedVariable.targetID, (float)synchronizedVariable.sharedVariable.GetValue());
						break;
					case AnimatorParameterType.Integer:
						synchronizedVariable.animator.SetInteger(synchronizedVariable.targetID, (int)synchronizedVariable.sharedVariable.GetValue());
						break;
					}
				}
				break;
			case SynchronizationType.PlayMaker:
			case SynchronizationType.uFrame:
				synchronizedVariable.thirdPartyTick(synchronizedVariable);
				break;
			}
		}
	}

	private static Func<object> CreateGetDelegate(object instance, MethodInfo method)
	{
		return Expression.Lambda<Func<object>>(Expression.TypeAs(Expression.Call(Expression.Constant(instance), method), typeof(object)), Array.Empty<ParameterExpression>()).Compile();
	}

	private static Action<object> CreateSetDelegate(object instance, MethodInfo method)
	{
		ConstantExpression instance2 = Expression.Constant(instance);
		ParameterExpression parameterExpression = Expression.Parameter(typeof(object), "p");
		UnaryExpression unaryExpression = Expression.Convert(parameterExpression, method.GetParameters()[0].ParameterType);
		return Expression.Lambda<Action<object>>(Expression.Call(instance2, method, unaryExpression), new ParameterExpression[1] { parameterExpression }).Compile();
	}
}
