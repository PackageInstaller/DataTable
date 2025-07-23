gs = {}

--NAME SPACE BEGIN
gs.DT = CS.DG.Tweening
--NAME SPACE END
--Lylibs--Class
gs.AudioManager = CS.Lylibs.AudioManager.Instance()
gs.PopPanelManager = CS.Lylibs.PopPanelManager
gs.CameraMgr = CS.Lylibs.CameraMgr.Ins
gs.GlobalIllumMgr = CS.Lylibs.GlobalIllumMgr.Ins
gs.UIComponentProxy = CS.Lylibs.UIComponentProxy
gs.MD5 = CS.Lylibs.MD5Util
gs.WavUtility = CS.Lylibs.WavUtility
gs.webInterfaceUtil = CS.Lylibs.WebInterfaceUtil
gs.WebUtil = CS.Lylibs.WebUtil
gs.Debuger = CS.Lylibs.Debuger
gs.AssetsUtils = CS.Lylibs.AssetsUtils.Instance
gs.ResMgr = CS.Lylibs.ResMgr.Ins
gs.TransQuick = CS.Lylibs.TransQuick.Ins
gs.socket = CS.Lylibs.SocketProxy
gs.SocketLuaOpHandle = CS.Lylibs.SocketLuaOpHandle
gs.StorageUtil = CS.Lylibs.StorageUtil
gs.ColorUtil = CS.Lylibs.ColorUtil
gs.SdkManager = CS.Lylibs.SDKManager.Ins
gs.BuglyAgent = CS.BuglyAgent
gs.COSXMLMgr = CS.Lylibs.COSXMLMgr.Instance
gs.RenenderUtil = CS.Lylibs.RenenderUtil
gs.SnMgr = CS.Lylibs.SnMgr.Instance
gs.MatUtil = CS.Lylibs.MatUtil
gs.GoUtil = CS.Lylibs.GoUtil
gs.TimerStopwatchUtil = CS.Lylibs.TimerStopwatchUtil
gs.DFAUtil = CS.Lylibs.DFAUtil
gs.UGUIUtil = CS.Lylibs.UGUIUtil
gs.MathUtil = CS.Lylibs.MathUtil
gs.StringUtil = CS.Lylibs.StringUtil
gs.GarbageCollectorUtil = CS.Lylibs.GarbageCollectorUtil
gs.ParticleMgr = CS.Lylibs.ParticleMgr.Instance
gs.GOPoolMgr = CS.Lylibs.GOPoolMgr.Instance
gs.UnityEngineUtil = CS.Lylibs.UnityEngineUtil
gs.CameraShakeUtil = CS.Lylibs.CameraShakeUtil
gs.LanguageMgr = CS.Lylibs.LanguageMgr.Instance
gs.LuaLoopTick = CS.Lylibs.LuaLoopTick.Instance
gs.LoopBehaviour = CS.Lylibs.LoopBehaviour
gs.SocketMessageCenter = CS.Lylibs.SocketMessageCenter.getInstance()
gs.AssetSetting = CS.Lylibs.AssetSetting
gs.LifeCyclelManager = CS.Lylibs.LifeCyclelManager
gs.LifeCycleCompoment = CS.LifeCycleCompoment
gs.SceneToUIComponent = CS.Lylibs.SceneToUIComponent
gs.TextToolsComponent = CS.Lylibs.TextToolsComponent
gs.ColliderCall = CS.Lylibs.ColliderCall

-- gs.Message = CS.Lylibs.MessageUtil
gs._Message = CS.Lylibs.MessageUtil
gs.Message = {}
gs.Message.Show = function(content, shieldAudio)
    if not shieldAudio then
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab"))
    end
    gs._Message.Show(content)
end
gs.Message.Show2 = function(content, shieldAudio)
    if not shieldAudio then
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab"))
    end
    gs._Message.Show2(content)
end

gs.Message.Show3 = function(content, shieldAudio)
    if not shieldAudio then
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab"))
    end
    gs._Message.Show3(content)
end
gs.Message.ShowHeroMsg = function(content, shieldAudio)
    if not shieldAudio then
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab"))
    end
    gs._Message.Show(content, true)
