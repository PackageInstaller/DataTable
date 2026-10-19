using System.Collections.Generic;
using ACT.Utility;
using UnityEngine;

namespace ACT.World.Behave;

public class LoopElevatorBehaveEvent : MonoBehaviour
{
	public List<Renderer> walls;

	public float height;

	public float speed;

	private Camera m_MainCamera;

	private float m_MovedDistance;

	private Queue<Renderer> m_Queue;

	private bool m_Running;

	private Plane[] m_Cameraplanes = new Plane[6];

	private void OnValidate()
	{
		walls.Sort((Renderer x, Renderer y) =>
		{
			Vector3 position = y.transform.position;
			return (x.transform.position.y > position.y) ? 1 : (-1);
		});
	}

	private void Awake()
	{
		m_MainCamera = GameUtility.mainCamera;
		m_MovedDistance = 0f;
		m_Queue = new Queue<Renderer>();
		for (int i = 0; i < walls.Count; i++)
		{
			m_Queue.Enqueue(walls[i]);
		}
	}

	private void Update()
	{
		if (m_Running)
		{
			Move();
			CycleBackGround();
		}
	}

	private void Move()
	{
		float num = GameManager.timeSystem.globalSpeed * Time.deltaTime * speed;
		foreach (Renderer wall in walls)
		{
			wall.transform.Translate(Vector3.down * num);
		}
		m_MovedDistance += num;
	}

	private void CycleBackGround()
	{
		if (!(m_MovedDistance < height) && !CheckVisible())
		{
			m_MovedDistance = 0f;
		}
	}

	private bool CheckVisible()
	{
		Renderer renderer = m_Queue.Peek();
		if (!IsVisibleByCamera(m_MainCamera, renderer))
		{
			m_Queue.Dequeue();
			renderer.transform.Translate(Vector3.up * ((float)walls.Count * height));
			m_Queue.Enqueue(renderer);
			CheckVisible();
			return false;
		}
		return true;
	}

	private bool IsVisibleByCamera(Camera camera, Renderer renderer)
	{
		GeometryUtility.CalculateFrustumPlanes(camera, m_Cameraplanes);
		return GeometryUtility.TestPlanesAABB(m_Cameraplanes, renderer.bounds);
	}

	public void Run()
	{
		m_Running = true;
	}

	public void Stop()
	{
		m_Running = false;
	}

	public void CalculateHeight()
	{
		height = walls[0].bounds.size.y;
	}
}
