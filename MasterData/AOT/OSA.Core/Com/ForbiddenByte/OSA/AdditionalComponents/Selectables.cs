using System;
using UnityEngine;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.AdditionalComponents;

[Serializable]
public class Selectables
{
	[SerializeField]
	private Selectable _Up;

	[SerializeField]
	private Selectable _Down;

	[SerializeField]
	private Selectable _Left;

	[SerializeField]
	private Selectable _Right;

	[SerializeField]
	[Tooltip("Whether to set the corresponding Left/Right/Up/Down Selectables to point back this ScrollView (eg. the Down selectable's Up property will be <this> ScrollView). This also overrides the Selectables' navigation mode to 'Explicit'")]
	private bool _SyncAllProvidedSelectables = true;

	public Selectable Up => _Up;

	public Selectable Down => _Down;

	public Selectable Left => _Left;

	public Selectable Right => _Right;

	public bool SyncAllProvidedSelectables => _SyncAllProvidedSelectables;

	internal void SyncProvidedSelectables(Selectable target)
	{
		if ((bool)Up)
		{
			Navigation navigation = Up.navigation;
			navigation.mode = Navigation.Mode.Explicit;
			navigation.selectOnDown = target;
			Up.navigation = navigation;
		}
		if ((bool)Down)
		{
			Navigation navigation2 = Down.navigation;
			navigation2.mode = Navigation.Mode.Explicit;
			navigation2.selectOnUp = target;
			Down.navigation = navigation2;
		}
		if ((bool)Left)
		{
			Navigation navigation3 = Left.navigation;
			navigation3.mode = Navigation.Mode.Explicit;
			navigation3.selectOnRight = target;
			Left.navigation = navigation3;
		}
		if ((bool)Right)
		{
			Navigation navigation4 = Right.navigation;
			navigation4.mode = Navigation.Mode.Explicit;
			navigation4.selectOnLeft = target;
			Right.navigation = navigation4;
		}
	}
}
