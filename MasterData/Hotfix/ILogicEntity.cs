using System;
using UnityEngine;

public interface ILogicEntity
{
	long Id { get; }

	bool ActiveSelf { get; }

	ILogicComponent AddLogicComponent(ILogicComponent component);

	ILogicComponent GetLogicComponent(Type type);

	T GetLogicComponent<T>() where T : ILogicComponent;

	T AddOrGetLogicComponent<T>() where T : ILogicComponent, new();

	T AddMonoLogicComponent<T>() where T : Component, ILogicComponent;

	T AddOrGetMonoLogicComponent<T>() where T : Component, ILogicComponent;
}
