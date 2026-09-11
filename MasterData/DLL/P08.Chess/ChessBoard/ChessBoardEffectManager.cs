using System.Collections.Generic;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardEffectManager
{
	private static ChessBoardEffectManager sInstance;

	public List<GameObject> moveList = new List<GameObject>();

	public List<GameObject> choiceList = new List<GameObject>();

	public List<GameObject> transferList = new List<GameObject>();

	public GameObject stepEffect;

	public List<GameObject> NPCDestoryEffectList = new List<GameObject>();

	private int NPCDestoryUsingIndex;

	public static ChessBoardEffectManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ChessBoardEffectManager();
			}
			return sInstance;
		}
	}

	public void ShowNormalArrow(int x, int z, int dir)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		foreach (ChessBoardGridData item in ChessBoardLuaBridge.FindNextMovePos(x, z, dir))
		{
			ChessBoardHexEntity chessBoardHexEntity2 = ChessBoardHexManager.Instance.FindEntity(item.x, item.z);
			GameObject gameObject = Asset.Instantiate("ChessBoard/Effects/fx_arrow");
			gameObject.transform.position = chessBoardHexEntity.go.transform.position;
			gameObject.transform.LookAt(chessBoardHexEntity2.go.transform);
			gameObject.transform.rotation = Quaternion.Euler(new Vector3(0f, gameObject.transform.localEulerAngles.y - 90f, 0f));
			moveList.Add(gameObject);
		}
	}

	public void ShowMultArrowEffect(int x, int z, int dir)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		foreach (ChessBoardGridData item in ChessBoardLuaBridge.FindNextMovePos(x, z, dir))
		{
			ChessBoardHexEntity chessBoardHexEntity2 = ChessBoardHexManager.Instance.FindEntity(item.x, item.z);
			GameObject gameObject = Asset.Instantiate("ChessBoard/Effects/fx_arrow");
			gameObject.transform.position = chessBoardHexEntity.go.transform.position;
			gameObject.transform.LookAt(chessBoardHexEntity2.go.transform);
			gameObject.transform.rotation = Quaternion.Euler(new Vector3(0f, gameObject.transform.localEulerAngles.y - 90f, 0f));
			moveList.Add(gameObject);
			GameObject gameObject2 = Asset.Instantiate("ChessBoard/Effects/fx_choice");
			gameObject2.transform.position = chessBoardHexEntity2.go.transform.position;
			moveList.Add(gameObject2);
		}
	}

	public void ShowChoiceEffect(int x, int z)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		GameObject gameObject = Asset.Instantiate("ChessBoard/Effects/fx_choice");
		gameObject.transform.position = chessBoardHexEntity.go.transform.position;
		choiceList.Add(gameObject);
	}

	public void ShowTranferEffect(int x, int z)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		GameObject gameObject = Asset.Instantiate("ChessBoard/Effects/fx_zhanqi_transfer");
		gameObject.transform.position = chessBoardHexEntity.go.transform.position;
		transferList.Add(gameObject);
	}

	public void ClearTranferEffect()
	{
		foreach (GameObject transfer in transferList)
		{
			PooledAsset.DestroyOrReturn(transfer);
		}
		transferList.Clear();
	}

	public void ClearMoveEffect()
	{
		foreach (GameObject move in moveList)
		{
			PooledAsset.DestroyOrReturn(move);
		}
		moveList.Clear();
	}

	public void ClearChoiceEffect()
	{
		foreach (GameObject choice in choiceList)
		{
			PooledAsset.DestroyOrReturn(choice);
		}
		choiceList.Clear();
	}

	public void ShowNPCDestoryEffectActive(int x, int z)
	{
		if (NPCDestoryEffectList.Count <= NPCDestoryUsingIndex)
		{
			NPCDestoryEffectList.Add(Asset.Instantiate("ChessBoard/Effects/fx_zhanqi_disappear"));
		}
		NPCDestoryEffectList[NPCDestoryUsingIndex].SetActive(value: true);
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
		vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
		NPCDestoryEffectList[NPCDestoryUsingIndex].transform.position = vector;
		NPCDestoryUsingIndex++;
	}

	public void ClearNPCDestoryEffect()
	{
		for (int i = 0; i < NPCDestoryEffectList.Count; i++)
		{
			NPCDestoryEffectList[i].SetActive(value: false);
		}
		NPCDestoryUsingIndex = 0;
	}

	public void DestroyAllEffect()
	{
		foreach (GameObject transfer in transferList)
		{
			PooledAsset.DestroyOrReturn(transfer);
		}
		transferList.Clear();
		foreach (GameObject move in moveList)
		{
			PooledAsset.DestroyOrReturn(move);
		}
		moveList.Clear();
		foreach (GameObject choice in choiceList)
		{
			PooledAsset.DestroyOrReturn(choice);
		}
		choiceList.Clear();
		PooledAsset.DestroyOrReturn(stepEffect);
		stepEffect = null;
		foreach (GameObject nPCDestoryEffect in NPCDestoryEffectList)
		{
			PooledAsset.DestroyOrReturn(nPCDestoryEffect);
		}
		NPCDestoryEffectList.Clear();
	}
}
