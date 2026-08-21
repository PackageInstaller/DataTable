using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class CreateGameObject : ActionTask
{
	public BBParameter<string> objectName;

	public BBParameter<Vector3> position;

	public BBParameter<Vector3> rotation;

	[BlackboardOnly]
	public BBParameter<GameObject> saveAs;

	protected override void OnExecute()
	{
		GameObject gameObject = new GameObject(objectName.value);
		gameObject.transform.position = position.value;
		gameObject.transform.eulerAngles = rotation.value;
		saveAs.value = gameObject;
		EndAction();
	}
}