end
gs.LightMgr = CS.Lylibs.LightMgr.Instance
gs.DynamicAnimation = CS.Lylibs.DynamicAnimation.Instance
gs.PathUtil = CS.Lylibs.PathUtil
gs.FileUtil = CS.Lylibs.FileUtil
gs.DeviceInfoMgr = CS.Lylibs.DeviceInfoMgr
gs.FilterWordMgr = CS.Lylibs.FilterWordMgr.Instance
gs.FileProxy = CS.Lylibs.FileProxy
gs.DrawCircle = CS.Lylibs.DrawCircle
gs.ScrollEffect = CS.Lylibs.ScrollEffect
gs.ScrollEffectItem = CS.Lylibs.ScrollEffectItem
gs.ArcScrollListView = CS.Lylibs.ArcScrollListView
gs.ArcScrollItem = CS.Lylibs.ArcScrollItem
gs.FogOfWarManager = CS.FogOfWarManager
gs.RaycastEmptyEvent = CS.RaycastEmptyEvent

gs.ABPackLoader = CS.Lylibs.ABPackLoader
gs.UIBlurManager = CS.Lylibs.UIBlurManager
gs.ApplicationUtil = CS.Lylibs.ApplicationUtil
gs.QualitySettingsUtil = CS.Lylibs.QualitySettingsUtil
gs.TextExtension = CS.Lylibs.TextExtension

gs.AnimatorUtil = CS.Lylibs.AnimatorUtil
gs.StoryPlayMaker = CS.Lylibs.StoryPlayMaker.Instance
gs.GoMouseEvent = CS.Lylibs.GoMouseEvent
gs.RaycastMouseEvent = CS.Lylibs.RaycastMouseEvent

--Lylibs--Mono
gs.Game = CS.Game.Instance
gs.ItemRender = CS.Lylibs.ItemRender
gs.RadarProperty = CS.Lylibs.RadarProperty
gs.ChatLoopVerticalScrollRect = CS.Lylibs.ChatLoopVerticalScrollRect
gs.LyRawImage = CS.Lylibs.LyRawImage
gs.LyScroller = CS.Lylibs.LyScroller
gs.AutoRefImage = CS.Lylibs.AutoRefImage
gs.AutoRefRawImage = CS.Lylibs.AutoRefRawImage
gs.ImageFrame = CS.Lylibs.ImageFrame
gs.AnimatCtrl = CS.Lylibs.AnimatCtrl
gs.AnimatCall = CS.Lylibs.AnimatCall
gs.ParticleHandle = CS.Lylibs.ParticleHandle
gs.RichText = CS.Lylibs.RichText
gs.RichTextManager = CS.Lylibs.RichTextManager.Instance
gs.BtnEx = CS.Lylibs.BtnEx
gs.ProgressBar = CS.Lylibs.ProgressBar
gs.ProgressBarHp = CS.Lylibs.ProgressBarHp
gs.ProgressBarRole = CS.Lylibs.ProgressBarRole
gs.ProgressBarLayers = CS.Lylibs.ProgressBarLayers
gs.GoRefHandle = CS.Lylibs.GoRefHandle

gs.ChainLightning = CS.Lylibs.ChainLightning
gs.LyNumberStepper = CS.Lylibs.LyNumberStepper
gs.LyNumberStepperLongPress = CS.Lylibs.LyNumberStepperLongPress
gs.LongPressOrClickEventTrigger = CS.Lylibs.LongPressOrClickEventTrigger
gs.LongTimeComponent = CS.Lylibs.LongTimeComponent
gs.LanText = CS.Lylibs.LanText
gs.MonoStrDict = CS.Lylibs.MonoStrDict

gs.UIDrawLineComponent = CS.Lylibs.UIDrawLineComponent
gs.StoryBGComponent = CS.Lylibs.StoryBGComponent
-- gs.FAnimationManager = CS.Lylibs.FAnimationManager
gs.SimpleAnimation = CS.SimpleAnimation
gs.FlipCameraComponent = CS.Lylibs.FlipCameraComponent
gs.StoryEditorListenerManager = CS.Lylibs.StoryEditorListenerManager
gs.EditorApplication = CS.UnityEditor.EditorApplication
gs.Space = CS.UnityEngine.Space
-- gs.mStoryModelUtilComponent = CS.Lylibs.mStoryModelUtilComponent
-- gs.AdaptSceneBGComponent = CS.Lylibs.AdaptSceneBGComponent
-- gs.SceneBGComponent = CS.Lylibs.SceneBGComponent

gs.MoveComponent = CS.Lylibs.MoveComponent
gs.FadeModelComponent = CS.Lylibs.FadeModelComponent

