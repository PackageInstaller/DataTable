using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class GMMonsterAI : MonoBehaviour
{
	private long monsterId;

	private bool haveAIScript;

	private bool isSequence;

	private bool isPool;

	private MonsterAdventureActor monsterAdventureActor;

	private Monster monsterData;

	private Dictionary<string, GameObject> dicLogicTag = new Dictionary<string, GameObject>();

	private Dictionary<int, GameObject> dicBuff = new Dictionary<int, GameObject>();

	private Dictionary<int, List<GameObject>> dicEffect = new Dictionary<int, List<GameObject>>();

	private int runSkillCount;

	public Button btnClose;

	public Button btnSave;

	public TextMeshProUGUI texId;

	public TextMeshProUGUI texAction;

	public TextMeshProUGUI texParallel;

	public TextMeshProUGUI texStage;

	public TextMeshProUGUI texbehavior;

	public TextMeshProUGUI texSkill;

	public Transform LogicTagRoot;

	public GameObject LogicTagItem;

	public Transform buffRoot;

	public GameObject buffItem;

	public Transform effectRoot;

	public GameObject effectItem;

	private Dictionary<int, GameObject> branchAISkillDic = new Dictionary<int, GameObject>();

	private Dictionary<int, GameObject> branchAIRunDic = new Dictionary<int, GameObject>();

	public GameObject objAIBranch;

	public Transform BranchSkillRoot;

	public GameObject BranchSkillItem;

	public Transform RunBranchSkillRoot;

	public GameObject RunBranchSkillItem;

	private GameObject objGreen;

	private Dictionary<int, GameObject> sequenceAISkillDic = new Dictionary<int, GameObject>();

	private Dictionary<int, GameObject> sequenceAIRunDic = new Dictionary<int, GameObject>();

	public GameObject objAISequence;

	public Transform SequenceSkillRoot;

	public GameObject SequenceSkillItem;

	public Transform RunSequenceSkillRoot;

	public GameObject RunSequenceSkillItem;

	private Dictionary<int, GameObject> poolAISkillDic = new Dictionary<int, GameObject>();

	private Dictionary<int, GameObject> poolAIRunDic = new Dictionary<int, GameObject>();

	public GameObject objAIPool;

	public Transform PoolSkillRoot;

	public GameObject PoolSkillItem;

	public Transform RunPoolSkillRoot;

	public GameObject RunPoolSkillItem;

	public readonly List<GMMonsterAIMsg> listGMMonsterAIMsg = new List<GMMonsterAIMsg>();

	private void Start()
	{
		btnClose.onClick.AddListener(OnClickClose);
		btnSave.onClick.AddListener(OnClickSave);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_EFFECT", OnGetEffect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_EFFECT", OnRemoveEffect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RUN_BRANCH", OnActorRunBranch);
	}

	private void ClearData()
	{
		listGMMonsterAIMsg.Clear();
		isSequence = false;
		isPool = false;
		objGreen = null;
		foreach (KeyValuePair<string, GameObject> item in dicLogicTag)
		{
			Object.Destroy(item.Value);
		}
		dicLogicTag.Clear();
		foreach (KeyValuePair<int, GameObject> item2 in dicBuff)
		{
			Object.Destroy(item2.Value);
		}
		dicBuff.Clear();
		foreach (KeyValuePair<int, List<GameObject>> item3 in dicEffect)
		{
			for (int i = 0; i < item3.Value.Count; i++)
			{
				Object.Destroy(item3.Value.get_Item(i));
			}
		}
		dicEffect.Clear();
		foreach (KeyValuePair<int, GameObject> item4 in branchAISkillDic)
		{
			Object.Destroy(item4.Value);
		}
		branchAISkillDic.Clear();
		foreach (KeyValuePair<int, GameObject> item5 in branchAIRunDic)
		{
			Object.Destroy(item5.Value);
		}
		branchAIRunDic.Clear();
		foreach (KeyValuePair<int, GameObject> item6 in sequenceAISkillDic)
		{
			Object.Destroy(item6.Value);
		}
		sequenceAISkillDic.Clear();
		foreach (KeyValuePair<int, GameObject> item7 in sequenceAIRunDic)
		{
			Object.Destroy(item7.Value);
		}
		sequenceAIRunDic.Clear();
		foreach (KeyValuePair<int, GameObject> item8 in poolAISkillDic)
		{
			Object.Destroy(item8.Value);
		}
		poolAISkillDic.Clear();
		foreach (KeyValuePair<int, GameObject> item9 in poolAIRunDic)
		{
			Object.Destroy(item9.Value);
		}
		poolAIRunDic.Clear();
		runSkillCount = 0;
		monsterAdventureActor = null;
	}

	public void SetMonsterId(long id)
	{
		if (monsterId != id)
		{
			ClearData();
		}
		monsterId = id;
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterId);
		monsterAdventureActor = logicEntity as MonsterAdventureActor;
		monsterData = Singleton<HotfixDataController>.Instance.GetMonster(monsterAdventureActor.dataID);
		texId.text = monsterData.FCId + "|" + monsterData.Name;
		AddMessage("怪物AIID", texId.text);
		MonsterAI monsterAI = Singleton<HotfixDataController>.Instance.GetMonsterAI(monsterData.FCId);
		haveAIScript = monsterAI.ActionAIPath != "";
		texAction.text = ((monsterAI != null) ? monsterAI.ActionAIPath : "");
		AddMessage("战斗AI脚本", texAction.text);
		texParallel.text = ((monsterAI != null) ? monsterAI.ParallelAIPath : "");
		AddMessage("并行AI脚本", texParallel.text);
		if (monsterData.EpicLv == 2)
		{
			texStage.text = "0";
		}
		else
		{
			texStage.text = "0";
		}
		List<BuffEntity> entityBuffList = AdventureModuleHelper.GetEntityBuffList(monsterId);
		if (entityBuffList != null)
		{
			for (int i = 0; i < entityBuffList.Count; i++)
			{
				BuffEntity buffEntity = entityBuffList.get_Item(i);
				GameObject gameObject = Object.Instantiate(buffItem, buffRoot);
				gameObject.SetActive(value: true);
				dicBuff.Add(buffEntity.buffConfig.Id, gameObject);
				Buff buff = Singleton<HotfixDataController>.Instance.GetBuff(buffEntity.buffConfig.Id);
				gameObject.GetComponent<TextMeshProUGUI>().text = $"buffId：{buffEntity.buffConfig.Id}   备注名：{buff.Name}";
			}
		}
		List<int> entityEffectList = AdventureModuleHelper.GetEntityEffectList(monsterId);
		if (entityEffectList != null)
		{
			for (int j = 0; j < entityEffectList.Count; j++)
			{
				int num = entityEffectList.get_Item(j);
				if (!dicEffect.ContainsKey(num))
				{
					List<GameObject> value = new List<GameObject>();
					dicEffect.Add(num, value);
				}
				GameObject gameObject2 = Object.Instantiate(effectItem, effectRoot);
				gameObject2.SetActive(value: true);
				dicEffect.get_Item(num).Add(gameObject2);
				Effect effect = Singleton<HotfixDataController>.Instance.GetEffect(num);
				gameObject2.GetComponent<TextMeshProUGUI>().text = $"effectId：{num}   备注名：{effect.Name}";
			}
		}
		if (!haveAIScript)
		{
			objAIBranch.SetActive(value: true);
			objAISequence.SetActive(value: false);
			objAIPool.SetActive(value: false);
			List<int> list = monsterAI.ActionBranchIds.ToList();
			for (int k = 0; k < list.Count; k++)
			{
				MonsterActionBranch monsterActionBranch = Singleton<HotfixDataController>.Instance.GetMonsterActionBranch(list.get_Item(k));
				GameObject gameObject3 = Object.Instantiate(BranchSkillItem, BranchSkillRoot);
				gameObject3.SetActive(value: true);
				branchAISkillDic.set_Item(monsterActionBranch.Id, gameObject3);
				SetBranchMsg(gameObject3, monsterActionBranch);
			}
		}
		else
		{
			objAISequence.SetActive(value: false);
			objAIPool.SetActive(value: false);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_AILIST_INFO", OnAIListInfo);
			objAIBranch.SetActive(value: false);
			AdventureMonsterIDAIListEvent adventureMonsterIDAIListEvent = AdventureMonsterIDAIListEvent.Generate();
			adventureMonsterIDAIListEvent.monsterId = monsterId;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterIDAIListEvent);
		}
	}

	private void OnClickClose()
	{
		Object.Destroy(gameObject);
	}

	private void OnClickSave()
	{
	}

	private void Update()
	{
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		texbehavior.text = $"{monsterAdventureActor.state} --> {monsterAdventureActor.movementState} --> {monsterAdventureActor.attackState}";
		AdventureSkill firstSkill = monsterAdventureActor.actorSkillManage.FirstSkill;
		texSkill.text = ((firstSkill != null) ? $"skill_{firstSkill.skillId}" : "");
		foreach (KeyValuePair<string, LogicVariable.LogicTag> logicTag in monsterAdventureActor.logicVariable.GetLogicTags())
		{
			if (dicLogicTag.ContainsKey(logicTag.Key))
			{
				var (text, text2) = GetLogicTagType(logicTag.Value);
				dicLogicTag.get_Item(logicTag.Key).GetComponent<TextMeshProUGUI>().text = "逻辑标签名：" + logicTag.Key + "   逻辑标签类型：" + text + "  逻辑标签值：" + text2;
			}
			else
			{
				GameObject gameObject = Object.Instantiate(LogicTagItem, LogicTagRoot);
				gameObject.SetActive(value: true);
				dicLogicTag.Add(logicTag.Key, gameObject);
				var (text3, text4) = GetLogicTagType(logicTag.Value);
				gameObject.GetComponent<TextMeshProUGUI>().text = "逻辑标签名：" + logicTag.Key + "   逻辑标签类型：" + text3 + "  逻辑标签值：" + text4;
			}
			if (logicTag.Key == "Monster_In_State")
			{
				string[] array = logicTag.Value.stringValue.Split(',');
				CommonHelper.TryParseStringParamToInt(array[array.Length - 1], out var intValue);
				texStage.text = intValue.ToString();
			}
		}
	}

	private (string, string) GetLogicTagType(LogicVariable.LogicTag tag)
	{
		if (tag.type == LogicVariable.LogicType.Number)
		{
			return ("Number", tag.numberValue.ToString());
		}
		if (tag.type == LogicVariable.LogicType.String)
		{
			return ("String", tag.stringValue);
		}
		if (tag.type == LogicVariable.LogicType.TSVector2)
		{
			return ("TSVector2", $"{tag.tsVec2Value.x},{tag.tsVec2Value.y}");
		}
		return ("Number", "1");
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && (adventureActorGetBuff.sender as AdventureActor).Id == monsterId && !dicBuff.ContainsKey(adventureActorGetBuff.eventInfo.buffId))
		{
			GameObject gameObject = Object.Instantiate(buffItem, buffRoot);
			gameObject.SetActive(value: true);
			dicBuff.Add(adventureActorGetBuff.eventInfo.buffId, gameObject);
			Buff buff = Singleton<HotfixDataController>.Instance.GetBuff(adventureActorGetBuff.eventInfo.buffId);
			gameObject.GetComponent<TextMeshProUGUI>().text = $"buffId：{adventureActorGetBuff.eventInfo.buffId}   备注名：{buff.Name}";
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: AdventureActor sender } adventureActorRemoveBuff && sender.Id == monsterId && dicBuff.ContainsKey(adventureActorRemoveBuff.eventInfo.buffId) && monsterAdventureActor.buffComponent.GetBuffNumByID(adventureActorRemoveBuff.eventInfo.buffId) <= 1)
		{
			Object.Destroy(dicBuff.get_Item(adventureActorRemoveBuff.eventInfo.buffId));
			dicBuff.Remove(adventureActorRemoveBuff.eventInfo.buffId);
		}
	}

	private void OnGetEffect(IEvent evt)
	{
		if (!(evt is AdventureActorGetEffect adventureActorGetEffect))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorGetEffect.sender as AdventureActor;
		if (!(adventureActor == null) && adventureActor.Id == monsterId)
		{
			int effectId = adventureActorGetEffect.effectId;
			if (!dicEffect.ContainsKey(effectId))
			{
				List<GameObject> value = new List<GameObject>();
				dicEffect.Add(effectId, value);
			}
			GameObject gameObject = Object.Instantiate(effectItem, effectRoot);
			gameObject.SetActive(value: true);
			dicEffect.get_Item(effectId).Add(gameObject);
			Effect effect = Singleton<HotfixDataController>.Instance.GetEffect(effectId);
			gameObject.GetComponent<TextMeshProUGUI>().text = $"effectId：{effectId}   备注名：{effect.Name}";
		}
	}

	private void OnRemoveEffect(IEvent evt)
	{
		if (!(evt is AdventureActorRemoveEffect adventureActorRemoveEffect))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorRemoveEffect.sender as AdventureActor;
		if (!(adventureActor == null) && adventureActor.Id == monsterId)
		{
			int effectId = adventureActorRemoveEffect.effectId;
			if (dicEffect.ContainsKey(effectId) && dicEffect.get_Item(effectId).Count > 0)
			{
				GameObject obj = dicEffect.get_Item(effectId).get_Item(0);
				dicEffect.get_Item(effectId).RemoveAt(0);
				Object.Destroy(obj);
			}
		}
	}

	private void OnActorCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
		if (!(adventureActor == null) && adventureActor.Id == monsterId && haveAIScript)
		{
			runSkillCount++;
			if (isSequence)
			{
				SetSequenceRunSkillMsg(adventureActorCastSkillEvent.skillEventInfo.skillId, runSkillCount);
			}
			else if (isPool)
			{
				SetPoolRunSkillMsg(adventureActorCastSkillEvent.skillEventInfo.skillId, runSkillCount);
			}
		}
	}

	private void OnActorRunBranch(IEvent evt)
	{
		if (evt is AdventureActorRunBranchEvent adventureActorRunBranchEvent)
		{
			AdventureActor adventureActor = adventureActorRunBranchEvent.sender as AdventureActor;
			if (!(adventureActor == null) && adventureActor.Id == monsterId && !haveAIScript)
			{
				runSkillCount++;
				GameObject gameObject = Object.Instantiate(RunBranchSkillItem, RunBranchSkillRoot);
				gameObject.SetActive(value: true);
				branchAIRunDic.set_Item(runSkillCount, gameObject);
				SetBranchRunSkillMsg(gameObject, adventureActorRunBranchEvent.branchId, runSkillCount);
			}
		}
	}

	private void SetBranchMsg(GameObject obj, MonsterActionBranch data)
	{
		obj.transform.Find("id").GetComponent<TextMeshProUGUI>().text = data.Id.ToString();
		obj.transform.Find("name").GetComponent<TextMeshProUGUI>().text = "";
		obj.transform.Find("skillId").GetComponent<TextMeshProUGUI>().text = data.SkillId.ToString();
		obj.transform.Find("priority").GetComponent<TextMeshProUGUI>().text = data.Priority.ToString();
		obj.transform.Find("cd").GetComponent<TextMeshProUGUI>().text = (data.CD / 10000).ToString();
		obj.transform.Find("activate").GetComponent<TextMeshProUGUI>().text = (data.Activate ? "是" : "否");
		obj.transform.Find("count").GetComponent<TextMeshProUGUI>().text = "0";
		obj.transform.Find("red").gameObject.SetActive(!data.Activate);
	}

	private void SetBranchRunSkillMsg(GameObject obj, int branchId, int index)
	{
		if (branchAISkillDic.ContainsKey(branchId))
		{
			MonsterActionBranch monsterActionBranch = Singleton<HotfixDataController>.Instance.GetMonsterActionBranch(branchId);
			obj.transform.Find("index").GetComponent<TextMeshProUGUI>().text = index.ToString();
			obj.transform.Find("branchid").GetComponent<TextMeshProUGUI>().text = monsterActionBranch.Id.ToString();
			obj.transform.Find("name").GetComponent<TextMeshProUGUI>().text = "";
			obj.transform.Find("skillid").GetComponent<TextMeshProUGUI>().text = monsterActionBranch.SkillId.ToString();
			obj.transform.Find("priority").GetComponent<TextMeshProUGUI>().text = monsterActionBranch.Priority.ToString();
			obj.transform.Find("cd").GetComponent<TextMeshProUGUI>().text = (monsterActionBranch.CD / 10000).ToString();
			int num = CommonHelper.ParseStringParamToInt(branchAISkillDic.get_Item(branchId).transform.Find("count").GetComponent<TextMeshProUGUI>().text);
			branchAISkillDic.get_Item(branchId).transform.Find("count").GetComponent<TextMeshProUGUI>().text = (num + 1).ToString();
			if (objGreen != null)
			{
				objGreen.SetActive(value: false);
			}
			objGreen = branchAISkillDic.get_Item(branchId).transform.Find("green").gameObject;
			objGreen.SetActive(value: true);
			branchAISkillDic.get_Item(branchId).transform.Find("red").gameObject.SetActive(value: false);
			branchAISkillDic.get_Item(branchId).transform.Find("activate").GetComponent<TextMeshProUGUI>().text = "是";
			AddMessage("Branch技能调用", "", index, monsterActionBranch.Id, monsterActionBranch.SkillId, monsterActionBranch.Priority, (float)monsterActionBranch.CD / 10000f);
		}
	}

	private void OnAIListInfo(IEvent evt)
	{
		if (!(evt is AdventureActorAIListInfoEvent adventureActorAIListInfoEvent) || adventureActorAIListInfoEvent.monsterId != monsterId)
		{
			return;
		}
		if (adventureActorAIListInfoEvent.sequenceDict != null)
		{
			isSequence = true;
			objAISequence.SetActive(value: true);
			foreach (KeyValuePair<int, List<int>> item in adventureActorAIListInfoEvent.sequenceDict)
			{
				GameObject gameObject = Object.Instantiate(SequenceSkillItem, SequenceSkillRoot);
				gameObject.SetActive(value: true);
				sequenceAISkillDic.set_Item(item.Key, gameObject);
				gameObject.transform.Find("id").GetComponent<TextMeshProUGUI>().text = item.Key.ToString();
				TextMeshProUGUI component = gameObject.transform.Find("sequence").GetComponent<TextMeshProUGUI>();
				component.text = "";
				for (int i = 0; i < item.Value.Count; i++)
				{
					component.text = component.text + item.Value.get_Item(i) + ",";
				}
			}
		}
		else if (adventureActorAIListInfoEvent.poolBranchDict != null)
		{
			isPool = true;
			objAIPool.SetActive(value: true);
			foreach (KeyValuePair<int, List<Dictionary<int, bool>>> item2 in adventureActorAIListInfoEvent.poolBranchDict)
			{
				for (int j = 0; j < item2.Value.Count; j++)
				{
					foreach (KeyValuePair<int, bool> item3 in item2.Value.get_Item(j))
					{
						GameObject gameObject2 = Object.Instantiate(PoolSkillItem, PoolSkillRoot);
						gameObject2.SetActive(value: true);
						poolAISkillDic.set_Item(item2.Key * 10000 + item3.Key, gameObject2);
						gameObject2.transform.Find("id").GetComponent<TextMeshProUGUI>().text = item2.Key.ToString();
						gameObject2.transform.Find("actionid").GetComponent<TextMeshProUGUI>().text = item3.Key.ToString();
						gameObject2.transform.Find("active").GetComponent<TextMeshProUGUI>().text = (item3.Value ? "是" : "否");
					}
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_AILIST_INFO", OnAIListInfo);
	}

	private void SetSequenceRunSkillMsg(int skillId, int index)
	{
		GameObject gameObject = Object.Instantiate(RunPoolSkillItem, RunSequenceSkillRoot);
		gameObject.SetActive(value: true);
		gameObject.transform.Find("index").GetComponent<TextMeshProUGUI>().text = index.ToString();
		gameObject.transform.Find("branchid").GetComponent<TextMeshProUGUI>().text = "";
		gameObject.transform.Find("name").GetComponent<TextMeshProUGUI>().text = "";
		gameObject.transform.Find("skillid").GetComponent<TextMeshProUGUI>().text = skillId.ToString();
		sequenceAIRunDic.set_Item(index, gameObject);
		AddMessage("Sequence技能调用", "", index, 0, skillId);
	}

	private void SetPoolRunSkillMsg(int skillId, int index)
	{
		GameObject gameObject = Object.Instantiate(RunSequenceSkillItem, RunPoolSkillRoot);
		gameObject.SetActive(value: true);
		gameObject.transform.Find("index").GetComponent<TextMeshProUGUI>().text = index.ToString();
		gameObject.transform.Find("branchid").GetComponent<TextMeshProUGUI>().text = "";
		gameObject.transform.Find("name").GetComponent<TextMeshProUGUI>().text = "";
		gameObject.transform.Find("skillid").GetComponent<TextMeshProUGUI>().text = skillId.ToString();
		poolAIRunDic.set_Item(index, gameObject);
		AddMessage("Pool技能调用", "", index, 0, skillId);
	}

	private void OnDestroy()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_EFFECT", OnGetEffect);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_REMOVE_EFFECT", OnRemoveEffect);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RUN_BRANCH", OnActorRunBranch);
		ClearData();
		btnClose.onClick.RemoveListener(OnClickClose);
		btnSave.onClick.RemoveListener(OnClickSave);
	}

	private void AddMessage(string style, string message = "", int index = 0, int branchId = 0, int skillId = 0, int priority = 0, float cd = 0f, string stractive = "", int count = 0)
	{
		GMMonsterAIMsg item = new GMMonsterAIMsg
		{
			统计类型 = style,
			信息 = message,
			执行序列 = index,
			BranchID = branchId,
			SkillID = skillId,
			优先级 = priority,
			CD = cd,
			当前是否激活 = stractive,
			调用次数 = count
		};
		listGMMonsterAIMsg.Add(item);
	}
}
