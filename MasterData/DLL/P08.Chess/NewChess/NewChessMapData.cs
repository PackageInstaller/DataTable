using System;
using UnityEngine;

namespace NewChess;

[Serializable]
public class NewChessMapData : ScriptableObject
{
	public new string name;

	public short width = 1;

	public short height = 1;

	public string mapNo = "01";

	[SerializeField]
	public NewGridData[] mapInfo;

	[SerializeField]
	public NewGridData[] extendInfo;

	[SerializeField]
	public NewGridData[] thingExtendInfo;
}
