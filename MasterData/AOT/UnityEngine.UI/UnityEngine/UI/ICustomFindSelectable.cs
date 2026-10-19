namespace UnityEngine.UI;

public interface ICustomFindSelectable
{
	Selectable FindSelectableOnLeft();

	Selectable FindSelectableOnRight();

	Selectable FindSelectableOnUp();

	Selectable FindSelectableOnDown();

	Selectable FindSelectable(Vector3 dir);
}
