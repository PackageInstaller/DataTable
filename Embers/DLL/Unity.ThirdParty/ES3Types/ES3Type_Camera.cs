using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"fieldOfView", "nearClipPlane", "farClipPlane", "renderingPath", "allowHDR", "orthographicSize", "orthographic", "opaqueSortMode", "transparencySortMode", "depth",
	"aspect", "cullingMask", "eventMask", "backgroundColor", "rect", "pixelRect", "worldToCameraMatrix", "projectionMatrix", "nonJitteredProjectionMatrix", "useJitteredProjectionMatrixForTransparentRendering",
	"clearFlags", "stereoSeparation", "stereoConvergence", "cameraType", "stereoTargetEye", "targetDisplay", "useOcclusionCulling", "cullingMatrix", "layerCullSpherical", "depthTextureMode",
	"clearStencilAfterLightingPass", "enabled", "hideFlags"
})]
public class ES3Type_Camera : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_Camera()
		: base(typeof(Camera))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		Camera camera = (Camera)obj;
		writer.WriteProperty("fieldOfView", camera.fieldOfView);
		writer.WriteProperty("nearClipPlane", camera.nearClipPlane);
		writer.WriteProperty("farClipPlane", camera.farClipPlane);
		writer.WriteProperty("renderingPath", camera.renderingPath);
		writer.WriteProperty("allowHDR", camera.allowHDR);
		writer.WriteProperty("orthographicSize", camera.orthographicSize);
		writer.WriteProperty("orthographic", camera.orthographic);
		writer.WriteProperty("opaqueSortMode", camera.opaqueSortMode);
		writer.WriteProperty("transparencySortMode", camera.transparencySortMode);
		writer.WriteProperty("depth", camera.depth);
		writer.WriteProperty("aspect", camera.aspect);
		writer.WriteProperty("cullingMask", camera.cullingMask);
		writer.WriteProperty("eventMask", camera.eventMask);
		writer.WriteProperty("backgroundColor", camera.backgroundColor);
		writer.WriteProperty("rect", camera.rect);
		writer.WriteProperty("pixelRect", camera.pixelRect);
		writer.WriteProperty("projectionMatrix", camera.projectionMatrix);
		writer.WriteProperty("nonJitteredProjectionMatrix", camera.nonJitteredProjectionMatrix);
		writer.WriteProperty("useJitteredProjectionMatrixForTransparentRendering", camera.useJitteredProjectionMatrixForTransparentRendering);
		writer.WriteProperty("clearFlags", camera.clearFlags);
		writer.WriteProperty("stereoSeparation", camera.stereoSeparation);
		writer.WriteProperty("stereoConvergence", camera.stereoConvergence);
		writer.WriteProperty("cameraType", camera.cameraType);
		writer.WriteProperty("stereoTargetEye", camera.stereoTargetEye);
		writer.WriteProperty("targetDisplay", camera.targetDisplay);
		writer.WriteProperty("useOcclusionCulling", camera.useOcclusionCulling);
		writer.WriteProperty("layerCullSpherical", camera.layerCullSpherical);
		writer.WriteProperty("depthTextureMode", camera.depthTextureMode);
		writer.WriteProperty("clearStencilAfterLightingPass", camera.clearStencilAfterLightingPass);
		writer.WriteProperty("enabled", camera.enabled);
		writer.WriteProperty("hideFlags", camera.hideFlags);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		Camera camera = (Camera)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "fieldOfView":
				camera.fieldOfView = reader.Read<float>();
				break;
			case "nearClipPlane":
				camera.nearClipPlane = reader.Read<float>();
				break;
			case "farClipPlane":
				camera.farClipPlane = reader.Read<float>();
				break;
			case "renderingPath":
				camera.renderingPath = reader.Read<RenderingPath>();
				break;
			case "allowHDR":
				camera.allowHDR = reader.Read<bool>();
				break;
			case "orthographicSize":
				camera.orthographicSize = reader.Read<float>();
				break;
			case "orthographic":
				camera.orthographic = reader.Read<bool>();
				break;
			case "opaqueSortMode":
				camera.opaqueSortMode = reader.Read<OpaqueSortMode>();
				break;
			case "transparencySortMode":
				camera.transparencySortMode = reader.Read<TransparencySortMode>();
				break;
			case "depth":
				camera.depth = reader.Read<float>();
				break;
			case "aspect":
				camera.aspect = reader.Read<float>();
				break;
			case "cullingMask":
				camera.cullingMask = reader.Read<int>();
				break;
			case "eventMask":
				camera.eventMask = reader.Read<int>();
				break;
			case "backgroundColor":
				camera.backgroundColor = reader.Read<Color>();
				break;
			case "rect":
				camera.rect = reader.Read<Rect>();
				break;
			case "pixelRect":
				camera.pixelRect = reader.Read<Rect>();
				break;
			case "projectionMatrix":
				camera.projectionMatrix = reader.Read<Matrix4x4>();
				break;
			case "nonJitteredProjectionMatrix":
				camera.nonJitteredProjectionMatrix = reader.Read<Matrix4x4>();
				break;
			case "useJitteredProjectionMatrixForTransparentRendering":
				camera.useJitteredProjectionMatrixForTransparentRendering = reader.Read<bool>();
				break;
			case "clearFlags":
				camera.clearFlags = reader.Read<CameraClearFlags>();
				break;
			case "stereoSeparation":
				camera.stereoSeparation = reader.Read<float>();
				break;
			case "stereoConvergence":
				camera.stereoConvergence = reader.Read<float>();
				break;
			case "cameraType":
				camera.cameraType = reader.Read<CameraType>();
				break;
			case "stereoTargetEye":
				camera.stereoTargetEye = reader.Read<StereoTargetEyeMask>();
				break;
			case "targetDisplay":
				camera.targetDisplay = reader.Read<int>();
				break;
			case "useOcclusionCulling":
				camera.useOcclusionCulling = reader.Read<bool>();
				break;
			case "layerCullSpherical":
				camera.layerCullSpherical = reader.Read<bool>();
				break;
			case "depthTextureMode":
				camera.depthTextureMode = reader.Read<DepthTextureMode>();
				break;
			case "clearStencilAfterLightingPass":
				camera.clearStencilAfterLightingPass = reader.Read<bool>();
				break;
			case "enabled":
				camera.enabled = reader.Read<bool>();
				break;
			case "hideFlags":
				camera.hideFlags = reader.Read<HideFlags>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
