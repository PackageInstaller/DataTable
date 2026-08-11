using System;
using System.Collections;
using System.Reflection;
using UnityEngine;

namespace Yarn.Unity;

public interface IActionRegistration
{
	void AddCommandHandler(string commandName, Delegate handler);

	void AddCommandHandler(string commandName, MethodInfo methodInfo);

	void AddCommandHandler(string commandName, Func<Coroutine> handler);

	void AddCommandHandler<T1>(string commandName, Func<T1, Coroutine> handler);

	void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, Coroutine> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, Coroutine> handler);

	void AddCommandHandler(string commandName, Func<IEnumerator> handler);

	void AddCommandHandler<T1>(string commandName, Func<T1, IEnumerator> handler);

	void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, IEnumerator> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, IEnumerator> handler);

	void AddCommandHandler(string commandName, Action handler);

	void AddCommandHandler<T1>(string commandName, Action<T1> handler);

	void AddCommandHandler<T1, T2>(string commandName, Action<T1, T2> handler);

	void AddCommandHandler<T1, T2, T3>(string commandName, Action<T1, T2, T3> handler);

	void AddCommandHandler<T1, T2, T3, T4>(string commandName, Action<T1, T2, T3, T4> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Action<T1, T2, T3, T4, T5> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Action<T1, T2, T3, T4, T5, T6> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9> handler);

	void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> handler);

	void RemoveCommandHandler(string commandName);

	void AddFunction(string name, Delegate implementation);

	void AddFunction<TResult>(string name, Func<TResult> implementation);

	void AddFunction<T1, TResult>(string name, Func<T1, TResult> implementation);

	void AddFunction<T1, T2, TResult>(string name, Func<T1, T2, TResult> implementation);

	void AddFunction<T1, T2, T3, TResult>(string name, Func<T1, T2, T3, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, TResult>(string name, Func<T1, T2, T3, T4, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, TResult>(string name, Func<T1, T2, T3, T4, T5, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, T6, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, T6, T7, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> implementation);

	void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> implementation);

	void RemoveFunction(string name);
}
