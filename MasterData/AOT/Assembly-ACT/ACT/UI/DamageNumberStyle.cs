using ACT.MultiPlayer;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class DamageNumberStyle : MonoBehaviour
{
	[SerializeField]
	protected Image[] numImages;

	protected DamageNumberConfig _config;

	protected int _damage;

	protected Color _color;

	public virtual void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		_config = config;
		_damage = cmd.damage;
	}

	protected void ApplyDamageNum(Sprite[] source, bool setColor = false, Color color = default(Color))
	{
		int num = _damage;
		int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
		for (int num2 = damageNumDigits - 1; num2 >= 0; num2--)
		{
			numImages[num2].gameObject.SetActive(value: true);
			numImages[num2].sprite = source[num % 10];
			if (setColor)
			{
				numImages[num2].color = color;
			}
			num /= 10;
		}
		if (damageNumDigits < numImages.Length)
		{
			for (int i = damageNumDigits; i < numImages.Length; i++)
			{
				numImages[i].gameObject.SetActive(value: false);
			}
		}
		SetDamageNumCenter();
	}

	protected int GetDamageNumDigits(int damage, int maxDigits)
	{
		if (damage <= 0)
		{
			return 1;
		}
		return Mathf.Clamp(1 + (int)Mathf.Floor(Mathf.Log10(damage)), 1, maxDigits);
	}

	protected void SetToCenter(Transform target)
	{
		int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
		float x = (numImages[0].transform.position.x + numImages[damageNumDigits - 1].transform.position.x) * 0.5f;
		target.transform.position = new Vector3(x, target.transform.position.y, target.transform.position.z);
	}

	private void SetDamageNumCenter()
	{
		int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
		float x = (numImages[damageNumDigits - 1].transform.position.x - numImages[0].transform.position.x) * 0.5f;
		transform.position = transform.parent.position - new Vector3(x, 0f, 0f);
	}
}
