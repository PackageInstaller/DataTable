using System;
using UnityEngine;

namespace Chess;

[Serializable]
public class ChessMapData : ScriptableObject
{
	public new string name;

	public short width = 1;

	public short height = 1;

	public string mapNo = "01";

	[SerializeField]
	public GridData[] mapInfo;

	[SerializeField]
	public GridData[] extendInfo;
}
