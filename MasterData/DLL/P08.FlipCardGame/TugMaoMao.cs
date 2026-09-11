using UnityEngine;

public class TugMaoMao : MonoBehaviour
{
	private float speed;

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
	}

	public void SetSpeed(float value)
	{
		speed = value;
	}

	private void Update()
	{
		if (TugGameControl.Instance.state == TugGameControl.GameStatus.Playing)
		{
			base.transform.Translate(new Vector3(1f, 0f, 0f) * speed * Time.deltaTime);
		}
	}

	public void ResetState()
	{
		Speed = 0f;
		base.transform.localPosition = new Vector3(0f, 0f, 0f);
	}
}
