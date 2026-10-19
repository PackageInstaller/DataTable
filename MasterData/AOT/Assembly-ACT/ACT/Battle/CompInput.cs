using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompInput : EcsComponent
{
	public InputDirMode inputDirMode;

	private Vector2 m_Dir;

	private EInputDir m_InputDir;

	private const EInputDir m_DirXMask = EInputDir.Left | EInputDir.Right;

	private EInputDir m_DirX;

	private const EInputDir m_DirYMask = EInputDir.Up | EInputDir.Down;

	private EInputDir m_DirY;

	public bool dirXSet;

	public bool dirYSet;

	public bool isSetLeft;

	public ActionList<Entity, float> onUpPressed = new ActionList<Entity, float>();

	public ActionList<Entity, float> onDownPressed = new ActionList<Entity, float>();

	public ActionList<Entity, float> onLeftPressed = new ActionList<Entity, float>();

	public ActionList<Entity, float> onRightPressed = new ActionList<Entity, float>();

	public Vector2 dir
	{
		get
		{
			return m_Dir;
		}
		set
		{
			if (InDeadzone(value))
			{
				value = Vector2.zero;
			}
			m_Dir = value.normalized;
			UpdateInputDir(m_Dir);
		}
	}

	public EInputDir inputDir
	{
		get
		{
			return m_InputDir;
		}
		set
		{
			m_InputDir = value;
			Vector2 zero = Vector2.zero;
			if ((m_InputDir & EInputDir.Left) > EInputDir.None)
			{
				zero.x--;
			}
			if ((m_InputDir & EInputDir.Right) > EInputDir.None)
			{
				zero.x++;
			}
			if ((m_InputDir & EInputDir.Up) > EInputDir.None)
			{
				zero.y++;
			}
			if ((m_InputDir & EInputDir.Down) > EInputDir.None)
			{
				zero.y--;
			}
			dir = zero;
		}
	}

	public EInputDir dirX
	{
		get
		{
			return m_DirX;
		}
		private set
		{
			if (m_DirX != value)
			{
				m_DirX = value;
				dirXSet = true;
			}
		}
	}

	public EInputDir dirY
	{
		get
		{
			return m_DirY;
		}
		private set
		{
			if (m_DirY != value)
			{
				m_DirY = value;
				dirYSet = true;
			}
		}
	}

	private void UpdateInputDir(Vector2 value)
	{
		switch (inputDirMode)
		{
		case InputDirMode.FourDirection:
			m_InputDir = EInputDir.None;
			if (value != Vector2.zero)
			{
				float num2 = GameLoader.meta.upAngle / 2f;
				float num3 = GameLoader.meta.downAngle / 2f;
				float num4 = GameLoader.meta.absoluteUpAngle / 2f;
				float num5 = GameLoader.meta.absoluteDownAngle / 2f;
				float num6 = Vector2.SignedAngle(Vector2.right, value);
				if (90f - num4 < num6 && num6 < 90f + num4)
				{
					m_InputDir |= EInputDir.Up;
				}
				else if (0f - (90f + num5) < num6 && num6 < 0f - (90f - num5))
				{
					m_InputDir |= EInputDir.Down;
				}
				else
				{
					if (90f - num2 < num6 && num6 < 90f + num2)
					{
						m_InputDir |= EInputDir.Up;
					}
					if (0f - (90f + num3) < num6 && num6 < 0f - (90f - num3))
					{
						m_InputDir |= EInputDir.Down;
					}
					if (-90f < num6 && num6 < 90f)
					{
						m_InputDir |= EInputDir.Right;
					}
					if (90f < num6 || num6 < -90f)
					{
						m_InputDir |= EInputDir.Left;
					}
				}
			}
			dirX = m_InputDir & (EInputDir.Left | EInputDir.Right);
			dirY = m_InputDir & (EInputDir.Up | EInputDir.Down);
			break;
		case InputDirMode.Gimbal:
			m_InputDir = EInputDir.None;
			if (value != Vector2.zero)
			{
				float num = Vector2.SignedAngle(Vector2.right, value);
				if (-90f < num && num <= 90f)
				{
					m_InputDir |= EInputDir.Right;
				}
				if (90f < num || num <= -90f)
				{
					m_InputDir |= EInputDir.Left;
				}
			}
			dirX = m_InputDir & (EInputDir.Left | EInputDir.Right);
			break;
		}
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		Clear();
	}

	public void Clear()
	{
		ResetDir();
		onUpPressed.Clear();
		onDownPressed.Clear();
		onRightPressed.Clear();
		onLeftPressed.Clear();
	}

	public void ResetDir()
	{
		m_Dir = Vector2.zero;
		m_InputDir = EInputDir.None;
		m_DirX = EInputDir.None;
		dirXSet = false;
		m_DirY = EInputDir.None;
		dirYSet = false;
	}

	private bool InDeadzone(Vector2 input)
	{
		return input.magnitude < GameLoader.meta.joyconDeadzone;
	}
}
