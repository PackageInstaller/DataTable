using UnityEngine;

public class PopGameLoader : MonoBehaviour
{
	public GameObject obj;

	public MainStepBase step;

	public float trigger;

	public GameObject activeObj;

	private PopStepBase popStep;

	private void Update()
	{
		if (step != null && step.GetPopStepTriggerProgress() >= trigger)
		{
			if (GameObject.Find(obj.name + "(Clone)") == null && activeObj == null)
			{
				GameObject gameObject = Object.Instantiate(obj, CookingGameManager.Instance.popGameContainer);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				activeObj = gameObject;
				popStep = activeObj.GetComponent<PopStepBase>();
				activeObj.SetActive(value: true);
			}
			else if (!popStep.IsStepCompleted())
			{
				activeObj.SetActive(value: true);
			}
		}
	}
}
