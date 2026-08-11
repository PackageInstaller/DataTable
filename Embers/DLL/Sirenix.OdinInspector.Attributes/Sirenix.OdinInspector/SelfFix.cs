using System;

namespace Sirenix.OdinInspector;

public struct SelfFix
{
	public string Title;

	public Delegate Action;

	public bool OfferInInspector;

	public SelfFix(string name, Action action, bool offerInInspector)
	{
		Title = name;
		Action = action;
		OfferInInspector = offerInInspector;
	}

	public SelfFix(string name, Delegate action, bool offerInInspector)
	{
		Title = name;
		Action = action;
		OfferInInspector = offerInInspector;
	}

	public static SelfFix Create(Action action, bool offerInInspector = true)
	{
		return new SelfFix("Fix", action, offerInInspector);
	}

	public static SelfFix Create(string title, Action action, bool offerInInspector = true)
	{
		return new SelfFix(title, action, offerInInspector);
	}

	public static SelfFix Create<T>(Action<T> action, bool offerInInspector = true) where T : new()
	{
		return new SelfFix("Fix", action, offerInInspector);
	}

	public static SelfFix Create<T>(string title, Action<T> action, bool offerInInspector = true) where T : new()
	{
		return new SelfFix(title, action, offerInInspector);
	}
}
