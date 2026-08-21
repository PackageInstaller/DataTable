#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class RockerControl : BaseMechanism
{
	public int ID;

	public List<Animator> ControlGobjs;

	public bool IsMuteInput;

	public float OpenInputTime;

	private Animator _animator;

	public string InteractiveName;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		ActiveInteractive(InteractiveName);
		_animator = ((Component)(object)this).GetComponentInChildren<Animator>();
		InitControlGobjs(data);
	}

	private void InitControlGobjs(object data)
	{
		if (data == null)
		{
			return;
		}
		int num = (int)data;
		if (num == -1)
		{
			return;
		}
		for (int i = 0; i < ControlGobjs.Count; i++)
		{
			if ((Object)(object)ControlGobjs[i] != null)
			{
				ControlGobjs[i].SetBool("Invisibility", TSUtil.GetBitValue(i, num) == 0);
			}
		}
	}

	public override void InteractiveFinishCallback(int obj)
	{
		base.InteractiveFinishCallback(obj);
		foreach (Animator controlGobj in ControlGobjs)
		{
			if ((Object)(object)controlGobj != null)
			{
				controlGobj.SetBool("Invisibility", !controlGobj.GetBool("Invisibility"));
			}
		}
		if ((Object)(object)_animator != null)
		{
			_animator.SetBool("Start", !_animator.GetBool("Start"));
		}
	}

	public override async void InteractiveStartCallback(int obj)
	{
		base.InteractiveStartCallback(obj);
		if (IsMuteInput && entity != null)
		{
			entity.GetSystem<InputSystem>().SetPaused(paused: true);
			await UniTask.WaitForSeconds(OpenInputTime);
			if (entity != null)
			{
				entity.GetSystem<InputSystem>().SetPaused(paused: false);
			}
			else
			{
				Log.Error("entity是空的");
			}
		}
	}

	public int GetRockerData()
	{
		int num = 0;
		for (int i = 0; i < ControlGobjs.Count; i++)
		{
			if ((Object)(object)ControlGobjs[i] != null)
			{
				num = TSUtil.SetBitValue(i, (!ControlGobjs[i].GetBool("Invisibility")) ? 1 : 0, num);
			}
		}
		return num;
	}
}
