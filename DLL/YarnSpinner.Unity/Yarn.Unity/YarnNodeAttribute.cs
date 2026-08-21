using System;
using UnityEngine;

namespace Yarn.Unity;

[AttributeUsage(AttributeTargets.Field)]
public class YarnNodeAttribute : PropertyAttribute
{
	public readonly string yarnProjectAttribute;

	public YarnNodeAttribute(string yarnProjectAttribute)
	{
		this.yarnProjectAttribute = yarnProjectAttribute;
	}
}
