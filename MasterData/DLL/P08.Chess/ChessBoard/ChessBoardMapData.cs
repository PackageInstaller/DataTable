using System;
using UnityEngine;

namespace ChessBoard;

[Serializable]
public class ChessBoardMapData : ScriptableObject
{
	public new string name;

	public short width = 1;

	public short height = 1;

	public string mapNo = "01";

	[SerializeField]
	public ChessBoardGridData[] mapInfo;

	[SerializeField]
	public ChessBoardGridData[] extendInfo;

	[SerializeField]
	public ChessBoardGridData[] thingExtendInfo;
}
