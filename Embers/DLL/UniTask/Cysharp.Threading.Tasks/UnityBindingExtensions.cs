using System;
using System.Threading;
using UnityEngine;
using UnityEngine.UI;

namespace Cysharp.Threading.Tasks;

public static class UnityBindingExtensions
{
	public static void BindTo(this IUniTaskAsyncEnumerable<string> source, Text text, bool rebindOnError = true)
	{
		BindToCore(source, text, text.GetCancellationTokenOnDestroy(), rebindOnError).Forget();
	}

	public static void BindTo(this IUniTaskAsyncEnumerable<string> source, Text text, CancellationToken cancellationToken, bool rebindOnError = true)
	{
		BindToCore(source, text, cancellationToken, rebindOnError).Forget();
	}

	private static async UniTaskVoid BindToCore(IUniTaskAsyncEnumerable<string> source, Text text, CancellationToken cancellationToken, bool rebindOnError)
	{
		bool repeat = false;
		while (true)
		{
			IL_0018:
			IUniTaskAsyncEnumerator<string> e = source.GetAsyncEnumerator(cancellationToken);
			try
			{
				while (true)
				{
					bool flag;
					try
					{
						flag = await e.MoveNextAsync();
						repeat = false;
					}
					catch (Exception ex)
					{
						if (ex is OperationCanceledException)
						{
							break;
						}
						if (rebindOnError && !repeat)
						{
							repeat = true;
							goto IL_0018;
						}
						throw;
					}
					if (flag)
					{
						text.text = e.Current;
						continue;
					}
					break;
				}
			}
			finally
			{
				IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
				if (asyncDisposable != null)
				{
					await asyncDisposable.DisposeAsync();
				}
			}
			break;
		}
		int num;
		if (num != 2)
		{
		}
	}

	public static void BindTo<T>(this IUniTaskAsyncEnumerable<T> source, Text text, bool rebindOnError = true)
	{
		BindToCore(source, text, text.GetCancellationTokenOnDestroy(), rebindOnError).Forget();
	}

	public static void BindTo<T>(this IUniTaskAsyncEnumerable<T> source, Text text, CancellationToken cancellationToken, bool rebindOnError = true)
	{
		BindToCore(source, text, cancellationToken, rebindOnError).Forget();
	}

	public static void BindTo<T>(this AsyncReactiveProperty<T> source, Text text, bool rebindOnError = true)
	{
		BindToCore(source, text, text.GetCancellationTokenOnDestroy(), rebindOnError).Forget();
	}

	private static async UniTaskVoid BindToCore<T>(IUniTaskAsyncEnumerable<T> source, Text text, CancellationToken cancellationToken, bool rebindOnError)
	{
		bool repeat = false;
		while (true)
		{
			IL_0018:
			IUniTaskAsyncEnumerator<T> e = source.GetAsyncEnumerator(cancellationToken);
			try
			{
				while (true)
				{
					bool flag;
					try
					{
						flag = await e.MoveNextAsync();
						repeat = false;
					}
					catch (Exception ex)
					{
						if (ex is OperationCanceledException)
						{
							break;
						}
						if (rebindOnError && !repeat)
						{
							repeat = true;
							goto IL_0018;
						}
						throw;
					}
					if (flag)
					{
						text.text = e.Current.ToString();
						continue;
					}
					break;
				}
			}
			finally
			{
				IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
				if (asyncDisposable != null)
				{
					await asyncDisposable.DisposeAsync();
				}
			}
			break;
		}
		int num;
		if (num != 2)
		{
		}
	}

	public static void BindTo(this IUniTaskAsyncEnumerable<bool> source, Selectable selectable, bool rebindOnError = true)
	{
		BindToCore(source, selectable, selectable.GetCancellationTokenOnDestroy(), rebindOnError).Forget();
	}

	public static void BindTo(this IUniTaskAsyncEnumerable<bool> source, Selectable selectable, CancellationToken cancellationToken, bool rebindOnError = true)
	{
		BindToCore(source, selectable, cancellationToken, rebindOnError).Forget();
	}

	private static async UniTaskVoid BindToCore(IUniTaskAsyncEnumerable<bool> source, Selectable selectable, CancellationToken cancellationToken, bool rebindOnError)
	{
		bool repeat = false;
		while (true)
		{
			IL_0018:
			IUniTaskAsyncEnumerator<bool> e = source.GetAsyncEnumerator(cancellationToken);
			try
			{
				while (true)
				{
					bool flag;
					try
					{
						flag = await e.MoveNextAsync();
						repeat = false;
					}
					catch (Exception ex)
					{
						if (ex is OperationCanceledException)
						{
							break;
						}
						if (rebindOnError && !repeat)
						{
							repeat = true;
							goto IL_0018;
						}
						throw;
					}
					if (flag)
					{
						selectable.interactable = e.Current;
						continue;
					}
					break;
				}
			}
			finally
			{
				IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
				if (asyncDisposable != null)
				{
					await asyncDisposable.DisposeAsync();
				}
			}
			break;
		}
		int num;
		if (num != 2)
		{
		}
	}

	public static void BindTo<TSource, TObject>(this IUniTaskAsyncEnumerable<TSource> source, TObject monoBehaviour, Action<TObject, TSource> bindAction, bool rebindOnError = true) where TObject : MonoBehaviour
	{
		BindToCore(source, monoBehaviour, bindAction, monoBehaviour.GetCancellationTokenOnDestroy(), rebindOnError).Forget();
	}

	public static void BindTo<TSource, TObject>(this IUniTaskAsyncEnumerable<TSource> source, TObject bindTarget, Action<TObject, TSource> bindAction, CancellationToken cancellationToken, bool rebindOnError = true)
	{
		BindToCore(source, bindTarget, bindAction, cancellationToken, rebindOnError).Forget();
	}

	private static async UniTaskVoid BindToCore<TSource, TObject>(IUniTaskAsyncEnumerable<TSource> source, TObject bindTarget, Action<TObject, TSource> bindAction, CancellationToken cancellationToken, bool rebindOnError)
	{
		bool repeat = false;
		while (true)
		{
			IL_0018:
			IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
			try
			{
				while (true)
				{
					bool flag;
					try
					{
						flag = await e.MoveNextAsync();
						repeat = false;
					}
					catch (Exception ex)
					{
						if (ex is OperationCanceledException)
						{
							break;
						}
						if (rebindOnError && !repeat)
						{
							repeat = true;
							goto IL_0018;
						}
						throw;
					}
					if (flag)
					{
						bindAction(bindTarget, e.Current);
						continue;
					}
					break;
				}
			}
			finally
			{
				IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
				if (asyncDisposable != null)
				{
					await asyncDisposable.DisposeAsync();
				}
			}
			break;
		}
		int num;
		if (num != 2)
		{
		}
	}
}
