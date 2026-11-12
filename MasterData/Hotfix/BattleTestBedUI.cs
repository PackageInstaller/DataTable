using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.UI;

public class BattleTestBedUI : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	public class classSkin
	{
		public int charId;

		public int Id;

		public string name;

		public string skinName;
	}

	public class classComboClip
	{
		public string clipName;

		public ComboClip clip;
	}

	public class _classMonsterLo
	{
		public TSVector2 position;

		public FP positionY;

		public FP rotation;
	}

	public GameObject joystick;

	public Dropdown dropType;

	public Dropdown dropCharacter;

	public Text texCharacter;

	public Dropdown dropSkin;

	public Text texSkin;

	public GameObject skinDrop;

	public Dropdown dropMusicType;

	public Text texMusicName;

	public Dropdown dropCombo;

	public Text texClipName;

	public Dropdown dropTag;

	public GameObject objLoopOn;

	public GameObject objLoopOff;

	public GameObject objHitBoxOn;

	public GameObject objHitBoxOff;

	public Slider sliderSpeed;

	public Text texSpeed;

	private float speed;

	public Text texFrame;

	private int _totalFrame;

	private string strFrame = "[帧数：{0}/{1}]";

	private float _playTime;

	private bool _isPlayClip;

	public InputField inputCharId;

	private int _dropTypeIndex;

	private int _charactorIndex;

	private int _tmpCharId;

	private int _tmpCharacterActorId;

	private int _tmpSkinId;

	private AdventureActor _player;

	private ComboClip _comboClip;

	private string _clipTag = "默认";

	private int _clipIndex;

	private Vector2 _movementInputVector;

	private Vector2 _movementInputDirection;

	private Vector2 _lastInputDirection = Vector2.zero;

	private Vector2 _lastDirection = Vector2.zero;

	private string _musicName;

	private bool isLoopPlayClip;

	private bool isHitBox;

	private Dictionary<int, classSkin> characterSkinDic = new Dictionary<int, classSkin>();

	private Dictionary<int, List<classSkin>> characterSkinData = new Dictionary<int, List<classSkin>>();

	private Dictionary<int, classSkin> monsterSkinDic = new Dictionary<int, classSkin>();

	private Dictionary<int, classComboClip> playerComboClipDic = new Dictionary<int, classComboClip>();

	public List<string> musicName = new List<string>();

	private List<string> ComboTagcName = new List<string>();

	private float cameraAngleValue;

	private float cameraRotationAngleValue;

	private LogicEntity selectTarget;

	public GameObject objBlock;

	private bool isDrag;

	private Vector3 startDragPosition;

	private Vector3 endDragPosition;

	private Dictionary<long, _classMonsterLo> monsterPos = new Dictionary<long, _classMonsterLo>();

	private string _tmpComboName;

	private string _tmpTagame;

	private void Start()
	{
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			_classMonsterLo classMonsterLo = new _classMonsterLo();
			classMonsterLo.position = monsterAdventureActor.tsTransform.Position;
			classMonsterLo.positionY = monsterAdventureActor.tsTransform.PositionY;
			classMonsterLo.rotation = monsterAdventureActor.tsTransform.Rotation;
			monsterPos.Add(monsterAdventureActor.Id, classMonsterLo);
		}
		cameraAngleValue = SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle;
		cameraRotationAngleValue = SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle;
		SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationDuration = 0.1f;
		SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.GetComponent<AdventureActor>().EnterStun();
		SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.GetComponent<AdventureActor>().EnableHideModel();
		SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.GetComponent<AdventureActor>().EnableIgnoreDeterministicCollision();
		for (int j = 0; j < GameObject.Find("BlobIndicators(Clone)").transform.childCount; j++)
		{
			GameObject.Find("BlobIndicators(Clone)").transform.GetChild(j).gameObject.SetActive(value: false);
		}
		CrossPlatformInputManager.UnRegisterVirtualJoystick("Horizontal", "Vertical");
		CrossPlatformInputManager.RegisterVirtualJoystick("Horizontal", "Vertical", joystick);
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		GameObject.Find("==== Obstacles ====").gameObject.SetActive(value: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnPlayerSpawn);
		initData();
		dropType.onValueChanged.AddListener(ChangeDropType);
		dropCharacter.onValueChanged.AddListener(ChangeDropCharacter);
		dropSkin.onValueChanged.AddListener(ChangeDropSkin);
		dropMusicType.onValueChanged.AddListener(ChangeMusicName);
		dropCombo.onValueChanged.AddListener(ChangeplayerCombo);
		dropTag.onValueChanged.AddListener(ChangeClipTag);
		SetDropCharacterValue(_dropTypeIndex);
		SetMusicValue();
		texSpeed.text = sliderSpeed.value + "x";
		speed = sliderSpeed.value;
		sliderSpeed.onValueChanged.AddListener((float val) =>
		{
			ChangeSpeedSlide(val);
		});
		StartCoroutine(WaitLoadCache());
	}

	private IEnumerator WaitLoadCache()
	{
		yield return new WaitForSeconds(0.5f);
		int num = PlayerPrefs.GetInt("ComboClip_Tool_TypeIndex", 0);
		int _CharId = PlayerPrefs.GetInt("ComboClip_Tool_CharId", 0);
		int num2 = PlayerPrefs.GetInt("ComboClip_Tool_Skin", 0);
		_tmpComboName = PlayerPrefs.GetString("ComboClip_Tool_Combo", "无");
		_tmpTagame = PlayerPrefs.GetString("ComboClip_Tool_ClipTag", "默认");
		if (_CharId != 0)
		{
			dropSkin.ClearOptions();
			if (num == 0)
			{
				foreach (KeyValuePair<int, classSkin> item in characterSkinDic)
				{
					if (item.Value.charId == _CharId)
					{
						_tmpCharId = _CharId;
						texCharacter.text = item.Value.name;
						List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
						for (int i = 0; i < characterSkinData.get_Item(_tmpCharId).Count; i++)
						{
							list.Add(new Dropdown.OptionData(characterSkinData.get_Item(_tmpCharId).get_Item(i).skinName));
						}
						dropSkin.AddOptions(list);
						dropSkin.value = num2;
						if (num2 == 0)
						{
							StartCoroutine(LoadProModel(num2));
						}
						break;
					}
				}
			}
			else
			{
				_tmpTagame = "默认";
				_dropTypeIndex = 1;
				dropType.value = 1;
				yield return new WaitForSeconds(1f);
				int num3 = 0;
				foreach (KeyValuePair<int, classSkin> item2 in monsterSkinDic)
				{
					if (item2.Value.charId == _CharId)
					{
						_tmpCharId = _CharId;
						texCharacter.text = item2.Value.name;
						dropSkin.value = 0;
						StartCoroutine(LoadProModel(num3));
						break;
					}
					num3++;
				}
			}
		}
		yield return new WaitForSeconds(2f);
		_tmpComboName = string.Empty;
		_tmpTagame = string.Empty;
		objBlock.SetActive(value: false);
	}

	private void initData()
	{
		int num = 0;
		classSkin classSkin2 = new classSkin();
		classSkin2.charId = 0;
		classSkin2.Id = 0;
		classSkin2.name = "无";
		characterSkinDic.Add(num, classSkin2);
		Dictionary<int, CharacterSkin> dictionary = Singleton<HotfixDataController>.Instance.CharacterSkinData;
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, CharacterSkin> item in dictionary)
		{
			if (!list.Contains(item.Value.CharId))
			{
				list.Add(item.Value.CharId);
				num++;
				classSkin classSkin3 = new classSkin();
				string[] array = item.Value.Name.Split("_");
				classSkin3.name = item.Value.CharId + "_" + array[0];
				classSkin3.charId = item.Value.CharId;
				classSkin3.Id = item.Value.Id;
				classSkin3.skinName = item.Value.Id + "_" + item.Value.Name;
				characterSkinDic.Add(num, classSkin3);
				List<classSkin> list2 = new List<classSkin>();
				list2.Add(classSkin3);
				characterSkinData.Add(item.Value.CharId, list2);
			}
			else
			{
				classSkin classSkin4 = new classSkin();
				item.Value.Name.Split("_");
				classSkin4.charId = item.Value.CharId;
				classSkin4.Id = item.Value.Id;
				classSkin4.skinName = item.Value.Id + "_" + item.Value.Name;
				characterSkinData.get_Item(item.Value.CharId).Add(classSkin4);
			}
		}
		int num2 = 0;
		classSkin classSkin5 = new classSkin();
		classSkin5.charId = 0;
		classSkin5.name = "无";
		monsterSkinDic.Add(num2, classSkin5);
		foreach (KeyValuePair<int, Monster> monsterDatum in Singleton<HotfixDataController>.Instance.MonsterData)
		{
			num2++;
			classSkin classSkin6 = new classSkin();
			classSkin6.name = monsterDatum.Value.Id + "_" + monsterDatum.Value.Name;
			classSkin6.charId = monsterDatum.Value.Id;
			classSkin6.Id = monsterDatum.Value.FAId;
			monsterSkinDic.Add(num2, classSkin6);
		}
	}

	private void SetDropCharacterValue(int index)
	{
		if (_player != null)
		{
			dropCombo.ClearOptions();
			dropTag.ClearOptions();
			_player.DestroySelf();
			_player = null;
		}
		dropCharacter.ClearOptions();
		List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
		if (index == 0)
		{
			foreach (KeyValuePair<int, classSkin> item in characterSkinDic)
			{
				list.Add(new Dropdown.OptionData(item.Value.name));
			}
		}
		else
		{
			foreach (KeyValuePair<int, classSkin> item2 in monsterSkinDic)
			{
				list.Add(new Dropdown.OptionData(item2.Value.name));
			}
		}
		dropCharacter.AddOptions(list);
		dropCharacter.value = 0;
		dropSkin.ClearOptions();
		dropSkin.AddOptions(new List<Dropdown.OptionData>
		{
			new Dropdown.OptionData("无")
		});
		dropCombo.ClearOptions();
		dropCombo.AddOptions(new List<Dropdown.OptionData>
		{
			new Dropdown.OptionData("无")
		});
		dropTag.ClearOptions();
		dropTag.AddOptions(new List<Dropdown.OptionData>
		{
			new Dropdown.OptionData("默认")
		});
		_isPlayClip = false;
		texFrame.text = "";
	}

	public void SecrchChar()
	{
		int num = CommonHelper.ParseStringParamToInt(inputCharId.text);
		string text = "无";
		if (_dropTypeIndex == 0)
		{
			foreach (KeyValuePair<int, classSkin> item in characterSkinDic)
			{
				if (item.Value.charId == num)
				{
					text = item.Value.name;
					break;
				}
			}
		}
		else
		{
			foreach (KeyValuePair<int, classSkin> item2 in monsterSkinDic)
			{
				if (item2.Value.charId == num)
				{
					text = item2.Value.name;
					break;
				}
			}
		}
		BattleTestTogHelp[] componentsInChildren = dropCharacter.GetComponentsInChildren<BattleTestTogHelp>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			GameObject gameObject = componentsInChildren[i].gameObject;
			if (gameObject.name != "Item")
			{
				if (gameObject.transform.Find("Item Label").GetComponent<Text>().text == text)
				{
					gameObject.transform.localScale = Vector3.one;
				}
				else
				{
					gameObject.transform.localScale = Vector3.zero;
				}
			}
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(dropCharacter.transform.Find("Dropdown List/Viewport/Content").GetComponent<RectTransform>());
	}

	private void ChangeDropType(int index)
	{
		_dropTypeIndex = index;
		PlayerPrefs.SetInt("ComboClip_Tool_TypeIndex", index);
		SetDropCharacterValue(_dropTypeIndex);
	}

	private void ChangeDropCharacter(int index)
	{
		if (_dropTypeIndex == 1)
		{
			_charactorIndex = index;
			if (index != 0)
			{
				_tmpCharId = monsterSkinDic.get_Item(index).charId;
				PlayerPrefs.SetInt("ComboClip_Tool_CharId", _tmpCharId);
				StartCoroutine(LoadProModel(index));
			}
			return;
		}
		dropSkin.ClearOptions();
		_charactorIndex = index;
		if (index != 0)
		{
			_tmpCharId = characterSkinDic.get_Item(index).charId;
			PlayerPrefs.SetInt("ComboClip_Tool_CharId", _tmpCharId);
			List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
			for (int i = 0; i < characterSkinData.get_Item(_tmpCharId).Count; i++)
			{
				list.Add(new Dropdown.OptionData(characterSkinData.get_Item(_tmpCharId).get_Item(i).skinName));
			}
			dropSkin.AddOptions(list);
			dropSkin.value = 0;
			StartCoroutine(LoadProModel(0));
		}
	}

	private void ChangeDropSkin(int index)
	{
		if (_player != null)
		{
			_player.DestroySelf();
		}
		_player = null;
		dropCombo.ClearOptions();
		dropCombo.AddOptions(new List<Dropdown.OptionData>
		{
			new Dropdown.OptionData("无")
		});
		dropTag.ClearOptions();
		dropTag.AddOptions(new List<Dropdown.OptionData>
		{
			new Dropdown.OptionData("默认")
		});
		PlayerPrefs.SetInt("ComboClip_Tool_Skin", index);
		StartCoroutine(LoadProModel(index));
	}

	private IEnumerator LoadProModel(int index)
	{
		if (_dropTypeIndex == 0)
		{
			if (_player != null)
			{
				_player.DestroySelf();
			}
			_player = null;
			_tmpCharacterActorId = characterSkinData.get_Item(_tmpCharId).get_Item(index).charId;
			_tmpSkinId = characterSkinDic.get_Item(index).Id;
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadPlayer(_tmpCharacterActorId);
			yield return new WaitForSeconds(1f);
			ActorSpawnInfo spawnInfo = new ActorSpawnInfo(_tmpCharacterActorId);
			GameObject gameObject = GameObject.Find("PlayerSpawnPoint");
			spawnInfo.positionY = gameObject.transform.position.y;
			spawnInfo.position = new TSVector2(gameObject.transform.position.x, gameObject.transform.position.z);
			spawnInfo.rotation = 0f - gameObject.transform.rotation.eulerAngles.y;
			spawnInfo.spawnGizmo = GameObject.Find("PlayerSpawnPoint").GetComponent<PlayerSpawnPointGizmo>();
			ModuleController<AdventureModuleController>.Instance.SpawnPlayer(spawnInfo);
			yield break;
		}
		if (_player != null)
		{
			_player.DestroySelf();
		}
		_player = null;
		_tmpCharacterActorId = monsterSkinDic.get_Item(index).charId;
		_tmpSkinId = monsterSkinDic.get_Item(index).Id;
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadMonster(_tmpCharacterActorId, isRoguelikeMonster: false);
		yield return new WaitForSeconds(1f);
		ActorSpawnInfo actorSpawnInfo = new ActorSpawnInfo(_tmpCharacterActorId);
		actorSpawnInfo.summoner = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		ActorSpawnInfo spawnInfo2 = actorSpawnInfo;
		GameObject gameObject2 = GameObject.Find("PlayerSpawnPoint");
		spawnInfo2.positionY = gameObject2.transform.position.y;
		spawnInfo2.position = new TSVector2(gameObject2.transform.position.x, gameObject2.transform.position.z);
		spawnInfo2.rotation = 0f - gameObject2.transform.rotation.eulerAngles.y;
		spawnInfo2.spawnGizmo = GameObject.Find("MonsterSpawnPoint").GetComponent<MonsterSpawnPointGizmo>();
		ModuleController<AdventureModuleController>.Instance.SpawnMonster(spawnInfo2, null);
	}

	private void OnPlayerSpawn(IEvent evt)
	{
		if (!(evt.sender is AdventureActor))
		{
			return;
		}
		AdventureActor adventureActor = evt.sender as AdventureActor;
		if (_tmpCharacterActorId != adventureActor.dataID)
		{
			return;
		}
		if (adventureActor.comboGroup == null)
		{
			Debug.LogError("该角色不存在comboGroup");
			return;
		}
		_player = adventureActor;
		if (_dropTypeIndex == 0)
		{
			_player.actorSearchTargetInfo.visionAttackRange = 50;
			_player.actorSearchTargetInfo.visionRange = 50;
			_player.actorSearchTargetInfo.visionDeg = 360;
			SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor = adventureActor as PlayerAdventureActor;
			_player.actorInfo.originHitRate = FDP.One;
		}
		_player.actorSearchTargetInfo.enableVisionLogic = true;
		_player.actorSearchTargetInfo.enableHearingLogic = true;
		bool flag = evt.sender is PlayerAdventureActor;
		playerComboClipDic.Clear();
		int num = 0;
		List<string> list = new List<string>();
		Dictionary<string, classComboClip> dictionary = new Dictionary<string, classComboClip>();
		if (flag)
		{
			string[] files = Directory.GetFiles(Application.dataPath + $"/AssetBundles/Actor/Character/{_player.dataID}01/Combos");
			for (int i = 0; i < files.Length; i++)
			{
				files[i].Contains(".meta");
			}
		}
		else
		{
			for (int j = 0; j < _player.comboGroup.combos.Length; j++)
			{
				for (int k = 0; k < _player.comboGroup.combos[j].compositeComboClips.Length; k++)
				{
					classComboClip classComboClip2 = new classComboClip();
					string text = "";
					if (!_player.comboGroup.combos[j].compositeComboClips[k].comboClip)
					{
						Debug.LogError(_player.comboGroup.combos[j].requestKeysText + "存在动作数据集Missing情况");
						continue;
					}
					if (_dropTypeIndex == 0)
					{
						text = _player.comboGroup.combos[j].compositeComboClips[k].comboClip.name;
						text = text.Replace("Char_", "");
						text = text.Replace("ComboClip_", "");
					}
					else
					{
						text = _tmpCharacterActorId + "_" + _player.comboGroup.combos[j].compositeComboClips[k].comboClip.name;
					}
					if (!list.Contains(text))
					{
						list.Add(text);
						classComboClip2.clipName = text;
						classComboClip2.clip = _player.comboGroup.combos[j].compositeComboClips[k].comboClip;
						dictionary.Add(text, classComboClip2);
					}
				}
			}
		}
		list.Sort();
		for (int l = 0; l < list.Count; l++)
		{
			playerComboClipDic.Add(num, dictionary.get_Item(list.get_Item(l)));
			num++;
		}
		ChangeplayerCombo(0);
		SetPlayerComboValue();
	}

	private void ChangeplayerCombo(int index)
	{
		if (!(_player == null))
		{
			objLoopOn.SetActive(value: false);
			objLoopOff.SetActive(value: true);
			isLoopPlayClip = false;
			StopCoroutine("loopPlay");
			_comboClip = playerComboClipDic.get_Item(index).clip;
			PlayerPrefs.SetString("ComboClip_Tool_Combo", _comboClip.name);
			float num = (float)_comboClip.animationLength;
			_totalFrame = Mathf.RoundToInt(num * 60f);
			_isPlayClip = false;
			texFrame.text = string.Format(strFrame, 0, _totalFrame);
			if (playerComboClipDic.get_Item(index).clipName.Length > 18)
			{
				string text = playerComboClipDic.get_Item(index).clipName.Substring(0, 17);
				texClipName.text = text + "...";
			}
			SetComboTagValue();
		}
	}

	private void SetPlayerComboValue()
	{
		dropCombo.ClearOptions();
		List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
		int value = 0;
		foreach (KeyValuePair<int, classComboClip> item in playerComboClipDic)
		{
			if (_tmpComboName == item.Value.clip.name)
			{
				value = item.Key;
			}
			list.Add(new Dropdown.OptionData(item.Value.clipName));
		}
		dropCombo.AddOptions(list);
		dropCombo.value = value;
	}

	private void SetComboTagValue()
	{
		if (_player == null)
		{
			return;
		}
		_clipTag = "默认";
		_clipIndex = 0;
		ComboTagcName.Clear();
		dropTag.ClearOptions();
		List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
		if (!(_comboClip != null))
		{
			return;
		}
		int value = 0;
		ComboTagcName.Add("默认");
		list.Add(new Dropdown.OptionData("默认"));
		if (_comboClip != null && _comboClip.enableExtraEventGroup && _comboClip.EventGroups != null)
		{
			for (int i = 0; i < _comboClip.EventGroups.Length; i++)
			{
				ComboTagcName.Add(_comboClip.EventGroups[i].tag);
				if (_tmpTagame == _comboClip.EventGroups[i].tag)
				{
					value = i + 1;
				}
				list.Add(new Dropdown.OptionData(_comboClip.EventGroups[i].tag));
			}
		}
		dropTag.AddOptions(list);
		dropTag.value = value;
	}

	private void ChangeClipTag(int index)
	{
		if (!(_player == null))
		{
			_clipTag = ComboTagcName.get_Item(index);
			_clipIndex = index;
			PlayerPrefs.SetString("ComboClip_Tool_ClipTag", _clipTag);
		}
	}

	public void SwitchTarget()
	{
		if (_player == null)
		{
			return;
		}
		SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: true);
		selectTarget = _player.actorSearchTargetInfo.GetSwitchConfrontActor();
		for (int i = 0; i < GameObject.Find("BlobIndicators(Clone)").transform.childCount; i++)
		{
			if (GameObject.Find("BlobIndicators(Clone)").transform.GetChild(i).name == "TargetBlob")
			{
				GameObject.Find("BlobIndicators(Clone)").transform.GetChild(i).gameObject.SetActive(value: true);
			}
		}
		if (selectTarget != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.selectEntity = selectTarget;
			_player.attackTarget = selectTarget;
			SceneSingleton<AdventurePlayerController>.Instance._defaultSelect = selectTarget;
			_player.LookAt(selectTarget.tsTransform.Position, 0);
		}
	}

	public void SwitchTargetNull()
	{
		if (_player == null)
		{
			return;
		}
		selectTarget = null;
		for (int i = 0; i < GameObject.Find("BlobIndicators(Clone)").transform.childCount; i++)
		{
			if (GameObject.Find("BlobIndicators(Clone)").transform.GetChild(i).name == "TargetBlob")
			{
				GameObject.Find("BlobIndicators(Clone)").transform.GetChild(i).gameObject.SetActive(value: false);
			}
		}
		SceneSingleton<AdventurePlayerController>.Instance.selectEntity = null;
		_player.attackTarget = null;
		SceneSingleton<AdventurePlayerController>.Instance._defaultSelect = null;
		_player.RotateTo(90, 0.2);
	}

	public void playCharacterCombo()
	{
		if (!(_player == null))
		{
			if (selectTarget != null)
			{
				SceneSingleton<AdventurePlayerController>.Instance.selectEntity = selectTarget;
				_player.attackTarget = selectTarget;
				SceneSingleton<AdventurePlayerController>.Instance._defaultSelect = selectTarget;
				_player.LookAt(selectTarget.tsTransform.Position, 0);
			}
			_comboClip.selectedComboEvents = GetEventsByTag(_comboClip, _clipIndex, _player.skinID).ToList();
			texFrame.text = string.Format(strFrame, 0, _totalFrame);
			_playTime = Time.frameCount;
			_player._attackFSM.StopActionAnimation(fadeOutAnim: false);
			_player.gameObject.GetComponent<HybirdAnimatorController>().AddActionAnimationClip(_comboClip.animationClip, _comboClip.actionAnimType);
			_player._attackFSM.PlayActionAnimation(_comboClip, 1, speed, isClipTool: true);
			_isPlayClip = true;
			if (isLoopPlayClip)
			{
				StopAllCoroutines();
				StartCoroutine("loopPlay");
			}
		}
	}

	private IEnumerator loopPlay()
	{
		yield return new WaitForSeconds((float)_comboClip.animationLength / speed + 0.1f);
		playCharacterCombo();
	}

	public void ClickLoopPlay()
	{
		if (_player != null)
		{
			StopCoroutine("loopPlay");
		}
		if (!isLoopPlayClip)
		{
			objLoopOn.SetActive(value: true);
			objLoopOff.SetActive(value: false);
			isLoopPlayClip = true;
		}
		else
		{
			objLoopOn.SetActive(value: false);
			objLoopOff.SetActive(value: true);
			isLoopPlayClip = false;
		}
	}

	private Combo.Event[] GetEventsByTag(ComboClip clip, int _index, int skinid)
	{
		if (_index == 0)
		{
			return clip.comboEventSkins[0].comboEvents;
		}
		if (clip.enableExtraEventGroup)
		{
			if (clip.EventGroups != null && clip.EventGroups.Length > _index - 1)
			{
				return clip.EventGroups[_index - 1].ComboEventSkins[0].comboEvents;
			}
			Debug.LogError("comboclip事件组索引超出范围，请检查配置");
		}
		if (clip.comboEventSkins.Length != 0)
		{
			return clip.comboEventSkins[0].comboEvents;
		}
		return null;
	}

	public void playerRecover()
	{
		if (_player == null)
		{
			return;
		}
		if (selectTarget != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.selectEntity = null;
			SceneSingleton<AdventurePlayerController>.Instance._defaultSelect = null;
			selectTarget = null;
		}
		StopCoroutine("loopPlay");
		_player._attackFSM.StopActionAnimation(fadeOutAnim: false);
		GameObject gameObject = GameObject.Find("PlayerSpawnPoint");
		TSVector2 position = new TSVector2(gameObject.transform.position.x, gameObject.transform.position.z);
		_player.SyncMovementLocation(position, gameObject.transform.position.y, 0f - gameObject.transform.rotation.eulerAngles.y);
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterPos.ContainsKey(monsterAdventureActor.Id))
			{
				monsterAdventureActor.SyncMovementLocation(monsterPos.get_Item(monsterAdventureActor.Id).position, monsterPos.get_Item(monsterAdventureActor.Id).positionY, monsterPos.get_Item(monsterAdventureActor.Id).rotation);
			}
		}
	}

	public void ClickHitBox()
	{
		if (!(_player == null))
		{
			if (!isHitBox)
			{
				objHitBoxOff.SetActive(value: false);
				objHitBoxOn.SetActive(value: true);
				isHitBox = true;
			}
			else
			{
				objHitBoxOff.SetActive(value: true);
				objHitBoxOn.SetActive(value: false);
				isHitBox = false;
			}
		}
	}

	private void ChangeSpeedSlide(float val)
	{
		float num = Round(val);
		texSpeed.text = num + "x";
		speed = num;
	}

	private float Round(float value, int digits = 1)
	{
		float num = Mathf.Pow(10f, digits);
		return (float)Mathf.FloorToInt(value * num + 0.5f) / num;
	}

	private void SetMusicValue()
	{
		dropMusicType.ClearOptions();
		List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
		for (int i = 0; i < musicName.Count; i++)
		{
			list.Add(new Dropdown.OptionData(musicName.get_Item(i)));
		}
		dropMusicType.AddOptions(list);
		dropMusicType.value = 0;
	}

	private void ChangeMusicName(int index)
	{
		_musicName = musicName.get_Item(index);
		if (_musicName.Length > 14)
		{
			string text = _musicName.Substring(0, 13);
			texMusicName.text = text + "...";
		}
	}

	public void playMusic()
	{
		if (!string.IsNullOrEmpty(_musicName) && !(_musicName == "无"))
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(_musicName);
		}
	}

	private void Update()
	{
		if (_isPlayClip)
		{
			int num = Mathf.RoundToInt(((float)Time.frameCount - _playTime) * speed);
			texFrame.text = string.Format(strFrame, num, _totalFrame);
			if (num >= _totalFrame)
			{
				_isPlayClip = false;
				texFrame.text = string.Format(strFrame, 0, _totalFrame);
			}
		}
		if (MonoSingleton<InputManager>.Instance.GetKey(Key.A))
		{
			SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle++;
		}
		else if (MonoSingleton<InputManager>.Instance.GetKey(Key.D))
		{
			SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle--;
		}
		else if (MonoSingleton<InputManager>.Instance.GetKey(Key.W))
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle > 0f)
			{
				SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle--;
			}
		}
		else if (MonoSingleton<InputManager>.Instance.GetKey(Key.S) && SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle < 90f)
		{
			SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle++;
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		isDrag = true;
		startDragPosition = MonoSingleton<InputManager>.Instance.GetMousePosition();
		endDragPosition = Vector3.zero;
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!isDrag)
		{
			return;
		}
		endDragPosition = MonoSingleton<InputManager>.Instance.GetMousePosition();
		Vector3 vector = endDragPosition - startDragPosition;
		if (Mathf.Abs(vector.x) > Mathf.Abs(vector.y))
		{
			if (vector.x > 0f)
			{
				SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle -= 4f;
			}
			else
			{
				SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle += 4f;
			}
		}
		else if (vector.y > 0f)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle > 0f)
			{
				SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle -= 4f;
				if (SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle < 0f)
				{
					SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle = 0f;
				}
			}
		}
		else if (SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle < 90f)
		{
			SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle += 4f;
			if (SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle > 90f)
			{
				SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle = 90f;
			}
		}
		startDragPosition = endDragPosition;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isDrag = false;
		startDragPosition = Vector3.zero;
		endDragPosition = Vector3.zero;
	}

	private void OnDestroy()
	{
		SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraAngle = cameraAngleValue;
		SceneSingleton<AdventurePlayerController>.Instance.activedSharedConigureData.cameraRotationAngle = cameraRotationAngleValue;
	}
}
