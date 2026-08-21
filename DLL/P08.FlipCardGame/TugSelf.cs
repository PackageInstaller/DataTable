using UnityEngine;

public class TugSelf : MonoBehaviour
{
	[SerializeField]
	private float constSpeed = 0.1f;

	[SerializeField]
	private float anger;

	private TugSkillInfo[] skillList;

	[SerializeField]
	private float angerStart;

	[SerializeField]
	private float angerMax = 30f;

	[SerializeField]
	private float angerAddSpeed = 0.5f;

	[SerializeField]
	private float speed;

	private string ButtonName = "技能a";

	private string ButtonName2 = "技能b";

	private string ButtonName3 = "技能c";

	public float Anger
	{
		get
		{
			return anger;
		}
		set
		{
			anger = value;
		}
	}

	public float Speed
	{
		get
		{
			return speed;
		}
		set
		{
			speed = value;
		}
	}

	private void Start()
	{
		SetSelfStart();
	}

	public void SetData(TugInfo info, TugSkillInfo[] skill)
	{
		speed = info.constSpeed;
		angerStart = info.angerStart;
		angerAddSpeed = info.angerAddSpeed;
		angerMax = info.angerMax;
		for (int i = 0; i < skill.Length; i++)
		{
			skillList[i].effectType = ((i != 3) ? 1 : 2);
			skillList[i].skillType = i;
			skillList[i].cd = skill[i].cd;
			skillList[i].cost = skill[i].cd;
			skillList[i].speed = skill[i].speed;
			skillList[i].AddSpeedA = skill[i].AddSpeedA;
			skillList[i].nowCd = skill[i].nowCd;
			skillList[i].nowSpeed = skill[i].nowSpeed;
			Debug.Log(" SetSelfStart " + skillList[i].speed);
		}
		Debug.Log(" self 数据设置");
	}

	public void SetSpeed(float value)
	{
	}

	private void Update()
	{
	}

	public float GetSelfSpeed()
	{
		float num = constSpeed;
		for (int i = 0; i < skillList.Length; i++)
		{
			Debug.Log("info " + skillList[i].nowSpeed + " " + skillList[i].nowCd);
			num += ((skillList[i].effectType == 1) ? skillList[i].nowSpeed : 0f);
		}
		return num;
	}

	public void SkillA()
	{
		if (skillList[0].nowCd <= 0f && Anger >= skillList[0].cost)
		{
			TugSkillInfo tugSkillInfo = skillList[0];
			skillList[0].nowSpeed = tugSkillInfo.speed;
			skillList[0].nowCd = tugSkillInfo.cd;
			Anger -= skillList[0].cost;
			Debug.Log("info1 " + skillList[0].nowSpeed + " " + skillList[0].nowCd);
		}
		else
		{
			Debug.Log("怒气点不足 ");
		}
	}

	public void SkillB()
	{
		if (skillList[1].nowCd <= 0f && Anger >= skillList[1].cost)
		{
			TugSkillInfo tugSkillInfo = skillList[1];
			skillList[1].nowSpeed = tugSkillInfo.speed;
			skillList[1].nowCd = tugSkillInfo.cd;
			Anger -= skillList[1].cost;
			Debug.Log("info2 " + skillList[1].nowSpeed + " " + skillList[1].nowCd);
		}
	}

	public void SkillC()
	{
		speed += 0.1f;
	}

	public void SetSelfStart()
	{
		Anger = angerStart;
		skillList = new TugSkillInfo[3];
	}

	public void UpdateSelfState()
	{
		for (int i = 0; i < skillList.Length; i++)
		{
			if (skillList[i].effectType == 1 && skillList[i].nowSpeed > 0f)
			{
				skillList[i].nowSpeed = Mathf.Clamp(skillList[i].nowSpeed - skillList[i].AddSpeedA * Time.deltaTime, 0f, 99f);
			}
			skillList[i].nowCd = Mathf.Clamp(skillList[i].nowCd - Time.deltaTime, 0f, skillList[i].nowCd);
		}
		anger = Mathf.Clamp(anger + angerAddSpeed, 0f, angerMax);
	}
}
