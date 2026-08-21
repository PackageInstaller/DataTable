using System;
using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BoltModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private BTEnv env;

	private int buffID;

	protected int lastCol;

	protected int maxCol;

	protected int allCol;

	protected bool isOpen;

	protected int type;

	public BoltModule(int buffID, EntityMechanism m, int colX, int colY, int dir)
	{
		mech = m;
		this.buffID = buffID;
		env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, mech);
		maxCol = colX;
		lastCol = colX;
		allCol = colY;
		isOpen = false;
		type = dir;
	}

	public void ChangeIdleAni()
	{
		string text = ((type == 0) ? "up" : "left");
		if (isOpen)
		{
			mech.logic.ChangeAniState("nu_" + text + "_on", isLoop: false);
		}
		else
		{
			mech.logic.ChangeAniState("nu_" + text + "_empty", isLoop: false);
		}
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (isOpen)
		{
			string text = ((type == 0) ? "up" : "left");
			mech.logic.ChangeAniState("nu_" + text + "_shoot", isLoop: false, delegate
			{
				ChangeIdleAni();
			});
			float num = ((type == 0) ? 90 : 180);
			Vector3 vector = new Vector3(Mathf.Cos((mech.go.transform.rotation.eulerAngles.z + num) * MathF.PI / 180f), Mathf.Sin((mech.go.transform.rotation.eulerAngles.z + num) * MathF.PI / 180f));
			vector = vector.normalized;
			env.AddStruct("shootDir", vector);
			env.Run();
			allCol--;
			lastCol--;
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_crossbow");
			if (allCol == 0)
			{
				mech.Dead = true;
				mech.go.SetActive(value: false);
			}
			else if (lastCol == 0)
			{
				isOpen = false;
			}
		}
	}

	public void OnRoundStart()
	{
		lastCol = maxCol;
		isOpen = true;
		string text = ((type == 0) ? "up" : "left");
		mech.logic.ChangeAniState("nu_" + text + "_reload", isLoop: false, delegate
		{
			ChangeIdleAni();
		});
	}
}
