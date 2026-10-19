using ACT.World.Modules;
using Fundamental;
using UnityEngine;

namespace ACT.World;

internal class ParticlesGradeControl : MonoBehaviour, ISceneParticleGradeNode
{
	[SerializeField]
	private GameObject[] _highNodes;

	void ISceneParticleGradeNode.SetNodeLevel(ParticlesGrade grade)
	{
		if (_highNodes == null)
		{
			return;
		}
		int num = _highNodes.Length;
		for (int i = 0; i < num; i++)
		{
			GameObject gameObject = _highNodes[i];
			if (!(gameObject == null))
			{
				gameObject.SetActive(grade > ParticlesGrade.OFF);
			}
		}
	}

	private void Start()
	{
		if (Application.isPlaying)
		{
			RegisterControl();
		}
	}

	private void OnDestroy()
	{
		if (Application.isPlaying)
		{
			UnregisterControl();
		}
	}

	private void RegisterControl()
	{
		Singleton<GameManager>.instance.worldManager.ParticleGradeModule.RegisterControl(this);
	}

	private void UnregisterControl()
	{
		Singleton<GameManager>.instance.worldManager.ParticleGradeModule.UnregisterControl(this);
	}
}
