using System;

namespace Model.ErrorAckJosn;

[Serializable]
public struct ErrorMsg
{
	public int id;

	public string errorMassage;
}
