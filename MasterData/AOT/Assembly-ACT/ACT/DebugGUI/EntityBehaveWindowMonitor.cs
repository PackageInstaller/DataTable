using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DebugGUI;

public class EntityBehaveWindowMonitor : SingleMonitor
{
	private static Dictionary<Entity, EntityBehaveWindow> s_Windows = new Dictionary<Entity, EntityBehaveWindow>();

	private DebugGUISelectionGrid selectionGrid;

	private CancellationTokenSource tokenSource;

	private bool _needRefreshNextFrame;

	private Entity[] _entities;

	public static EntityBehaveWindow DebugBehave(Entity eb)
	{
		if (s_Windows.TryGetValue(eb, out var value))
		{
			return value;
		}
		Rect defaultWindowRect = DebugWindowManager.instance.defaultWindowRect;
		if (s_Windows.Count > 0)
		{
			EntityBehaveWindow value2 = s_Windows.Last().Value;
			defaultWindowRect = DebugWindowManager.instance.defaultWindowRect;
			if (value2.eb != eb)
			{
				defaultWindowRect.position = value2.position.position + new Vector2(30f, 10f);
			}
		}
		EntityBehaveWindow entityBehaveWindow = new EntityBehaveWindow(eb)
		{
			position = defaultWindowRect
		};
		entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<IronMonitor>(entityBehaveWindow));
		entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<StateMonitor>(entityBehaveWindow));
		entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<TPMonitor>(entityBehaveWindow));
		entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<TraceMonitor>(entityBehaveWindow));
		entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<PostureMonitor>(entityBehaveWindow));
		entityBehaveWindow.Open();
		s_Windows[eb] = entityBehaveWindow;
		return entityBehaveWindow;
	}

	private async void OnRefresh(Entity eb)
	{
		if (!_needRefreshNextFrame)
		{
			_needRefreshNextFrame = true;
			await UniTask.NextFrame();
			_needRefreshNextFrame = false;
			Refresh();
		}
	}

	private void Refresh()
	{
		_entities = GameManager.entities.GetAllEntities().ToArray();
		selectionGrid.texts = _entities.Select((Entity e) => e.DebugName()).ToArray();
	}

	protected override bool OnInit()
	{
		tokenSource = new CancellationTokenSource();
		GameManager.entities.OnEntityCreate += OnRefresh;
		GameManager.entities.OnEntityBeforeDestroy += OnRefresh;
		selectionGrid = sigwnd.AddGUI(new DebugGUISelectionGrid("Behave:"));
		Refresh();
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("state", () =>
		{
			Entity entity = _entities[selectionGrid.selected];
			if (s_Windows.TryGetValue(entity, out var value))
			{
				s_Windows.Remove(entity);
				value.Close();
			}
			else
			{
				DebugBehave(entity);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("trace", () =>
		{
			Entity entity = _entities[selectionGrid.selected];
			if (s_Windows.TryGetValue(entity, out var value))
			{
				s_Windows.Remove(entity);
				value.Close();
			}
			Rect defaultWindowRect = DebugWindowManager.instance.defaultWindowRect;
			if (s_Windows.Count > 0)
			{
				EntityBehaveWindow value2 = s_Windows.Last().Value;
				defaultWindowRect = DebugWindowManager.instance.defaultWindowRect;
				if (value2.eb != entity)
				{
					defaultWindowRect.position = value2.position.position + new Vector2(30f, 10f);
				}
			}
			defaultWindowRect.height = 60f;
			EntityBehaveWindow entityBehaveWindow = new EntityBehaveWindow(entity)
			{
				position = defaultWindowRect
			};
			entityBehaveWindow.AddMonitor(EntityBehaveMonitor.Init<TraceMonitor>(entityBehaveWindow));
			entityBehaveWindow.AddGUI(new DebugGUILabel("tracking"));
			entityBehaveWindow.Open();
			s_Windows.Add(entity, entityBehaveWindow);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("remove monitor", () =>
		{
			Entity key = _entities[selectionGrid.selected];
			if (s_Windows.TryGetValue(key, out var value))
			{
				s_Windows.Remove(key);
				value.Close();
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("clear monitors", () =>
		{
			foreach (KeyValuePair<Entity, EntityBehaveWindow> s_Window in s_Windows)
			{
				s_Window.Value.Close();
			}
			s_Windows.Clear();
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		return true;
	}

	protected override void OnRemove()
	{
		tokenSource.Cancel();
		tokenSource.Dispose();
		GameManager.entities.OnEntityCreate -= OnRefresh;
		GameManager.entities.OnEntityBeforeDestroy -= OnRefresh;
	}
}
