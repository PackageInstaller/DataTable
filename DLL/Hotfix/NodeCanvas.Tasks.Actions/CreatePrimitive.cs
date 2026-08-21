using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class CreatePrimitive : ActionTask
{
	public BBParameter<string> objectName;

	public BBParameter<Vector3> position;

	public BBParameter<Vector3> rotation;

	public BBParameter<PrimitiveType> type;

	[BlackboardOnly]
	public BBParameter<GameObject> saveAs;

	protected override void OnExecute()
	{
		GameObject gameObject = GameObject.CreatePrimitive(type.value);
		gameObject.name = objectName.value;
		gameObject.transform.position = position.value;
		gameObject.transform.eulerAngles = rotation.value;
		saveAs.value = gameObject;
		EndAction();
	}
}
