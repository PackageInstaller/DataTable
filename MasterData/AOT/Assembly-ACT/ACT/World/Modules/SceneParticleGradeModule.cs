using System.Collections.Generic;

namespace ACT.World.Modules;

internal class SceneParticleGradeModule : WorldModuleBase
{
	private ParticlesGrade _grade;

	private bool _needUpdate;

	private readonly HashSet<ISceneParticleGradeNode> _nodes = new HashSet<ISceneParticleGradeNode>();

	internal override bool NeedGotChunkChange => false;

	public void ChangeActiveGrade(int value)
	{
		ChangeActiveGrade((ParticlesGrade)value);
	}

	public void ChangeActiveGrade(ParticlesGrade grade)
	{
		_grade = grade;
		_needUpdate = true;
	}

	protected override void OnUpdate()
	{
		if (_needUpdate)
		{
			_needUpdate = false;
			RefreshAllNodes();
		}
	}

	private void RefreshAllNodes()
	{
		foreach (ISceneParticleGradeNode node in _nodes)
		{
			try
			{
				node.SetNodeLevel(_grade);
			}
			catch
			{
			}
		}
	}

	public void RegisterControl(ISceneParticleGradeNode node)
	{
		_nodes.Add(node);
		node.SetNodeLevel(_grade);
	}

	public void UnregisterControl(ISceneParticleGradeNode node)
	{
		_nodes.Remove(node);
	}
}