gs.EffectPointSet = CS.EffectPointSet
gs.CharAppendEffect = CS.CharAppendEffect
gs.EffectFixSet = CS.EffectFixSet
gs.EffectRandomSet = CS.LyEffect.EffectRandomSet
gs.EffectRandomController = CS.LyEffect.EffectRandomController
gs.EffectRandomMananger = CS.LyEffect.EffectRandomMananger
gs.EffectForModelMaterial = CS.EffectForModelMaterial
gs.EffectForPost = CS.EffectForPost
gs.AutoRimController = CS.AutoRimController
gs.ModelHeihgtGradient = CS.ModelHeihgtGradient
gs.DynamicBoneController = CS.DynamicBoneController
gs.SmileController = CS.SmileController
gs.ModelMaterials = CS.ModelMaterials
gs.ReflectionTexture = CS.ReflectionTexture

gs.DragUI = CS.Lylibs.DragUI
gs.ShakeObject = CS.Lylibs.ShakeObject
gs.EventClick = CS.Lylibs.EventClick
gs.PostProcessing = CS.PostProcessing
gs.CommandBufferBlur = CS.CommandBufferBlur
gs.ScreenResolutionUtil = CS.ScreenResolutionUtil
gs.GraphicBlit = CS.GraphicBlit
gs.RecruitDrag = CS.Lylibs.RecruitDrag
gs.UIDoTween = CS.Lylibs.UIDoTween
gs.DoTweenUtil = CS.Lylibs.DoTweenUtil

-- OTHER Mono
gs.PlayMakerFSM = CS.PlayMakerFSM

--UCLASS BEGIN------------------------------
gs.TouchPhase = CS.UnityEngine.TouchPhase
gs.Object = CS.UnityEngine.Object
gs.Transform = CS.UnityEngine.Transform
gs.GameObject = CS.UnityEngine.GameObject
gs.RectTransform = CS.UnityEngine.RectTransform
gs.Mathf = CS.UnityEngine.Mathf
gs.Random = CS.UnityEngine.Random
gs.TextAnchor = CS.UnityEngine.TextAnchor
gs.Color = CS.UnityEngine.Color
gs.Color32 = CS.UnityEngine.Color32
gs.Vector2 = CS.UnityEngine.Vector2
gs.Vector3 = CS.UnityEngine.Vector3
gs.Vector4 = CS.UnityEngine.Vector4
gs.Quaternion = CS.UnityEngine.Quaternion
gs.FontStyle = CS.UnityEngine.FontStyle
gs.Canvas = CS.UnityEngine.Canvas
gs.RectTransformUtility = CS.UnityEngine.RectTransformUtility
gs.Input = CS.UnityEngine.Input
gs.KeyCode = CS.UnityEngine.KeyCode
gs.TextAsset = CS.UnityEngine.TextAsset
gs.RuntimeAnimatorController = CS.UnityEngine.RuntimeAnimatorController
gs.AnimatorOverrideController = CS.UnityEngine.AnimatorOverrideController
gs.MeshFilter = CS.UnityEngine.MeshFilter
gs.MeshRenderer = CS.UnityEngine.MeshRenderer
gs.SkinnedMeshRenderer = CS.UnityEngine.SkinnedMeshRenderer
gs.ParticleSystem = CS.UnityEngine.ParticleSystem
gs.Renderer = CS.UnityEngine.Renderer
gs.Screen = CS.UnityEngine.Screen
gs.Application = CS.UnityEngine.Application
gs.RuntimePlatform = CS.UnityEngine.RuntimePlatform
gs.LayerMask = CS.UnityEngine.LayerMask
gs.Animator = CS.UnityEngine.Animator
gs.Animation = CS.UnityEngine.Animation
gs.CanvasGroup = CS.UnityEngine.CanvasGroup
gs.Shader = CS.UnityEngine.Shader
gs.Camera = CS.UnityEngine.Camera
gs.Time = CS.UnityEngine.Time
gs.LineRenderer = CS.UnityEngine.LineRenderer
gs.TextAnchor = CS.UnityEngine.TextAnchor
gs.Directory = CS.System.IO.Directory
gs.Path = CS.System.IO.Path
gs.File = CS.System.IO.File
gs.Graphics = CS.UnityEngine.Graphics
gs.SkinWeights = CS.UnityEngine.SkinWeights
gs.QualityLevel = CS.UnityEngine.QualityLevel
gs.AudioListener = CS.UnityEngine.AudioListener
gs.Material = CS.UnityEngine.Material
gs.Profiler = CS.UnityEngine.Profiling.Profiler
gs.PhysicsRaycaster = CS.UnityEngine.EventSystems.PhysicsRaycaster
gs.Plane = CS.UnityEngine.Plane
gs.FullScreenMode = CS.UnityEngine.FullScreenMode
gs.NavMesh = CS.UnityEngine.AI.NavMesh
gs.NavMeshAgent = CS.UnityEngine.AI.NavMeshAgent
gs.NavMeshObstacle = CS.UnityEngine.AI.NavMeshObstacle
gs.NavMeshObstacleShape = CS.UnityEngine.AI.NavMeshObstacleShape
gs.ObstacleAvoidanceType = CS.UnityEngine.AI.ObstacleAvoidanceType
gs.ShadowResolution = CS.UnityEngine.ShadowResolution
gs.VideoPlayer = CS.UnityEngine.Video.VideoPlayer
gs.RenderSettings = CS.UnityEngine.RenderSettings
gs.AnimationEvent = CS.UnityEngine.AnimationEvent

