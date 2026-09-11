using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Events;

public class QWorldLODControlledLogicScheduler
{
	private enum ModfityOp
	{
		Add,
		Remove
	}

	public List<ILODControlledLogic> scheduledLogic;

	private Dictionary<ILODControlledLogic, ModfityOp> modify;

	public UnityEvent preInit;

	private List<int> updateLogicId = new List<int>();

	private List<QWorldMapCull.QWorldCullResult> updateLogicCullResults = new List<QWorldMapCull.QWorldCullResult>();

	private const int RECORD_TICK_DT_CNT = 5;

	private float[] lastDt = new float[5];

	private bool isTicking;

	public static Bounds INVALID_BOUNDS => new Bounds(Vector3.negativeInfinity, Vector3.zero);

	public void Init()
	{
		preInit?.Invoke();
		modify = new Dictionary<ILODControlledLogic, ModfityOp>();
		if (scheduledLogic == null)
		{
			scheduledLogic = new List<ILODControlledLogic>();
		}
		foreach (ILODControlledLogic item in scheduledLogic)
		{
			item.Init();
		}
	}

	public void PreCull()
	{
		updateLogicId.Clear();
		updateLogicCullResults.Clear();
		QWorldMapCull.PrepareCullCamera(QWorldCameraManager.Instance.MainCamera);
		for (int i = 0; i < scheduledLogic.Count; i++)
		{
			ILODControlledLogic iLODControlledLogic = scheduledLogic[i];
			if (iLODControlledLogic != null)
			{
				QWorldMapCull.QWorldCullResult item = QWorldMapCull.CalcCullAABB(iLODControlledLogic.Bounds);
				bool culled = !item.visible;
				if (iLODControlledLogic is Component component && !component.gameObject.activeInHierarchy)
				{
					culled = true;
				}
				iLODControlledLogic.Culled = culled;
				iLODControlledLogic.LOD = item.lod;
				updateLogicId.Add(i);
				updateLogicCullResults.Add(item);
			}
		}
	}

	public void Update()
	{
		Tick(Time.deltaTime);
	}

	public void Tick(float dt)
	{
		for (int num = 4; num >= 1; num--)
		{
			lastDt[num] = lastDt[num - 1] + dt;
		}
		lastDt[0] = dt;
		isTicking = true;
		for (int i = 0; i < updateLogicId.Count; i++)
		{
			QWorldMapCull.QWorldCullResult cullResult = updateLogicCullResults[i];
			int num2 = updateLogicId[i];
			ILODControlledLogic iLODControlledLogic = scheduledLogic[num2];
			if (iLODControlledLogic != null)
			{
				int updateRate = iLODControlledLogic.UpdateRate;
				if (Time.frameCount % updateRate == num2 % updateRate)
				{
					iLODControlledLogic.UpdateLogic(lastDt[updateRate - 1], cullResult);
				}
			}
		}
		isTicking = false;
		ApplyModify();
	}

	internal T FindFirst<T>(List<int> idList) where T : QWorldEntityMono
	{
		Dictionary<int, T> dictionary = (from logic in scheduledLogic
			select logic as T into v
			where v != null
			select v).ToDictionary((T logic) => logic.id, (T logic) => logic);
		foreach (int id in idList)
		{
			if (dictionary.TryGetValue(id, out var value))
			{
				return value;
			}
		}
		return null;
	}

	private void ApplyModify()
	{
		if (modify.Count == 0)
		{
			return;
		}
		foreach (var (item, modfityOp2) in modify)
		{
			if (modfityOp2 == ModfityOp.Add)
			{
				scheduledLogic.Add(item);
			}
			else
			{
				scheduledLogic.Remove(item);
			}
		}
		modify.Clear();
	}

	public void RegisterLogic(ILODControlledLogic logic)
	{
		logic.Init();
		if (isTicking)
		{
			modify[logic] = ModfityOp.Add;
		}
		else
		{
			scheduledLogic.Add(logic);
		}
	}

	public void RemoveLogic(ILODControlledLogic logic)
	{
		if (isTicking)
		{
			modify[logic] = ModfityOp.Remove;
		}
		else
		{
			scheduledLogic.Remove(logic);
		}
		logic.Shutdown();
	}

	public void Dispose()
	{
		modify = null;
		scheduledLogic = null;
	}
}
