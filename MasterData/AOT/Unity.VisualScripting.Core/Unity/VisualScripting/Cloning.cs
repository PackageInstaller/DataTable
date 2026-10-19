using System;
using System.Collections.Generic;
using System.Linq;
using JetBrains.Annotations;
using UnityEngine;

namespace Unity.VisualScripting;

public static class Cloning
{
	private static readonly Dictionary<Type, bool> skippable;

	public static HashSet<ICloner> cloners { get; }

	public static ArrayCloner arrayCloner { get; }

	public static DictionaryCloner dictionaryCloner { get; }

	public static EnumerableCloner enumerableCloner { get; }

	public static ListCloner listCloner { get; }

	public static AnimationCurveCloner animationCurveCloner { get; }

	internal static GradientCloner gradientCloner { get; }

	public static FieldsCloner fieldsCloner { get; }

	public static FakeSerializationCloner fakeSerializationCloner { get; }

	static Cloning()
	{
		skippable = new Dictionary<Type, bool>();
		cloners = new HashSet<ICloner>();
		arrayCloner = new ArrayCloner();
		dictionaryCloner = new DictionaryCloner();
		enumerableCloner = new EnumerableCloner();
		listCloner = new ListCloner();
		animationCurveCloner = new AnimationCurveCloner();
		gradientCloner = new GradientCloner();
		fieldsCloner = new FieldsCloner();
		fakeSerializationCloner = new FakeSerializationCloner();
		cloners.Add(arrayCloner);
		cloners.Add(dictionaryCloner);
		cloners.Add(enumerableCloner);
		cloners.Add(listCloner);
		cloners.Add(animationCurveCloner);
		cloners.Add(gradientCloner);
	}

	public static object Clone(this object original, ICloner fallbackCloner, bool tryPreserveInstances)
	{
		using CloningContext context = CloningContext.New(fallbackCloner, tryPreserveInstances);
		return Clone(context, original);
	}

	public static T Clone<T>(this T original, ICloner fallbackCloner, bool tryPreserveInstances)
	{
		return (T)((object)original).Clone(fallbackCloner, tryPreserveInstances);
	}

	public static object CloneViaFakeSerialization(this object original)
	{
		return original.Clone(fakeSerializationCloner, tryPreserveInstances: true);
	}

	public static T CloneViaFakeSerialization<T>(this T original)
	{
		return (T)((object)original).CloneViaFakeSerialization();
	}

	internal static object Clone(CloningContext context, object original)
	{
		object clone = null;
		CloneInto(context, ref clone, original);
		return clone;
	}

	internal static void CloneInto(CloningContext context, ref object clone, object original)
	{
		if (original == null)
		{
			clone = null;
			return;
		}
		Type type = original.GetType();
		if (Skippable(type))
		{
			clone = original;
			return;
		}
		if (context.clonings.ContainsKey(original))
		{
			clone = context.clonings[original];
			return;
		}
		ICloner cloner = GetCloner(original, type, context.fallbackCloner);
		if (clone == null)
		{
			clone = cloner.ConstructClone(type, original);
		}
		context.clonings.Add(original, clone);
		cloner.BeforeClone(type, original);
		cloner.FillClone(type, ref clone, original, context);
		cloner.AfterClone(type, clone);
		context.clonings[original] = clone;
	}

	[CanBeNull]
	public static ICloner GetCloner(object original, Type type)
	{
		if (original is ISpecifiesCloner specifiesCloner)
		{
			return specifiesCloner.cloner;
		}
		return cloners.FirstOrDefault((ICloner cloner) => cloner.Handles(type));
	}

	private static ICloner GetCloner(object original, Type type, ICloner fallbackCloner)
	{
		ICloner cloner = GetCloner(original, type);
		if (cloner != null)
		{
			return cloner;
		}
		Ensure.That("fallbackCloner").IsNotNull(fallbackCloner);
		return fallbackCloner;
	}

	private static bool Skippable(Type type)
	{
		if (!skippable.TryGetValue(type, out var value))
		{
			value = type.IsValueType || type == typeof(string) || typeof(Type).IsAssignableFrom(type) || typeof(UnityEngine.Object).IsAssignableFrom(type);
			skippable.Add(type, value);
		}
		return value;
	}
}
