using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.ECS.System;

public class SystemHandleInput : EntitySystem
{
	private Filter _filter;

	private EntityAction<CompInput, CompMotion, CompTransform> _fixedUpdateBehaveAction;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompTransform, CompTime, CompInput, CompMotion, CompPhysics, CompEffect>().Build();
		_fixedUpdateBehaveAction = FixedUpdateBehave;
	}

	public override void FixedUpdate()
	{
		_filter.ForEachStable(_fixedUpdateBehaveAction);
	}

	private void FixedUpdateBehave(Entity entity, CompInput compInput, CompMotion compMotion, CompTransform compTransform)
	{
		if (!MonoECS.instance.couldInput || !entity.IsActive() || !entity.IsTickAvailable())
		{
			return;
		}
		if (compInput.dirXSet)
		{
			switch (compInput.dirX)
			{
			case EInputDir.None:
				compMotion.SetBool("DirNone", b: true);
				compMotion.SetBool("DirLeft", b: false);
				compMotion.SetBool("DirRight", b: false);
				compMotion.SetBool("Move", b: false);
				compMotion.SetBool("FlyMove", b: false);
				break;
			case EInputDir.Left:
				compMotion.SetBool("DirNone", b: false);
				compMotion.SetBool("DirLeft", b: true);
				compMotion.SetBool("DirRight", b: false);
				compMotion.SetBool("Move", b: true);
				compMotion.SetBool("FlyMove", b: true);
				break;
			case EInputDir.Right:
				compMotion.SetBool("DirNone", b: false);
				compMotion.SetBool("DirLeft", b: false);
				compMotion.SetBool("DirRight", b: true);
				compMotion.SetBool("Move", b: true);
				compMotion.SetBool("FlyMove", b: true);
				break;
			}
			compInput.dirXSet = false;
		}
		if (compInput.dirYSet)
		{
			switch (compInput.dirY)
			{
			case EInputDir.None:
				compMotion.SetBool("DirUp", b: false);
				compMotion.SetBool("DirDown", b: false);
				break;
			case EInputDir.Up:
				compMotion.SetBool("DirUp", b: true);
				compMotion.SetBool("DirDown", b: false);
				break;
			case EInputDir.Down:
				compMotion.SetBool("DirUp", b: false);
				compMotion.SetBool("DirDown", b: true);
				break;
			}
			compInput.dirYSet = false;
		}
		FaceDir faceDir = compTransform.FaceDir;
		EInputDir dirX = compInput.dirX;
		bool b = (faceDir == FaceDir.Left && dirX == EInputDir.Right) || (faceDir == FaceDir.Right && dirX == EInputDir.Left);
		compMotion.SetBool("DirOp", b);
	}

	public override void Update()
	{
	}
}
