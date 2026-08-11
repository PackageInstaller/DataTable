#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BossDetailManager : MonoBehaviour
{
	public Camera sceneCamera;

	public GameObject bossRoot;

	public StateItem stateItem;

	public DamageRing red;

	public DamageRing yellow;

	public float bossRotAng = -130.55f;

	public float ringRotAng = -62.3f;

	private Material tempMat;

	public float colorRatio = 0.3f;

	public int renderQueue = 2800;

	public int blendSwitch = 1;

	private GameObject monsterObj;

	private GameObject monsterObjClone;

	private string bossPath;

	public void Init()
	{
		stateItem.gameObject.SetActive(value: true);
		stateItem.CurState = 1;
		if (sceneCamera == null)
		{
			Log.Error("Boss场景 场景相机未挂载！");
			return;
		}
		GameEntry.Camera.InsertCamera(sceneCamera);
		sceneCamera.gameObject.SetActive(value: true);
	}

	public void RotateBossRoot(Vector3 delta)
	{
		bossRoot.transform.Rotate(delta);
	}

	public async Task LoadDamageRing(List<DRBoneDamageCalcData> damageCalcDatas)
	{
		foreach (DRBoneDamageCalcData damageCalcData in damageCalcDatas)
		{
			if (damageCalcData.AreaLevelUI != 0)
			{
				DamageRing damageRing = ((damageCalcData.AreaLevelUI != 1) ? red : yellow);
				damageRing.SetVal(damageCalcData.AngleUI);
			}
		}
	}

	public void Unload()
	{
		if (monsterObj != null)
		{
			Object.DestroyImmediate(monsterObj);
			monsterObj = null;
		}
		if (bossPath != null)
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetEntityAsset(bossPath));
		}
		if (monsterObjClone != null)
		{
			Object.DestroyImmediate(monsterObjClone);
			monsterObjClone = null;
		}
		bossRoot.transform.rotation = Quaternion.Euler(Vector3.zero);
		stateItem.gameObject.SetActive(value: false);
		if (sceneCamera == null)
		{
			Log.Error("Boss场景 场景相机未挂载！");
			return;
		}
		GameEntry.Camera.RemoveCamera(sceneCamera);
		sceneCamera.gameObject.SetActive(value: false);
	}
}
