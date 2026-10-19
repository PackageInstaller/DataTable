using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class CharacterTutorialComp : MonoBehaviour
{
	[SerializeReference]
	private Process process;

	[SerializeReference]
	private BetterAnimation animation;

	[SerializeReference]
	private GameObject highLight;

	[SerializeReference]
	private CharacterTutorialHighLight characterTutorialHighLight;

	private const string _finishProcessQueueName = "CharacterTutorialFinishProcess";

	private OperateBtnComp _operateBtnComp;

	[SerializeReference]
	private GameObject _trainingGroup;

	private readonly List<ParticleSystemRenderer> _particleRenderers = new List<ParticleSystemRenderer>();

	private bool _isUltraTimelineParticleHidden;

	public void Init(ImageAssetStation imageStation, OperateBtnComp operateBtnComp)
	{
		process.Init(imageStation);
		_operateBtnComp = operateBtnComp;
		AddEventListener();
		highLight.gameObject.SetActive(value: false);
		RefreshParticleRendererCache();
		animation.GetSequence("Show").Play();
	}

	private void LateUpdate()
	{
		bool flag = IsMainEntityInUltraTimeline();
		if (flag != _isUltraTimelineParticleHidden)
		{
			SetParticleRenderingHidden(flag);
			if (flag)
			{
				process.HideClearEffectRootForUltraTimeline();
			}
			_isUltraTimelineParticleHidden = flag;
		}
	}

	private void AddEventListener()
	{
		Model<CharacterTutorialModel>.Interface.OnPromptProcessChanged += OnPromptProcessChanged;
		Model<CharacterTutorialModel>.Interface.OnToNextOperateNode += OnToNextOperateNode;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSuccess += OnOperateNodeSuccess;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeFail += OnOperateNodeFail;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSecondEnergyShowDesc += OnOperateNodeSecondEnergyShowDesc;
	}

	public void UnInit()
	{
		RemoveEventListener();
		animation.GetSequence("Hide").OnPlay((AnimationBuilder _) =>
		{
			process.DestroyAllNode();
		}).OnComplete((AnimationBuilder _) =>
		{
			Object.Destroy(gameObject);
		})
			.PlayInQueue("CharacterTutorialFinishProcess");
	}

	private void OnDestroy()
	{
		RemoveEventListener();
	}

	private void RemoveEventListener()
	{
		Model<CharacterTutorialModel>.Interface.OnPromptProcessChanged -= OnPromptProcessChanged;
		Model<CharacterTutorialModel>.Interface.OnToNextOperateNode -= OnToNextOperateNode;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSuccess -= OnOperateNodeSuccess;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeFail -= OnOperateNodeFail;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSecondEnergyShowDesc -= OnOperateNodeSecondEnergyShowDesc;
	}

	private void OnOperateNodeSecondEnergyShowDesc(int nodeId)
	{
		highLight.gameObject.SetActive(value: true);
		characterTutorialHighLight.Init(_operateBtnComp, nodeId, _trainingGroup);
	}

	private void OnPromptProcessChanged(PromptProcessData processData)
	{
		if (processData == null)
		{
			highLight.gameObject.SetActive(value: false);
			process.FinishProcess();
			return;
		}
		process.StartProcess(processData);
		RefreshParticleRendererCache();
		if (_isUltraTimelineParticleHidden)
		{
			SetParticleRenderingHidden(hidden: true);
		}
	}

	private void RefreshParticleRendererCache()
	{
		_particleRenderers.Clear();
		GetComponentsInChildren(includeInactive: true, _particleRenderers);
	}

	private void SetParticleRenderingHidden(bool hidden)
	{
		for (int i = 0; i < _particleRenderers.Count; i++)
		{
			ParticleSystemRenderer particleSystemRenderer = _particleRenderers[i];
			if (!(particleSystemRenderer == null))
			{
				particleSystemRenderer.forceRenderingOff = hidden;
			}
		}
	}

	private bool IsMainEntityInUltraTimeline()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null)
		{
			return false;
		}
		Entity mainEntity = instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return false;
		}
		return mainEntity.GetCompEffect()?.bInUltraTimeline ?? false;
	}

	private void OnToNextOperateNode(OperateNodeData nodeData)
	{
		process.OnToNextOperateNode(nodeData);
	}

	private void OnOperateNodeSuccess(OperateNodeData nodeData, bool isLast)
	{
		process.OnOperateNodeSuccess(nodeData, isLast);
	}

	private void OnOperateNodeFail(OperateNodeData failNodeData, OperateNodeData toNodeData)
	{
		process.OnOperateNodeFail(failNodeData, toNodeData);
	}
}