gs.TMP_Text = CS.TMPro.TMP_Text
gs.TMP_LinkInfo = CS.TMPro.TMP_LinkInfo
gs.TMP_TextUtilities = CS.TMPro.TMP_TextUtilities
gs.TextMeshProLink = CS.TextMeshProLink

-- 手机视频播放器
gs.Handheld = CS.UnityEngine.Handheld
gs.FullScreenMovieControlMode = CS.UnityEngine.FullScreenMovieControlMode

-- AVProVideo插件
gs.MediaPlayer = CS.RenderHeads.Media.AVProVideo.MediaPlayer
gs.MediaPlayerEventType = CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType
gs.MediaPlayerErrorCode = CS.RenderHeads.Media.AVProVideo.ErrorCode
gs.MediaPlayerVideoApi = CS.RenderHeads.Media.AVProVideo.Android.VideoApi

gs.Slider = CS.UnityEngine.UI.Slider
gs.Button = CS.UnityEngine.UI.Button
gs.Image = CS.UnityEngine.UI.Image
gs.Text = CS.UnityEngine.UI.Text
gs.InputField = CS.UnityEngine.UI.InputField
gs.ScrollRect = CS.UnityEngine.UI.ScrollRect
gs.BoxCollider = CS.UnityEngine.BoxCollider
gs.BoxCollider2D = CS.UnityEngine.BoxCollider2D
gs.Collider = CS.UnityEngine.Collider

gs.SphereCollider = CS.UnityEngine.SphereCollider
gs.MeshCollider = CS.UnityEngine.MeshCollider
gs.CharacterController = CS.UnityEngine.CharacterController
gs.HorizontalLayoutGroup = CS.UnityEngine.UI.HorizontalLayoutGroup
gs.VerticalLayoutGroup = CS.UnityEngine.UI.VerticalLayoutGroup
gs.LayoutElement = CS.UnityEngine.UI.LayoutElement
gs.FontStyle = CS.UnityEngine.FontStyle
gs.RenderTexture = CS.UnityEngine.RenderTexture
gs.RawImage = CS.UnityEngine.UI.RawImage
gs.ContentSizeFitter = CS.UnityEngine.UI.ContentSizeFitter
gs.Toggle = CS.UnityEngine.UI.Toggle
gs.ToggleGroup = CS.UnityEngine.UI.ToggleGroup
gs.Dropdown = CS.UnityEngine.UI.Dropdown
gs.Outline = CS.UnityEngine.UI.Outline
gs.Shadow = CS.UnityEngine.UI.Shadow
gs.AspectRatioFitter = CS.UnityEngine.UI.AspectRatioFitter

gs.LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
gs.LayoutUtility = CS.UnityEngine.UI.LayoutUtility
gs.GridLayoutGroup = CS.UnityEngine.UI.GridLayoutGroup
gs.GraphicRaycaster = CS.UnityEngine.UI.GraphicRaycaster

gs.SceneManager = CS.UnityEngine.SceneManagement.SceneManager
gs.LoadSceneMode = CS.UnityEngine.SceneManagement.LoadSceneMode
gs.AudioSource = CS.UnityEngine.AudioSource
gs.SpriteRenderer = CS.UnityEngine.SpriteRenderer

gs.CapsuleCollider = CS.UnityEngine.CapsuleCollider
gs.CapsuleCollider2D = CS.UnityEngine.CapsuleCollider2D

gs.Rigidbody = CS.UnityEngine.Rigidbody
gs.RigidbodyConstraints = CS.UnityEngine.RigidbodyConstraints

gs.Rigidbody2D = CS.UnityEngine.Rigidbody2D
gs.RigidbodyConstraints2D = CS.UnityEngine.RigidbodyConstraints2D
gs.RigidbodyType2D = CS.UnityEngine.RigidbodyType2D

