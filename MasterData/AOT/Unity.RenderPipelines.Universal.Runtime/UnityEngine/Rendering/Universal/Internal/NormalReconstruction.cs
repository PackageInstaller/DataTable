namespace UnityEngine.Rendering.Universal.Internal;

public static class NormalReconstruction
{
	private static readonly int s_NormalReconstructionMatrixID = Shader.PropertyToID("_NormalReconstructionMatrix");

	private static Matrix4x4[] s_NormalReconstructionMatrix = new Matrix4x4[2];

	public static void SetupProperties(CommandBuffer cmd, in CameraData cameraData)
	{
		int num = 1;
		for (int i = 0; i < num; i++)
		{
			Matrix4x4 viewMatrix = cameraData.GetViewMatrix(i);
			Matrix4x4 projectionMatrix = cameraData.GetProjectionMatrix(i);
			s_NormalReconstructionMatrix[i] = projectionMatrix * viewMatrix;
			Matrix4x4 matrix4x = viewMatrix;
			matrix4x.SetColumn(3, new Vector4(0f, 0f, 0f, 1f));
			Matrix4x4 inverse = (projectionMatrix * matrix4x).inverse;
			s_NormalReconstructionMatrix[i] = inverse;
		}
		cmd.SetGlobalMatrixArray(s_NormalReconstructionMatrixID, s_NormalReconstructionMatrix);
	}
}
