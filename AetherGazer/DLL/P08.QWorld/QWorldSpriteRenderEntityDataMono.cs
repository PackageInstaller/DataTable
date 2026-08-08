using UnityEngine;

public class QWorldSpriteRenderEntityDataMono : QWorldThingEntityDataMono
{
	protected override void OnAfterLoadState(QWorldThingEntityData loadData)
	{
		base.OnAfterLoadState(loadData);
		SpriteRenderer component = base.gameObject.GetComponent<SpriteRenderer>();
		if (!(null == component))
		{
			component.size = size;
		}
	}

	protected override void OnAfterSaveState(ref QWorldThingEntityData saveData)
	{
		base.OnAfterSaveState(ref saveData);
		SpriteRenderer component = base.gameObject.GetComponent<SpriteRenderer>();
		if (!(null == component))
		{
			saveData.size = component.size;
		}
	}
}