gs.Cursor = CS.UnityEngine.Cursor

--UCLASS END------------------------------
---VEC2_CONST BEGIN------------------------------
gs.VEC2_ZERO = CS.UnityEngine.Vector2.zero
gs.VEC2_ONE = CS.UnityEngine.Vector2.one
gs.VEC2_DOWN = CS.UnityEngine.Vector2.down
gs.VEC2_UP = CS.UnityEngine.Vector2.up
gs.VEC2_LEFT = CS.UnityEngine.Vector2.left
gs.VEC2_RIGHT = CS.UnityEngine.Vector2.right
---VEC2_CONST END---------------
---VEC3_CONST BEGIN------------------------------
gs.VEC3_ZERO = CS.UnityEngine.Vector3.zero
gs.VEC3_ONE = CS.UnityEngine.Vector3.one
gs.VEC3_UP = CS.UnityEngine.Vector3.up
gs.VEC3_DOWN = CS.UnityEngine.Vector3.down
gs.VEC3_LEFT = CS.UnityEngine.Vector3.left
gs.VEC3_RIGHT = CS.UnityEngine.Vector3.right
gs.VEC3_BACK = CS.UnityEngine.Vector3.back
gs.VEC3_FORWARD = CS.UnityEngine.Vector3.forward
---VEC3_CONST END---------------
---VEC4_CONST BEGIN------------------------------
gs.VEC4_ZERO = CS.UnityEngine.Vector4.zero
gs.VEC4_ONE = CS.UnityEngine.Vector4.one
---VEC4_CONST END-----------------------
---RECT_CONST BEGIN------------------------------
gs.RECT_ZERO = CS.UnityEngine.Rect.zero
gs.Rect = CS.UnityEngine.Rect
---RECT_CONST END-----------------------
---Matrix4x4 BEGIN----------------------------
gs.MATRIX4X4_ZERO = CS.UnityEngine.Matrix4x4.zero
gs.MATRIX4X4_IDENTITY = CS.UnityEngine.Matrix4x4.identity
---Matrix4x4 END------------------------------
---------------------MATHF_CONST BEGIN----------------------
gs.MATHF_PI = CS.UnityEngine.Mathf.PI
gs.MATHF_DEG2RAd = CS.UnityEngine.Mathf.Deg2Rad
gs.MATHF_RAD2DEG = CS.UnityEngine.Mathf.Rad2Deg
---MATHF_CONST END---------------
---------------------Quaternion BEGIN--------------------
gs.QUATERNION_IDENTITY = CS.UnityEngine.Quaternion.identity
---------------------Quaternion END----------------------
----------------------Color BEGIN-----------------
gs.COlOR_CYAN = CS.UnityEngine.Color.cyan
gs.COlOR_GREEN = CS.UnityEngine.Color.green
gs.COlOR_RED = CS.UnityEngine.Color.red
gs.COlOR_BLACK = CS.UnityEngine.Color.black
gs.COlOR_YELLOW = CS.UnityEngine.Color.yellow
gs.COlOR_BLUE = CS.UnityEngine.Color.blue
gs.COlOR_MAGENTA = CS.UnityEngine.Color.magenta
gs.COlOR_GRAY = CS.UnityEngine.Color.gray
gs.COlOR_WHITE = CS.UnityEngine.Color.white
gs.COlOR_CLEAR = CS.UnityEngine.Color.clear
gs.COlOR_GREY = CS.UnityEngine.Color.grey

----------------------Color END-----------------
----------------------ENUM BEGIN------------------------
gs.QueueMode = CS.UnityEngine.QueueMode
gs.ThreadPriority = CS.UnityEngine.ThreadPriority
----------------------ENUM END------------------------
--NAME SPACE BEGIN
gs.DT = CS.DG.Tweening
gs.UE_Rendering = CS.UnityEngine.Rendering
gs.PMaker = CS.HutongGames.PlayMaker
gs.DisplayUGUI = CS.RenderHeads.Media.AVProVideo.DisplayUGUI
gs.MediaPlayer = CS.RenderHeads.Media.AVProVideo.MediaPlayer
--NAME SPACE END

gs.CusLog = CS.CusLog
gs.FogRevealerUnit = CS.FogRevealerUnit

--PathMoveComponent
gs.PathManager = CS.PathLibTools.PathManager
gs.PathMoveComponent = CS.PathLibTools.PathMoveComponent

--eff
gs.WaterFallDissolveCtr = CS.WaterFallDissolveCtr
gs.DissolveBaseCtr = CS.DissolveBaseCtr
