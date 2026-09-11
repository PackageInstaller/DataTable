using UnityEngine;

public class LeanSmooth
{
	public static float damp(float current, float target, ref float currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f)
	{
		if (deltaTime < 0f)
		{
			deltaTime = Time.deltaTime;
		}
		smoothTime = Mathf.Max(0.0001f, smoothTime);
		float num = 2f / smoothTime;
		float num2 = num * deltaTime;
		float num3 = 1f / (1f + num2 + 0.48f * num2 * num2 + 0.235f * num2 * num2 * num2);
		float num4 = current - target;
		float num5 = target;
		if (maxSpeed > 0f)
		{
			float num6 = maxSpeed * smoothTime;
			num4 = Mathf.Clamp(num4, 0f - num6, num6);
		}
		target = current - num4;
		float num7 = (currentVelocity + num * num4) * deltaTime;
		currentVelocity = (currentVelocity - num * num7) * num3;
		float num8 = target + (num4 + num7) * num3;
		if (num5 - current > 0f == num8 > num5)
		{
			num8 = num5;
			currentVelocity = (num8 - num5) / deltaTime;
		}
		return num8;
	}

	public static Vector3 damp(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f)
	{
		float x = damp(current.x, target.x, ref currentVelocity.x, smoothTime, maxSpeed, deltaTime);
		float y = damp(current.y, target.y, ref currentVelocity.y, smoothTime, maxSpeed, deltaTime);
		float z = damp(current.z, target.z, ref currentVelocity.z, smoothTime, maxSpeed, deltaTime);
		return new Vector3(x, y, z);
	}

	public static Color damp(Color current, Color target, ref Color currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f)
	{
		float r = damp(current.r, target.r, ref currentVelocity.r, smoothTime, maxSpeed, deltaTime);
		float g = damp(current.g, target.g, ref currentVelocity.g, smoothTime, maxSpeed, deltaTime);
		float b = damp(current.b, target.b, ref currentVelocity.b, smoothTime, maxSpeed, deltaTime);
		float a = damp(current.a, target.a, ref currentVelocity.a, smoothTime, maxSpeed, deltaTime);
		return new Color(r, g, b, a);
	}

	public static float spring(float current, float target, ref float currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f)
	{
		if (deltaTime < 0f)
		{
			deltaTime = Time.deltaTime;
		}
		float num = target - current;
		currentVelocity += deltaTime / smoothTime * accelRate * num;
		currentVelocity *= 1f - deltaTime * friction;
		if (maxSpeed > 0f && maxSpeed < Mathf.Abs(currentVelocity))
		{
			currentVelocity = maxSpeed * Mathf.Sign(currentVelocity);
		}
		return current + currentVelocity;
	}

	public static Vector3 spring(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f)
	{
		float x = spring(current.x, target.x, ref currentVelocity.x, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		float y = spring(current.y, target.y, ref currentVelocity.y, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		float z = spring(current.z, target.z, ref currentVelocity.z, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		return new Vector3(x, y, z);
	}

	public static Color spring(Color current, Color target, ref Color currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f)
	{
		float r = spring(current.r, target.r, ref currentVelocity.r, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		float g = spring(current.g, target.g, ref currentVelocity.g, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		float b = spring(current.b, target.b, ref currentVelocity.b, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		float a = spring(current.a, target.a, ref currentVelocity.a, smoothTime, maxSpeed, deltaTime, friction, accelRate);
		return new Color(r, g, b, a);
	}

	public static float linear(float current, float target, float moveSpeed, float deltaTime = -1f)
	{
		if (deltaTime < 0f)
		{
			deltaTime = Time.deltaTime;
		}
		bool flag = target > current;
		float num = deltaTime * moveSpeed * (flag ? 1f : (-1f));
		float num2 = current + num;
		float num3 = num2 - target;
		if ((flag && num3 > 0f) || (!flag && num3 < 0f))
		{
			return target;
		}
		return num2;
	}

	public static Vector3 linear(Vector3 current, Vector3 target, float moveSpeed, float deltaTime = -1f)
	{
		float x = linear(current.x, target.x, moveSpeed, deltaTime);
		float y = linear(current.y, target.y, moveSpeed, deltaTime);
		float z = linear(current.z, target.z, moveSpeed, deltaTime);
		return new Vector3(x, y, z);
	}

	public static Color linear(Color current, Color target, float moveSpeed)
	{
		float r = linear(current.r, target.r, moveSpeed);
		float g = linear(current.g, target.g, moveSpeed);
		float b = linear(current.b, target.b, moveSpeed);
		float a = linear(current.a, target.a, moveSpeed);
		return new Color(r, g, b, a);
	}

	public static float bounceOut(float current, float target, ref float currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f, float hitDamping = 0.9f)
	{
		if (deltaTime < 0f)
		{
			deltaTime = Time.deltaTime;
		}
		float num = target - current;
		currentVelocity += deltaTime / smoothTime * accelRate * num;
		currentVelocity *= 1f - deltaTime * friction;
		if (maxSpeed > 0f && maxSpeed < Mathf.Abs(currentVelocity))
		{
			currentVelocity = maxSpeed * Mathf.Sign(currentVelocity);
		}
		float num2 = current + currentVelocity;
		bool flag = target > current;
		float num3 = num2 - target;
		if ((flag && num3 > 0f) || (!flag && num3 < 0f))
		{
			currentVelocity = (0f - currentVelocity) * hitDamping;
			num2 = current + currentVelocity;
		}
		return num2;
	}

	public static Vector3 bounceOut(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f, float hitDamping = 0.9f)
	{
		float x = bounceOut(current.x, target.x, ref currentVelocity.x, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		float y = bounceOut(current.y, target.y, ref currentVelocity.y, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		float z = bounceOut(current.z, target.z, ref currentVelocity.z, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		return new Vector3(x, y, z);
	}

	public static Color bounceOut(Color current, Color target, ref Color currentVelocity, float smoothTime, float maxSpeed = -1f, float deltaTime = -1f, float friction = 2f, float accelRate = 0.5f, float hitDamping = 0.9f)
	{
		float r = bounceOut(current.r, target.r, ref currentVelocity.r, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		float g = bounceOut(current.g, target.g, ref currentVelocity.g, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		float b = bounceOut(current.b, target.b, ref currentVelocity.b, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		float a = bounceOut(current.a, target.a, ref currentVelocity.a, smoothTime, maxSpeed, deltaTime, friction, accelRate, hitDamping);
		return new Color(r, g, b, a);
	}
}
