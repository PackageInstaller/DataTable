using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class PaperCutManager : MonoBehaviour
{
	[SerializeField]
	private bool useEditor = true;

	public int checkRadius = 10;

	public int checkCloseRadius = 1;

	private Dictionary<int, Transform> checkPointPanelList = new Dictionary<int, Transform>();

	public Transform checkPointPanelParent;

	private Transform checkPointPanelTrans;

	public int checkPointRadius = 5;

	private List<Vector4> brushPointList;

	private List<Vector2> pointIndices;

	private byte[,] points;

	public int maxDrawPointStep = 5;

	private int curDrawPointStep;

	private List<Vector3> drawLinePoints;

	private Rect drawAABB;

	private bool gameOver;

	public float BRUSH_SIZE = 3.84f;

	private int TEX_WIDTH;

	private int TEX_HEIGHT;

	private float PANEL_WIDTH;

	private float PANEL_HEIGHT;

	private float panelWidthScale;

	private float panelHeightScale;

	public Material brushMaterial;

	public Material _ResultMaterial;

	public SpriteRenderer resultSpriteRenderer;

	private bool m_bMouseDown;

	private Vector3 lastPosition = Vector3.zero;

	private Vector3 curPosition = Vector3.zero;

	private Vector3 startPosition = Vector3.zero;

	private Rect rcDraw;

	private Rect drawBound;

	public Texture2D tempTexture2D;

	private Action onComplete;

	private Action onStartDraw;

	private bool startDraw;

	public GameObject drawSpriteGo;

	private MeshRenderer meshRenderer;

	private Mesh mesh;

	private float screenAspect;

	private float worldScreenWidth;

	private float worldScreenHeight;

	private bool hadDrawn;

	private Rect resultBox;

	public MeshFilter resultMeshFilter;

	public Texture bgTexture;

	public SpriteRenderer bgRenderer;

	private Transform bgTrans;

	private Mesh resultMesh;

	private PaperCutUIImage resultUIImage;

	private Vector2 canvasScale;

	private Canvas canvas;

	public GameObject cursorGo;

	public float scissorUpdateStep = 10f;

	public string cueSheetName_loop = "ui_system_search";

	public string cueName_loop = "search_environment";

	private PlayableDirector cursoTimeline;

	public float LeanTweenTime = 0.05f;

	public LeanTweenType leanTweenType = LeanTweenType.easeInOutCubic;

	private bool lastClickUI;

	private Vector3 lastCursorPos;

	private Vector3 lastScreenPos;

	private Vector3 curWorldPos;

	private Vector2 leftPoint = new Vector2(0f, 0f);

	private Vector2 rightPoint = new Vector2(0f, 0f);

	private List<Vector2> adjacentList = new List<Vector2>();

	private int xMin;

	private int xMax;

	private int yMin;

	private int yMax;

	private int xLen;

	private int yLen;

	private short[,] validArea;

	private int tempBloomMode;

	public void GameStart()
	{
		ResetGame();
		gameOver = false;
		startDraw = false;
		hadDrawn = false;
		drawSpriteGo.SetActive(value: true);
		meshRenderer.enabled = true;
		cursorGo.SetActive(value: false);
	}

	public void GameOver()
	{
		gameOver = true;
		drawSpriteGo.SetActive(value: false);
		cursoTimeline.Pause();
		AudioManager.Instance.StopImmediate("effect");
		AudioManager.Instance.Pause("effect", isPaused: false);
		cursorGo.SetActive(value: false);
	}

	private void Start()
	{
		AdaptScreen();
		hadDrawn = false;
		screenAspect = Camera.main.orthographicSize * 2f / (float)Screen.height;
		worldScreenHeight = Camera.main.orthographicSize;
		worldScreenWidth = (float)Screen.width * screenAspect / 2f;
		GetComponent<MeshFilter>().mesh = (mesh = new Mesh());
		meshRenderer = GetComponent<MeshRenderer>();
		meshRenderer.enabled = false;
		resultMesh = new Mesh();
		brushPointList = new List<Vector4>();
		pointIndices = new List<Vector2>();
		drawLinePoints = new List<Vector3>();
		gameOver = true;
		startDraw = false;
		Vector3 size = bgRenderer.sprite.bounds.size;
		Vector4 border = bgRenderer.sprite.border;
		bgTrans = bgRenderer.transform;
		PANEL_WIDTH = (size.x - border.x * 0.01f - border.z * 0.01f) / screenAspect * bgTrans.localScale.x;
		PANEL_HEIGHT = (size.y - border.y * 0.01f - border.w * 0.01f) / screenAspect * bgTrans.localScale.y;
		TEX_WIDTH = (int)PANEL_WIDTH;
		TEX_HEIGHT = (int)PANEL_HEIGHT;
		panelWidthScale = PANEL_WIDTH / (float)TEX_WIDTH;
		panelHeightScale = PANEL_HEIGHT / (float)TEX_HEIGHT;
		drawAABB.xMin = TEX_WIDTH;
		drawAABB.xMax = 0f;
		drawAABB.yMin = TEX_HEIGHT;
		drawAABB.yMax = 0f;
		resultBox = default(Rect);
		rcDraw = new Rect(((float)Screen.width - PANEL_WIDTH) / 2f, ((float)Screen.height - PANEL_HEIGHT) / 2f, PANEL_WIDTH, PANEL_HEIGHT);
		drawBound = new Rect(rcDraw.xMin + BRUSH_SIZE / 2f + 1f, rcDraw.yMin + BRUSH_SIZE / 2f + 1f, rcDraw.width - BRUSH_SIZE - 2f, rcDraw.height - BRUSH_SIZE - 2f);
		points = new byte[TEX_WIDTH, TEX_HEIGHT];
		cursoTimeline = cursorGo.GetComponent<PlayableDirector>();
		ResetGame();
	}

	private void AdaptScreen()
	{
		Vector3 size = base.transform.Find("Bg").GetComponent<SpriteRenderer>().bounds.size;
		float x = size.x;
		float y = size.y;
		float num = Camera.main.orthographicSize * 2f;
		float a = num / (float)Screen.height * (float)Screen.width / x;
		float b = num / y;
		float num2 = Mathf.Max(a, b);
		float num3 = Mathf.Min(a, b);
		base.transform.localScale = new Vector3(num2, num2, 1f);
		bgRenderer.transform.localScale = new Vector3(num3, num3, 1f);
	}

	private void ResetGame()
	{
		for (int i = 0; i < TEX_WIDTH; i++)
		{
			for (int j = 0; j < TEX_HEIGHT; j++)
			{
				points[i, j] = 0;
			}
		}
		if (tempTexture2D != null)
		{
			UnityEngine.Object.Destroy(tempTexture2D);
		}
		tempTexture2D = new Texture2D(TEX_WIDTH, TEX_HEIGHT, TextureFormat.ARGB32, mipChain: false);
		brushPointList.Clear();
		pointIndices.Clear();
		drawLinePoints.Clear();
		mesh.Clear();
		resultMesh.Clear();
		m_bMouseDown = false;
		lastPosition = Vector3.zero;
		curPosition = Vector3.zero;
		startPosition = Vector3.zero;
		curDrawPointStep = 0;
	}

	private void Update()
	{
		if (gameOver)
		{
			lastClickUI = true;
		}
		else
		{
			if (Input.touchCount <= 0)
			{
				return;
			}
			if (IsClickOnUI())
			{
				lastClickUI = true;
			}
			else if (Input.touches[0].phase == TouchPhase.Began)
			{
				if (lastClickUI)
				{
					lastClickUI = false;
				}
				else
				{
					OnMouseMove(Input.touches[0].position);
				}
			}
			else if (Input.touches[0].phase == TouchPhase.Moved)
			{
				if (lastClickUI)
				{
					lastClickUI = false;
				}
				else
				{
					OnMouseMove(Input.touches[0].position);
				}
			}
			else if (Input.touches[0].phase == TouchPhase.Ended)
			{
				if (lastClickUI)
				{
					lastClickUI = false;
				}
				else
				{
					OnMouseUp();
				}
			}
		}
	}

	private void HandleMouseMoveInEditor()
	{
		if (Input.GetMouseButton(0))
		{
			if (IsClickOnUI())
			{
				return;
			}
			OnMouseMove(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 0f));
		}
		if (Input.GetMouseButtonUp(0) && !IsClickOnUI())
		{
			OnMouseUp();
		}
	}

	public bool IsClickOnUI()
	{
		Vector3 position = Camera.main.ScreenToWorldPoint(Input.mousePosition);
		Vector3 vector = Camera.main.WorldToScreenPoint(position);
		return IsPointerOverUIObject(vector);
	}

	public bool IsPointerOverUIObject(Vector2 screenPosition)
	{
		PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
		pointerEventData.position = new Vector2(screenPosition.x, screenPosition.y);
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(pointerEventData, list);
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].gameObject.GetComponent<RectTransform>() != null)
			{
				return true;
			}
		}
		return false;
	}

	private void OnMouseUp()
	{
		if (!gameOver && !startPosition.Equals(Vector3.zero))
		{
			DrawLine(curPosition, startPosition, needToDrawBrush: false);
			if (!gameOver)
			{
				GameOver();
				if (onComplete != null)
				{
					onComplete();
				}
			}
		}
		lastPosition = Vector3.zero;
		m_bMouseDown = false;
	}

	private void OnMouseMove(Vector3 pos)
	{
		pos.x = ((pos.x < drawBound.xMin) ? drawBound.xMin : pos.x);
		pos.x = ((pos.x > drawBound.xMax) ? drawBound.xMax : pos.x);
		pos.y = ((pos.y < drawBound.yMin) ? drawBound.yMin : pos.y);
		pos.y = ((pos.y > drawBound.yMax) ? drawBound.yMax : pos.y);
		curPosition = pos;
		if (!m_bMouseDown)
		{
			OnMouseDown();
		}
		if (lastPosition.Equals(Vector3.zero))
		{
			lastPosition = curPosition;
			return;
		}
		DrawLine(lastPosition, curPosition, needToDrawBrush: true);
		HandleCursorPosition(curPosition);
		lastPosition = curPosition;
	}

	private void OnMouseDown()
	{
		m_bMouseDown = true;
		DrawPoint(curPosition);
		startPosition = curPosition;
		cursorGo.SetActive(value: true);
		HandleCursorPosition(curPosition, init: true);
		cursoTimeline.time = 0.0;
		cursoTimeline.Play();
		AudioManager.Instance.Play("effect", cueSheetName_loop, cueName_loop, useStream: false);
	}

	private void HandleCursorPosition(Vector3 curScreenPos, bool init = false)
	{
		curWorldPos = Camera.main.ScreenToWorldPoint(curScreenPos);
		curWorldPos.z = 0f;
		if (init)
		{
			cursorGo.transform.position = curWorldPos;
			return;
		}
		lastCursorPos = cursorGo.transform.position;
		lastScreenPos = Camera.main.WorldToScreenPoint(lastCursorPos);
		lastScreenPos.z = 0f;
		if (Vector3.Distance(lastScreenPos, curScreenPos) > scissorUpdateStep)
		{
			LeanTween.cancel(cursorGo);
			LeanTween.move(cursorGo, curWorldPos, LeanTweenTime).setEase(leanTweenType);
			Vector3 vector = curScreenPos - lastScreenPos;
			float num = Vector3.Angle(Vector3.up, vector);
			LeanTween.rotate(to: new Vector3(0f, 0f, (!(Vector3.Cross(vector, Vector3.up).z > 0f)) ? ((num < 0f) ? (0f - num) : num) : ((num > 0f) ? (0f - num) : num)), gameObject: cursorGo, time: LeanTweenTime).setEase(leanTweenType);
		}
	}

	private void DrawPoint(Vector3 pos)
	{
		DrawBrush(new Vector2(pos.x, pos.y), needToDrawBrush: true);
	}

	private void DrawLine(Vector3 start, Vector3 end, bool needToDrawBrush)
	{
		if (!(Vector3.Distance(start, end) > 1f))
		{
			return;
		}
		DrawLineWithHandler(start, end, delegate(Vector2 curPos)
		{
			if (!gameOver)
			{
				DrawBrush(curPos, needToDrawBrush);
			}
		});
	}

	private void DrawLineWithHandler(Vector2 start, Vector2 end, Action<Vector2> handler)
	{
		float num = end.x - start.x;
		float num2 = end.y - start.y;
		float num3 = ((!(Mathf.Abs(num) >= Mathf.Abs(num2))) ? Mathf.Abs(num2) : Mathf.Abs(num));
		float num4 = num / num3;
		float num5 = num2 / num3;
		for (int i = 0; (float)i < num3; i++)
		{
			handler(start);
			start.x += num4;
			start.y += num5;
		}
	}

	private void DrawBrush(Vector2 pos, bool needToDrawBrush)
	{
		if (!startDraw)
		{
			startDraw = true;
			if (onStartDraw != null)
			{
				onStartDraw();
			}
		}
		if (needToDrawBrush)
		{
			DrawBrush(pos.x, pos.y);
		}
		int num = Mathf.FloorToInt((pos.x - rcDraw.xMin) / PANEL_WIDTH * (float)TEX_WIDTH);
		int num2 = Mathf.FloorToInt((pos.y - rcDraw.yMin) / PANEL_HEIGHT * (float)TEX_HEIGHT);
		drawAABB.xMin = Mathf.Min(num, drawAABB.xMin);
		drawAABB.xMax = Mathf.Max(num, drawAABB.xMax);
		drawAABB.yMin = Mathf.Min(num2, drawAABB.yMin);
		drawAABB.yMax = Mathf.Max(num2, drawAABB.yMax);
		if (pointIndices.Count > 0)
		{
			Vector2 vector = pointIndices[pointIndices.Count - 1];
			int num3 = (int)vector.x;
			int num4 = (int)vector.y;
			float num5 = vector.x;
			float num6 = vector.y;
			if (Mathf.Abs(num - num3) > 1 || Mathf.Abs(num2 - num4) > 1)
			{
				float num7 = num - num3;
				float num8 = num2 - num4;
				float num9 = ((!(Mathf.Abs(num7) >= Mathf.Abs(num8))) ? Mathf.Abs(num8) : Mathf.Abs(num7));
				float num10 = num7 / num9;
				float num11 = num8 / num9;
				for (int i = 0; (float)i < num9; i++)
				{
					num5 += num10;
					num6 += num11;
					num3 = Mathf.FloorToInt(num5);
					num4 = Mathf.FloorToInt(num6);
					vector = pointIndices[pointIndices.Count - 1];
					if (vector.x != (float)num3 || vector.y != (float)num4)
					{
						points[num3, num4] = 1;
						pointIndices.Add(new Vector2(num3, num4));
					}
				}
			}
			else if (vector.x != (float)num || vector.y != (float)num2)
			{
				pointIndices.Add(new Vector2(num, num2));
			}
		}
		else
		{
			pointIndices.Add(new Vector2(num, num2));
		}
		points[num, num2] = 1;
		if (!gameOver && CheckClose())
		{
			GameOver();
			if (onComplete != null)
			{
				onComplete();
			}
		}
	}

	public void DisplayResultImage(PaperCutUIImage image)
	{
		resultUIImage = image;
		if (FindDrawArea())
		{
			resultUIImage.gameObject.SetActive(value: true);
			Vector2 vector = GenerateResultMesh();
			image.gameObject.GetComponent<RectTransform>().sizeDelta = vector * 2f;
			resultUIImage.SetPaperCutMesh(resultMesh);
			resultUIImage.SetPaperCutTexture(resultSpriteRenderer.sprite.texture, tempTexture2D, bgTexture);
		}
		else
		{
			resultUIImage.gameObject.SetActive(value: false);
		}
		drawSpriteGo.SetActive(value: false);
		meshRenderer.enabled = false;
	}

	private Vector2 GenerateResultMesh()
	{
		Vector3[] array = new Vector3[4];
		int[] array2 = new int[6];
		Vector2[] array3 = new Vector2[4];
		Vector2[] array4 = new Vector2[4];
		Vector2[] array5 = new Vector2[4];
		float num = (resultBox.xMax - resultBox.xMin + 1f) / 2f * canvasScale.x;
		float num2 = (resultBox.yMax - resultBox.yMin + 1f) / 2f * canvasScale.y;
		Vector3 zero = Vector3.zero;
		zero.x = 0f - num;
		zero.y = 0f - num2;
		array[0] = zero;
		zero.x = num;
		zero.y = 0f - num2;
		array[1] = zero;
		zero.x = 0f - num;
		zero.y = num2;
		array[2] = zero;
		zero.x = num;
		zero.y = num2;
		array[3] = zero;
		array3[0] = new Vector2(resultBox.xMin / PANEL_WIDTH, resultBox.yMin / PANEL_HEIGHT);
		array3[1] = new Vector2(resultBox.xMax / PANEL_WIDTH, resultBox.yMin / PANEL_HEIGHT);
		array3[2] = new Vector2(resultBox.xMin / PANEL_WIDTH, resultBox.yMax / PANEL_HEIGHT);
		array3[3] = new Vector2(resultBox.xMax / PANEL_WIDTH, resultBox.yMax / PANEL_HEIGHT);
		float num3 = resultSpriteRenderer.bounds.size.x / screenAspect;
		float num4 = resultSpriteRenderer.bounds.size.y / screenAspect;
		float num5 = (PANEL_WIDTH - num3) / 2f;
		float num6 = (PANEL_HEIGHT - num4) / 2f;
		array4[0] = new Vector2((resultBox.xMin - num5) / num3, (resultBox.yMin - num6) / num4);
		array4[1] = new Vector2((resultBox.xMax - num5) / num3, (resultBox.yMin - num6) / num4);
		array4[2] = new Vector2((resultBox.xMin - num5) / num3, (resultBox.yMax - num6) / num4);
		array4[3] = new Vector2((resultBox.xMax - num5) / num3, (resultBox.yMax - num6) / num4);
		float num7 = bgRenderer.bounds.size.x / screenAspect;
		float num8 = bgRenderer.bounds.size.y / screenAspect;
		num5 = (PANEL_WIDTH - num7) / 2f;
		num6 = (PANEL_HEIGHT - num8) / 2f;
		array5[0] = new Vector2((resultBox.xMin - num5) / num7, (resultBox.yMin - num6) / num8);
		array5[1] = new Vector2((resultBox.xMax - num5) / num7, (resultBox.yMin - num6) / num8);
		array5[2] = new Vector2((resultBox.xMin - num5) / num7, (resultBox.yMax - num6) / num8);
		array5[3] = new Vector2((resultBox.xMax - num5) / num7, (resultBox.yMax - num6) / num8);
		array2[0] = 0;
		array2[1] = 3;
		array2[2] = 1;
		array2[3] = 0;
		array2[4] = 2;
		array2[5] = 3;
		resultMesh.vertices = array;
		resultMesh.uv = array3;
		resultMesh.uv2 = array4;
		resultMesh.uv3 = array5;
		resultMesh.triangles = array2;
		return new Vector2(num, num2);
	}

	private void DrawBrush(float x, float y)
	{
		brushPointList.Add(new Vector4(x, y, 0f, 0f));
		curDrawPointStep++;
		if (curDrawPointStep >= maxDrawPointStep + 2)
		{
			hadDrawn = true;
			curDrawPointStep = 0;
			CalculateSidePoint(new Vector2(x, y), out leftPoint, out rightPoint);
			leftPoint.x = (leftPoint.x * screenAspect - worldScreenWidth) / base.transform.localScale.x;
			rightPoint.x = (rightPoint.x * screenAspect - worldScreenWidth) / base.transform.localScale.x;
			leftPoint.y = (leftPoint.y * screenAspect - worldScreenHeight) / base.transform.localScale.y;
			rightPoint.y = (rightPoint.y * screenAspect - worldScreenHeight) / base.transform.localScale.y;
			drawLinePoints.Add(new Vector3(leftPoint.x, leftPoint.y, 0f));
			drawLinePoints.Add(new Vector3(rightPoint.x, rightPoint.y, 0f));
		}
	}

	private void CalculateSidePoint(Vector2 curPoint, out Vector2 leftPoint, out Vector2 rightPoint)
	{
		int index = brushPointList.Count - maxDrawPointStep - 2;
		Vector2 vector = brushPointList[index];
		Vector3 lhs = curPoint - vector;
		lhs.z = 0f;
		lhs.Normalize();
		Vector2 vector2 = new Vector2(0f - lhs.y, lhs.x);
		leftPoint.x = curPoint.x + vector2.x * BRUSH_SIZE;
		leftPoint.y = curPoint.y + vector2.y * BRUSH_SIZE;
		rightPoint.x = curPoint.x - vector2.x * BRUSH_SIZE;
		rightPoint.y = curPoint.y - vector2.y * BRUSH_SIZE;
		Vector3 rhs = leftPoint - vector;
		rhs.z = 0f;
		if (Vector3.Cross(lhs, rhs).z > 0f)
		{
			float x = leftPoint.x;
			float y = leftPoint.y;
			leftPoint.x = rightPoint.x;
			leftPoint.y = rightPoint.y;
			rightPoint.x = x;
			rightPoint.y = y;
		}
	}

	private void LateUpdate()
	{
		if (!hadDrawn)
		{
			return;
		}
		hadDrawn = false;
		if (drawLinePoints.Count >= 3)
		{
			Vector3[] array = new Vector3[drawLinePoints.Count];
			int[] array2 = new int[(drawLinePoints.Count - 2) * 3];
			int num = 0;
			for (int i = 0; i < drawLinePoints.Count; i++)
			{
				array[i] = drawLinePoints[i];
			}
			for (int j = 0; j < drawLinePoints.Count - 2; j += 2)
			{
				array2[num] = j;
				array2[num + 1] = j + 1;
				array2[num + 2] = j + 2;
				array2[num + 3] = j + 2;
				array2[num + 4] = j + 1;
				array2[num + 5] = j + 3;
				num += 6;
			}
			mesh.vertices = array;
			mesh.triangles = array2;
		}
	}

	private bool CheckClose()
	{
		int num = pointIndices.Count - 1;
		Vector2 vector = pointIndices[pointIndices.Count - 1];
		int num2 = (int)vector.x;
		int num3 = (int)vector.y;
		adjacentList.Clear();
		bool flag = false;
		int num4 = -1;
		int num5 = -1;
		int num6 = int.MaxValue;
		for (int num7 = checkCloseRadius; num7 >= 1; num7--)
		{
			int num8 = Mathf.Max(0, num2 - num7);
			int num9 = Mathf.Min(TEX_WIDTH - 1, num2 + num7);
			int num10 = Mathf.Max(0, num3 - num7);
			int num11 = Mathf.Min(TEX_HEIGHT - 1, num3 + num7);
			int num12 = Mathf.Max(0, num2 - checkRadius);
			int num13 = Mathf.Min(TEX_WIDTH - 1, num2 + checkRadius);
			int num14 = Mathf.Max(0, num3 - checkRadius);
			int num15 = Mathf.Min(TEX_HEIGHT - 1, num3 + checkRadius);
			bool flag2 = false;
			do
			{
				num = Mathf.Max(0, num - 1);
				adjacentList.Add(pointIndices[num]);
				flag2 = ((int)pointIndices[num].x >= num12 && (int)pointIndices[num].x <= num13 && (int)pointIndices[num].y >= num14 && (int)pointIndices[num].y <= num15) || ((Mathf.Abs(pointIndices[num].x - (float)num2) < (float)checkRadius && Mathf.Abs(pointIndices[num].y - (float)num3) < (float)checkRadius) ? true : false);
			}
			while ((num > 0) & flag2);
			int num16 = 0;
			for (int i = num8; i <= num9; i++)
			{
				if (points[i, num11] != 1)
				{
					continue;
				}
				num16++;
				bool flag3 = false;
				foreach (Vector2 adjacent in adjacentList)
				{
					if (adjacent.x == (float)i && adjacent.y == (float)num11)
					{
						flag3 = true;
						break;
					}
				}
				if (!flag3)
				{
					int num17 = Mathf.Abs(i - num2) + Mathf.Abs(num11 - num3);
					if (num17 <= num6)
					{
						num6 = num17;
						num4 = i;
						num5 = num11;
					}
					flag = true;
				}
			}
			for (int num18 = num11 - 1; num18 >= num10; num18--)
			{
				if (points[num9, num18] == 1)
				{
					num16++;
					bool flag4 = false;
					foreach (Vector2 adjacent2 in adjacentList)
					{
						if (adjacent2.x == (float)num9 && adjacent2.y == (float)num18)
						{
							flag4 = true;
							break;
						}
					}
					if (!flag4)
					{
						int num19 = Mathf.Abs(num9 - num2) + Mathf.Abs(num18 - num3);
						if (num19 <= num6)
						{
							num6 = num19;
							num4 = num9;
							num5 = num18;
						}
						flag = true;
					}
				}
			}
			for (int num20 = num9 - 1; num20 >= num8; num20--)
			{
				if (points[num20, num10] == 1)
				{
					num16++;
					bool flag5 = false;
					foreach (Vector2 adjacent3 in adjacentList)
					{
						if (adjacent3.x == (float)num20 && adjacent3.y == (float)num10)
						{
							flag5 = true;
							break;
						}
					}
					if (!flag5)
					{
						int num21 = Mathf.Abs(num20 - num2) + Mathf.Abs(num10 - num3);
						if (num21 <= num6)
						{
							num6 = num21;
							num4 = num20;
							num5 = num10;
						}
						flag = true;
					}
				}
			}
			for (int j = num10 + 1; j < num11; j++)
			{
				if (points[num8, j] != 1)
				{
					continue;
				}
				num16++;
				bool flag6 = false;
				foreach (Vector2 adjacent4 in adjacentList)
				{
					if (adjacent4.x == (float)num8 && adjacent4.y == (float)j)
					{
						flag6 = true;
						break;
					}
				}
				if (!flag6)
				{
					int num22 = Mathf.Abs(num8 - num2) + Mathf.Abs(j - num3);
					if (num22 <= num6)
					{
						num6 = num22;
						num4 = num8;
						num5 = j;
					}
					flag = true;
				}
			}
		}
		if (flag)
		{
			DrawLineWithHandler(new Vector2(num2, num3), new Vector2(num4, num5), delegate(Vector2 curPos)
			{
				points[Mathf.FloorToInt(curPos.x), Mathf.FloorToInt(curPos.y)] = 1;
			});
		}
		return flag;
	}

	private bool FindDrawArea()
	{
		bool result = false;
		xMin = (int)drawAABB.xMin;
		xMax = (int)drawAABB.xMax;
		yMin = (int)drawAABB.yMin;
		yMax = (int)drawAABB.yMax;
		validArea = new short[xMax - xMin + 1, yMax - yMin + 1];
		for (int i = 0; i < yMax - yMin + 1; i++)
		{
			for (int j = 0; j < xMax - xMin + 1; j++)
			{
				validArea[j, i] = 0;
			}
		}
		new Color(1f, 0f, 0f, 0f);
		new Color(0f, 0f, 1f, 0f);
		xLen = xMax - xMin + 1;
		yLen = yMax - yMin + 1;
		short num = 0;
		short num2 = 0;
		Dictionary<short, bool> dictionary = new Dictionary<short, bool>();
		Dictionary<short, bool> dictionary2 = new Dictionary<short, bool>();
		for (int k = 0; k < yLen; k++)
		{
			for (int l = 0; l < xLen; l++)
			{
				if (validArea[l, k] != 0 || points[l + xMin, k + yMin] != 0)
				{
					continue;
				}
				num++;
				dictionary2[num] = true;
				Queue<int> queue = new Queue<int>();
				Queue<int> queue2 = new Queue<int>();
				queue.Enqueue(l);
				queue2.Enqueue(k);
				while (queue.Count > 0)
				{
					int num3 = queue.Dequeue();
					int num4 = queue2.Dequeue();
					if (num3 >= 0 && num3 < xLen && num4 >= 0 && num4 < yLen && points[num3 + xMin, num4 + yMin] == 0 && validArea[num3, num4] == 0)
					{
						validArea[num3, num4] = num;
						if (num3 == 0 || num3 == xLen - 1 || num4 == 0 || num4 == yLen - 1)
						{
							num2 = num;
							dictionary[num2] = true;
							dictionary2[num] = false;
						}
						queue.Enqueue(num3 - 1);
						queue2.Enqueue(num4);
						queue.Enqueue(num3 + 1);
						queue2.Enqueue(num4);
						queue.Enqueue(num3);
						queue2.Enqueue(num4 + 1);
						queue.Enqueue(num3);
						queue2.Enqueue(num4 - 1);
					}
				}
			}
		}
		Color color = new Color(1f, 0f, 0f, 0f);
		resultBox.xMin = PANEL_WIDTH;
		resultBox.xMax = 0f;
		resultBox.yMin = PANEL_HEIGHT;
		resultBox.yMax = 0f;
		for (int m = 0; m < yLen; m++)
		{
			for (int n = 0; n < xLen; n++)
			{
				if (validArea[n, m] != 0 && dictionary2[validArea[n, m]])
				{
					resultBox.xMin = Mathf.Min(resultBox.xMin, (float)(n + xMin) * panelWidthScale);
					resultBox.xMax = Mathf.Max(resultBox.xMax, (float)(n + xMin) * panelWidthScale);
					resultBox.yMin = Mathf.Min(resultBox.yMin, (float)(m + yMin) * panelHeightScale);
					resultBox.yMax = Mathf.Max(resultBox.yMax, (float)(m + yMin) * panelHeightScale);
					points[n + xMin, m + yMin] = 3;
					tempTexture2D.SetPixel(n + xMin, m + yMin, color);
					result = true;
					int num5 = n + xMin - 1;
					int num6 = n + xMin + 1;
					int num7 = m + yMin + 1;
					int num8 = m + yMin - 1;
					if (num5 >= 0 && points[num5, m + yMin] == 1)
					{
						points[num5, m + yMin] = 2;
						tempTexture2D.SetPixel(num5, m + yMin, color);
					}
					if (num6 < TEX_WIDTH && points[num6, m + yMin] == 1)
					{
						points[num6, m + yMin] = 2;
						tempTexture2D.SetPixel(num6, m + yMin, color);
					}
					if (num7 < TEX_HEIGHT && points[n + xMin, num7] == 1)
					{
						points[n + xMin, num7] = 2;
						tempTexture2D.SetPixel(n + xMin, num7, color);
					}
					if (num8 >= 0 && points[n + xMin, num8] == 1)
					{
						points[n + xMin, num8] = 2;
						tempTexture2D.SetPixel(n + xMin, num8, color);
					}
				}
			}
		}
		tempTexture2D.Apply();
		return result;
	}

	public int CalculateScore()
	{
		float num = 0f;
		Transform transform = checkPointPanelTrans.Find("outline");
		int childCount = transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			bool flag = false;
			Transform child = transform.GetChild(i);
			Vector3 vector = Camera.main.WorldToScreenPoint(child.position);
			Vector2 vector2 = new Vector2
			{
				x = (vector.x - rcDraw.xMin) / rcDraw.width * (float)TEX_WIDTH,
				y = (vector.y - rcDraw.yMin) / rcDraw.height * (float)TEX_HEIGHT
			};
			int num2 = Mathf.Max(0, Mathf.FloorToInt(vector2.x - (float)checkPointRadius));
			int num3 = Mathf.Min(TEX_WIDTH - 1, Mathf.FloorToInt(vector2.x + (float)checkPointRadius));
			int num4 = Mathf.Max(0, Mathf.FloorToInt(vector2.y - (float)checkPointRadius));
			int num5 = Mathf.Min(TEX_HEIGHT - 1, Mathf.FloorToInt(vector2.y + (float)checkPointRadius));
			for (int j = num4; j <= num5; j++)
			{
				for (int k = num2; k <= num3; k++)
				{
					if (points[k, j] == 2)
					{
						num++;
						flag = true;
						break;
					}
				}
				if (flag)
				{
					break;
				}
			}
		}
		Transform transform2 = checkPointPanelTrans.Find("inside");
		float num6 = 0f;
		int childCount2 = transform2.childCount;
		for (int l = 0; l < childCount2; l++)
		{
			Transform child2 = transform2.GetChild(l);
			Vector3 vector3 = Camera.main.WorldToScreenPoint(child2.position);
			Vector2 vector4 = new Vector2
			{
				x = (vector3.x - rcDraw.xMin) / rcDraw.width * (float)TEX_WIDTH,
				y = (vector3.y - rcDraw.yMin) / rcDraw.height * (float)TEX_HEIGHT
			};
			if (points[(int)vector4.x, (int)vector4.y] == 3)
			{
				num6++;
			}
		}
		num = num / (float)childCount * 100f;
		num6 = num6 / (float)childCount2 * 100f;
		int num7 = Mathf.CeilToInt(Mathf.Min(num, num6));
		return (num7 >= 0) ? num7 : 0;
	}

	public void SetOnComplete(Action handler)
	{
		onComplete = handler;
	}

	public void SetOnStartDraw(Action handler)
	{
		onStartDraw = handler;
	}

	public void SetCheckPanelTrans(Transform trans)
	{
		checkPointPanelTrans = trans;
	}

	private void OnDestroy()
	{
		onComplete = null;
		onStartDraw = null;
		if (tempTexture2D != null)
		{
			UnityEngine.Object.Destroy(tempTexture2D);
			tempTexture2D = null;
		}
	}

	public void SetResultUIImage(PaperCutUIImage image)
	{
		resultUIImage = image;
	}

	public void SetCanvasScale(Vector2 scale)
	{
		canvasScale = scale;
	}

	public void SetCanvas(GameObject _canvasGo)
	{
		canvas = _canvasGo.GetComponent<Canvas>();
	}

	public void InitialScene()
	{
		canvas.additionalShaderChannels |= AdditionalCanvasShaderChannels.TexCoord2;
		canvas.additionalShaderChannels |= AdditionalCanvasShaderChannels.TexCoord3;
		CameraExtension component = Camera.main.gameObject.GetComponent<CameraExtension>();
		tempBloomMode = (int)component.bloomQuality;
		component.bloomQuality = CameraExtension.BloomQuality.None;
	}

	public void ResetScene()
	{
		canvas.additionalShaderChannels ^= AdditionalCanvasShaderChannels.TexCoord2;
		canvas.additionalShaderChannels ^= AdditionalCanvasShaderChannels.TexCoord3;
		Camera.main.gameObject.GetComponent<CameraExtension>().bloomQuality = (CameraExtension.BloomQuality)tempBloomMode;
	}

	public void LoadCheckPointPanel(int activityID)
	{
		Transform transform;
		if (!checkPointPanelList.ContainsKey(activityID))
		{
			transform = UnityEngine.Object.Instantiate(Asset.Load<GameObject>($"UI/EmptyDream/PaperCut/{activityID}"), checkPointPanelParent).transform;
			checkPointPanelList[activityID] = transform;
			transform.transform.localPosition = Vector3.zero;
			transform.GetComponent<SpriteRenderer>().enabled = false;
		}
		else
		{
			transform = checkPointPanelList[activityID];
		}
		checkPointPanelTrans = transform.transform;
	}
}
