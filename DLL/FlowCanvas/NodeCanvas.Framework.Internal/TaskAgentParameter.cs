using System;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public class TaskAgentParameter : BBParameter<UnityEngine.Object>
{
	public new UnityEngine.Object value
	{
		get
		{
			if (base.useBlackboard)
			{
				UnityEngine.Object obj = base.value;
				if (obj is GameObject)
				{
					return (obj as GameObject).transform;
				}
				if (obj is Component)
				{
					return (Component)obj;
				}
				return null;
			}
			return _value as Component;
		}
		set
		{
			_value = value;
		}
	}

	protected override object objectValue
	{
		get
		{
			return value;
		}
		set
		{
			this.value = (UnityEngine.Object)value;
		}
	}
}
