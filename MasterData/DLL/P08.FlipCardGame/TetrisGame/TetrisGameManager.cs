using Sirenix.OdinInspector;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameManager : SerializedMonoBehaviour
{
	public int width;

	public int height;

	public string stageID;

	[HideInInspector]
	public TetrisGameChipEntity editChip;

	[HideInInspector]
	public int roundChipNum;

	public int cubeSize;

	[SerializeField]
	public float chipScale;

	public int curRotateNum;

	public TetrisGameChipManager chipManager;

	public TetrisGameTileManager tileManager;

	public TetrisGameColorManager colorManager;

	public TetrisGameCustomManager customManager;

	public int chipMaxNum = 12;

	[HideInInspector]
	public bool isRunTime;

	[HideInInspector]
	public bool isCanEdit;

	[HideInInspector]
	public bool canRotate;

	public bool canCombom;

	public bool canCharge;

	public bool colorRemove;

	public int skillSpecialChipID = -1;

	public int bubbleChipPosIndex = -1;

	public int bubbleColorIndex = -1;

	public bool machineStage;

	public int lockChipShape = -1;

	public int lockChipColor = -1;

	public ChipType lockChipType;

	public bool isLock;

	public TetrisGameGuideInfo guideInfo;

	public static TetrisGameManager _instance;

	public static TetrisGameManager Instance => _instance;

	private void Awake()
	{
		_instance = this;
	}

	public void StartGame()
	{
		StartGameEnum();
		InitData();
	}

	public void InitData()
	{
		canRotate = false;
		canCombom = false;
		canCharge = false;
		colorRemove = false;
		machineStage = false;
		skillSpecialChipID = -1;
		bubbleChipPosIndex = -1;
		bubbleColorIndex = -1;
		lockChipShape = -1;
		lockChipColor = -1;
		lockChipType = ChipType.Normal;
		isLock = false;
		guideInfo = null;
	}

	public void StartGameEnum()
	{
		TetrisGameStageSaveData tetrisGameStageSaveData = TetrisGameTools.LoadScriptableObject(stageID);
		width = tetrisGameStageSaveData.width;
		height = tetrisGameStageSaveData.height;
		colorManager.InitColorList(tetrisGameStageSaveData);
		tileManager.GenerateStage(tetrisGameStageSaveData);
		chipManager.InitRunTime();
		customManager.InitCustomData(tetrisGameStageSaveData.customArray);
	}

	public void PauseGame(bool flag)
	{
		isCanEdit = !flag;
		if (!isCanEdit)
		{
			StopGame();
		}
	}

	public void StopGame()
	{
		if ((bool)editChip)
		{
			editChip.transform.SetParent(editChip.fatherTransform, worldPositionStays: true);
			editChip.ResetChip();
		}
	}

	public static Sprite GetTileTexture(int index)
	{
		return AtlasManager.GetSpriteWithoutAtlas($"TextureConfig/VersionUI/Alone_TetrisGameUI/TetrisGame/block_{index}");
	}

	public void InitRunTime(string stageID, int roundChipNum)
	{
		isRunTime = true;
		this.stageID = stageID;
		this.roundChipNum = roundChipNum;
		PauseGame(flag: true);
	}

	public void InitSkillInfo(TetrisGameExchange data)
	{
		canRotate = data.canRotate;
		canCombom = data.canCombom;
		canCharge = data.canCharge;
		colorRemove = data.colorRemove;
		skillSpecialChipID = data.skillSpecialChipID;
		bubbleChipPosIndex = data.bubbleChipPosIndex;
		bubbleColorIndex = data.bubbleColorIndex;
	}

	public void ClearGuideInfo()
	{
		guideInfo = null;
	}

	public void InitGuideInfo(TetrisGameGuideInfo info)
	{
		guideInfo = info;
	}

	public bool isMeetRightPos(TetrisGameChipEntity entity, int x, int y)
	{
		if (guideInfo != null && guideInfo.isGuide)
		{
			if (guideInfo.putInX == x && guideInfo.putInY == y)
			{
				return true;
			}
			return false;
		}
		return true;
	}

	public void SetMachineStage(bool state)
	{
		machineStage = state;
	}

	public void SetLockChip(int lockChipIndex)
	{
		if (lockChipIndex > 0 && chipManager.chipDicInstance.ContainsKey(lockChipIndex))
		{
			TetrisGameChipEntity tetrisGameChipEntity = chipManager.chipDicInstance[lockChipIndex];
			isLock = true;
			lockChipShape = tetrisGameChipEntity.chipShapeIndex;
			lockChipColor = tetrisGameChipEntity.chipColorIndex;
			lockChipType = tetrisGameChipEntity.chipType;
		}
		else
		{
			isLock = false;
			lockChipShape = -1;
			lockChipColor = -1;
			lockChipType = ChipType.Normal;
		}
	}

	public void DisposeStage()
	{
		stageID = null;
		tileManager.Dispose();
		chipManager.Dispose();
	}
}
