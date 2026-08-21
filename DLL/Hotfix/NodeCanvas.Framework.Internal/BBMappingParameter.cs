using System;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public class BBMappingParameter : BBObjectParameter
{
	[SerializeField]
	private string _targetSubGraphVariableID;

	[SerializeField]
	private bool _canRead;

	[SerializeField]
	private bool _canWrite;

	public string targetSubGraphVariableID => _targetSubGraphVariableID;

	public bool canRead
	{
		get
		{
			return _canRead;
		}
		set
		{
			_canRead = value;
		}
	}

	public bool canWrite
	{
		get
		{
			return _canWrite;
		}
		set
		{
			_canWrite = value;
		}
	}

	public BBMappingParameter()
	{
	}

	public BBMappingParameter(Variable subVariable)
	{
		_targetSubGraphVariableID = subVariable.ID;
		SetType(subVariable.varType);
	}
}
