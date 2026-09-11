namespace P08Common;

public static class Geometry
{
	public static class Point
	{
		public static double SquareDistanceToLine(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d a = P - A;
			Vector2d vector2d = B - A;
			double num = Vector2d.Det(a, vector2d);
			return num * num / Vector2d.Dot(vector2d, vector2d);
		}

		public static double DistanceToLine(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d a = P - A;
			Vector2d vector2d = B - A;
			return Math.Abs(Vector2d.Det(a, vector2d)) / Math.Sqrt(Vector2d.Dot(vector2d, vector2d));
		}

		public static double SquareDistanceToSegment(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = P - A;
			double num = Vector2d.Dot(vector2d, vector2d2);
			if (num <= 0.0)
			{
				return Vector2d.SquareDistance(P, A);
			}
			double num2 = Vector2d.Dot(vector2d, vector2d);
			if (num2 <= num)
			{
				return Vector2d.SquareDistance(P, B);
			}
			double num3 = Vector2d.Det(vector2d2, vector2d);
			return num3 * num3 / num2;
		}

		public static double DistanceToSegment(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = P - A;
			double num = Vector2d.Dot(vector2d, vector2d2);
			if (num <= 0.0)
			{
				return vector2d2.Magnitude;
			}
			double num2 = Vector2d.Dot(vector2d, vector2d);
			if (num2 <= num)
			{
				return (P - B).Magnitude;
			}
			return Math.Abs(Vector2d.Det(vector2d2, vector2d)) / Math.Sqrt(num2);
		}

		public static double SquareDistanceToLine2(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d a = P - A;
			Vector2d vector2d = B - A;
			return Vector2d.SquareDistance(P, A + vector2d * Vector2d.Dot(a, vector2d) / Vector2d.Dot(vector2d, vector2d));
		}

		public static double DistanceToLine2(Vector2d P, Vector2d A, Vector2d B)
		{
			return Math.Sqrt(SquareDistanceToLine(P, A, B));
		}

		public static double SquareDistanceToSegment2(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d vector2d = B - A;
			Vector2d b = P - A;
			double num = Vector2d.Dot(vector2d, b);
			if (num <= 0.0)
			{
				return Vector2d.SquareDistance(P, A);
			}
			double num2 = Vector2d.Dot(vector2d, vector2d);
			if (num2 <= num)
			{
				return Vector2d.SquareDistance(P, B);
			}
			return Vector2d.SquareDistance(P, A + num / num2 * vector2d);
		}

		public static double DistanceToSegment2(Vector2d P, Vector2d A, Vector2d B)
		{
			return Math.Sqrt(SquareDistanceToSegment(P, A, B));
		}

		public static double DistanceToCircle(Vector2d P, Vector2d C, double r)
		{
			return Math.Abs(Vector2d.Distance(P, C) - r);
		}

		public static Vector2d LineClosestPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d vector2d = B - A;
			return A + vector2d * Vector2d.Dot(P - A, vector2d) / Vector2d.Dot(vector2d, vector2d);
		}

		public static Vector2d SegmentClosestPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			Vector2d vector2d = B - A;
			Vector2d b = P - A;
			double num = Vector2d.Dot(vector2d, b);
			if (num <= 0.0)
			{
				return A;
			}
			double num2 = Vector2d.Dot(vector2d, vector2d);
			if (num2 <= num)
			{
				return B;
			}
			return A + vector2d * num / num2;
		}

		public static bool Incircle(Vector2d P, Vector2d C, double r)
		{
			return Vector2d.SquareDistance(P, C) <= r * r;
		}
	}

	public static class Line
	{
		public static double SquareDistanceToPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.SquareDistanceToLine(P, A, B);
		}

		public static double DistanceToPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.DistanceToLine(P, A, B);
		}

		public static Vector2d ClosestPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.LineClosestPoint(P, A, B);
		}

		public static bool LineIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, Vector2d D, out Vector2d P)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = D - C;
			double num = Vector2d.Det(vector2d, vector2d2);
			if (num == 0.0)
			{
				Vector2d b = C - A;
				if (Vector2d.Det(vector2d, b) != 0.0 || Vector2d.Det(vector2d2, b) != 0.0)
				{
					P = Vector2d.NaN;
					return false;
				}
				double num2 = Vector2d.Dot(vector2d, vector2d);
				double num3 = Vector2d.Dot(vector2d2, vector2d2);
				if (num2 == 0.0 && num3 == 0.0)
				{
					if (A != C)
					{
						P = Vector2d.NaN;
						return false;
					}
					P = A;
					return true;
				}
				if (num3 == 0.0)
				{
					P = C;
					return true;
				}
				P = A;
				return true;
			}
			Vector2d b2 = A - C;
			double num4 = Vector2d.Det(vector2d2, b2) / num;
			P = A + vector2d * num4;
			return true;
		}

		public static bool SegmentIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, Vector2d D, out Vector2d P)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = D - C;
			double num = Vector2d.Det(vector2d, vector2d2);
			if (num == 0.0)
			{
				Vector2d b = C - A;
				if (Vector2d.Det(vector2d, b) != 0.0 || Vector2d.Det(vector2d2, b) != 0.0)
				{
					P = Vector2d.NaN;
					return false;
				}
				double num2 = Vector2d.Dot(vector2d, vector2d);
				double num3 = Vector2d.Dot(vector2d2, vector2d2);
				if (num2 == 0.0 && num3 == 0.0)
				{
					if (A != C)
					{
						P = Vector2d.NaN;
						return false;
					}
					P = A;
					return true;
				}
				if (num3 == 0.0)
				{
					P = C;
					return true;
				}
				if (inSegment(A, C, D))
				{
					P = A;
					return true;
				}
				P = Vector2d.NaN;
				return false;
			}
			Vector2d b2 = A - C;
			double num4 = Vector2d.Det(vector2d, b2) / num;
			if (num4 >= 0.0 && num4 <= 1.0)
			{
				num4 = Vector2d.Det(vector2d2, b2) / num;
				P = A + vector2d * num4;
				return true;
			}
			P = Vector2d.NaN;
			return false;
		}

		public static bool CircleIntersectionPoints(Vector2d A, Vector2d B, Vector2d C, double r, out Vector2d P1, out Vector2d P2)
		{
			if (A == B)
			{
				if (Vector2d.SquareDistance(A, C) == r * r)
				{
					P1 = A;
					P2 = A;
					return true;
				}
				P1 = Vector2d.NaN;
				P2 = Vector2d.NaN;
				return false;
			}
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = A - C;
			double num = r * r;
			double num2 = Vector2d.Dot(vector2d, vector2d);
			double num3 = Vector2d.Dot(vector2d, vector2d2);
			double num4 = Vector2d.Dot(vector2d2, vector2d2) - num;
			double num5 = num3 * num3 - num2 * num4;
			if (num5 < 0.0)
			{
				P1 = Vector2d.NaN;
				P2 = Vector2d.NaN;
				return false;
			}
			num5 = Math.Sqrt(num5);
			P1 = A + vector2d * (0.0 - num3 - num5) / num2;
			P2 = A + vector2d * (0.0 - num3 + num5) / num2;
			return true;
		}

		private static bool inSegment(Vector2d P, Vector2d A, Vector2d B)
		{
			if (A.x != B.x)
			{
				if (P.x >= A.x && P.x <= B.x)
				{
					return true;
				}
				if (P.x >= B.x && P.x <= A.x)
				{
					return true;
				}
			}
			else
			{
				if (P.y >= A.y && P.y >= B.y)
				{
					return true;
				}
				if (P.y >= B.y && P.y <= A.y)
				{
					return true;
				}
			}
			return false;
		}
	}

	public static class Segment
	{
		public static double PointSquareDistance(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.SquareDistanceToSegment(P, A, B);
		}

		public static double PointDistance(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.DistanceToSegment(P, A, B);
		}

		public static double SegmentSquareDistance2(Vector2d A, Vector2d B, Vector2d C, Vector2d D)
		{
			Vector2d a = B - A;
			Vector2d vector2d = D - C;
			double num = Vector2d.Det(a, vector2d);
			if (num == 0.0)
			{
				if (a.x != 0.0)
				{
					double num2 = (C.x - A.x) / a.x;
					if (num2 >= 0.0 && num2 <= 1.0)
					{
						return Point.SquareDistanceToLine(C, A, B);
					}
					double num3 = (D.x - A.x) / a.x;
					if (num3 >= 0.0 && num3 <= 1.0)
					{
						return Point.SquareDistanceToLine(D, A, B);
					}
					double a2 = Vector2d.SquareDistance(A, (Math.Abs(num2) < Math.Abs(num3)) ? C : D);
					double b = Vector2d.SquareDistance(B, (Math.Abs(num2 - 1.0) < Math.Abs(num3 - 1.0)) ? C : D);
					return Math.Min(a2, b);
				}
				if (a.y != 0.0)
				{
					double num4 = (C.y - A.y) / a.y;
					if (num4 >= 0.0 && num4 <= 1.0)
					{
						return Point.SquareDistanceToLine(C, A, B);
					}
					double num5 = (D.y - A.y) / a.y;
					if (num5 >= 0.0 && num5 <= 1.0)
					{
						return Point.SquareDistanceToLine(D, A, B);
					}
					double a3 = Vector2d.SquareDistance(A, (Math.Abs(num4) < Math.Abs(num5)) ? C : D);
					double b2 = Vector2d.SquareDistance(B, (Math.Abs(num4 - 1.0) < Math.Abs(num5 - 1.0)) ? C : D);
					return Math.Min(a3, b2);
				}
				return Point.SquareDistanceToSegment(A, C, D);
			}
			Vector2d b3 = A - C;
			double num6 = Vector2d.Det(vector2d, b3) / num;
			double num7 = Vector2d.Det(a, b3) / num;
			if (num7 > 1.0)
			{
				if (num6 > 1.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(B, C, D), Point.SquareDistanceToSegment(D, A, B));
				}
				if (num6 < 0.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(A, C, D), Point.SquareDistanceToSegment(D, A, B));
				}
				return Point.SquareDistanceToLine(D, A, B);
			}
			if (num7 < 0.0)
			{
				if (num6 > 1.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(B, C, D), Point.SquareDistanceToSegment(C, A, B));
				}
				if (num6 < 0.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(A, C, D), Point.SquareDistanceToSegment(C, A, B));
				}
				return Point.SquareDistanceToLine(C, A, B);
			}
			if (num6 > 1.0)
			{
				return Point.SquareDistanceToLine(B, C, D);
			}
			if (num6 < 0.0)
			{
				return Point.SquareDistanceToLine(A, C, D);
			}
			return 0.0;
		}

		public static double SegmentSquareDistance(Vector2d A, Vector2d B, Vector2d C, Vector2d D)
		{
			Vector2d a = B - A;
			Vector2d vector2d = D - C;
			double num = Vector2d.Det(a, vector2d);
			if (num == 0.0)
			{
				return Math.Min(Point.SquareDistanceToSegment(A, C, D), Point.SquareDistanceToSegment(B, C, D), Point.SquareDistanceToSegment(C, A, B), Point.SquareDistanceToSegment(D, A, B));
			}
			Vector2d b = A - C;
			double num2 = Vector2d.Det(vector2d, b) / num;
			double num3 = Vector2d.Det(a, b) / num;
			if (num3 > 1.0)
			{
				if (num2 > 1.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(B, C, D), Point.SquareDistanceToSegment(D, A, B));
				}
				if (num2 < 0.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(A, C, D), Point.SquareDistanceToSegment(D, A, B));
				}
				return Point.SquareDistanceToSegment(D, A, B);
			}
			if (num3 < 0.0)
			{
				if (num2 > 1.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(B, C, D), Point.SquareDistanceToSegment(C, A, B));
				}
				if (num2 < 0.0)
				{
					return Math.Min(Point.SquareDistanceToSegment(A, C, D), Point.SquareDistanceToSegment(C, A, B));
				}
				return Point.SquareDistanceToSegment(C, A, B);
			}
			if (num2 > 1.0)
			{
				return Point.SquareDistanceToSegment(B, C, D);
			}
			if (num2 < 0.0)
			{
				return Point.SquareDistanceToSegment(A, C, D);
			}
			return 0.0;
		}

		public static double SegmentDistance(Vector2d A, Vector2d B, Vector2d C, Vector2d D)
		{
			return Math.Sqrt(SegmentSquareDistance(A, B, C, D));
		}

		public static Vector2d ClosestPoint(Vector2d P, Vector2d A, Vector2d B)
		{
			return Point.SegmentClosestPoint(P, A, B);
		}

		public static bool LineIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, Vector2d D, out Vector2d P)
		{
			return Line.SegmentIntersectionPoint(C, D, A, B, out P);
		}

		public static bool SegmentIntersects(Vector2d A, Vector2d B, Vector2d C, Vector2d D)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = D - C;
			Vector2d b = A - C;
			double num = Vector2d.Det(vector2d, vector2d2);
			if (num == 0.0)
			{
				if (Vector2d.Det(vector2d, b) != 0.0 || Vector2d.Det(vector2d2, b) != 0.0)
				{
					return false;
				}
				double num2 = Vector2d.Dot(vector2d, vector2d);
				double num3 = Vector2d.Dot(vector2d2, vector2d2);
				if (num2 == 0.0 && num3 == 0.0)
				{
					if (A != C)
					{
						return false;
					}
					return true;
				}
				if (num2 == 0.0)
				{
					if (!inSegment(A, C, D))
					{
						return false;
					}
					return true;
				}
				if (num3 == 0.0)
				{
					if (!inSegment(C, A, B))
					{
						return false;
					}
					return true;
				}
				Vector2d vector2d3 = B - C;
				double num4;
				double num5;
				if (vector2d2.x != 0.0)
				{
					num4 = b.x / vector2d2.x;
					num5 = vector2d3.x / vector2d2.x;
				}
				else
				{
					num4 = b.y / vector2d2.y;
					num5 = vector2d3.y / vector2d2.y;
				}
				if (num4 > 1.0 || num5 < 0.0)
				{
					return false;
				}
				return true;
			}
			double num6 = Vector2d.Det(vector2d2, b) / num;
			if (num6 < 0.0 || num6 > 1.0)
			{
				return false;
			}
			double num7 = Vector2d.Det(vector2d, b) / num;
			if (num7 < 0.0 || num7 > 1.0)
			{
				return false;
			}
			return true;
		}

		public static bool SegmentIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, Vector2d D, out Vector2d P)
		{
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = D - C;
			Vector2d b = A - C;
			double num = Vector2d.Det(vector2d, vector2d2);
			if (num == 0.0)
			{
				if (Vector2d.Det(vector2d, b) != 0.0 || Vector2d.Det(vector2d2, b) != 0.0)
				{
					P = Vector2d.NaN;
					return false;
				}
				double num2 = Vector2d.Dot(vector2d, vector2d);
				double num3 = Vector2d.Dot(vector2d2, vector2d2);
				if (num2 == 0.0 && num3 == 0.0)
				{
					if (A != C)
					{
						P = Vector2d.NaN;
						return false;
					}
					P = A;
					return true;
				}
				if (num2 == 0.0)
				{
					if (!inSegment(A, C, D))
					{
						P = Vector2d.NaN;
						return false;
					}
					P = A;
					return true;
				}
				if (num3 == 0.0)
				{
					if (!inSegment(C, A, B))
					{
						P = Vector2d.NaN;
						return false;
					}
					P = C;
					return true;
				}
				Vector2d vector2d3 = B - C;
				double num4;
				double num5;
				if (vector2d2.x != 0.0)
				{
					num4 = b.x / vector2d2.x;
					num5 = vector2d3.x / vector2d2.x;
				}
				else
				{
					num4 = b.y / vector2d2.y;
					num5 = vector2d3.y / vector2d2.y;
				}
				if (num4 > num5)
				{
					double num6 = num4;
					num4 = num5;
					num5 = num6;
				}
				if (num4 > 1.0 || num5 < 0.0)
				{
					P = Vector2d.NaN;
					return false;
				}
				num4 = ((num4 < 0.0) ? 0.0 : num4);
				num5 = ((num5 > 1.0) ? 1.0 : num5);
				P = C + num4 * vector2d2;
				return true;
			}
			double num7 = Vector2d.Det(vector2d2, b) / num;
			if (num7 < 0.0 || num7 > 1.0)
			{
				P = Vector2d.NaN;
				return false;
			}
			double num8 = Vector2d.Det(vector2d, b) / num;
			if (num8 < 0.0 || num8 > 1.0)
			{
				P = Vector2d.NaN;
				return false;
			}
			P = A + num7 * vector2d;
			return true;
		}

		public static bool CircleIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, double r, out Vector2d P1, out Vector2d P2)
		{
			if (A == B)
			{
				if (Vector2d.SquareDistance(A, C) == r * r)
				{
					P1 = A;
					P2 = A;
					return true;
				}
				P1 = Vector2d.NaN;
				P2 = Vector2d.NaN;
				return false;
			}
			Vector2d vector2d = B - A;
			Vector2d vector2d2 = A - C;
			double num = r * r;
			double num2 = Vector2d.Dot(vector2d, vector2d);
			double num3 = Vector2d.Dot(vector2d, vector2d2);
			double num4 = Vector2d.Dot(vector2d2, vector2d2) - num;
			double num5 = num3 * num3 - num2 * num4;
			if (num5 < 0.0)
			{
				P1 = Vector2d.NaN;
				P2 = Vector2d.NaN;
				return false;
			}
			num5 = Math.Sqrt(num5);
			double num6 = (0.0 - num3 - num5) / num2;
			double num7 = (0.0 - num3 + num5) / num2;
			P1 = ((num6 >= 0.0 && num6 <= 1.0) ? (A + vector2d * num6) : Vector2d.NaN);
			P2 = ((num7 >= 0.0 && num7 <= 1.0) ? (A + vector2d * num7) : Vector2d.NaN);
			if (P1.IsNaN)
			{
				return !P2.IsNaN;
			}
			return true;
		}

		private static bool inSegment(Vector2d P, Vector2d A, Vector2d B)
		{
			if (A.x != B.x)
			{
				if (P.x >= A.x && P.x <= B.x)
				{
					return true;
				}
				if (P.x >= B.x && P.x <= A.x)
				{
					return true;
				}
			}
			else
			{
				if (P.y >= A.y && P.y >= B.y)
				{
					return true;
				}
				if (P.y >= B.y && P.y <= A.y)
				{
					return true;
				}
			}
			return false;
		}
	}

	public static class Circle
	{
		public static double PointDistance(Vector2d P, Vector2d C, double r)
		{
			return Point.DistanceToCircle(P, C, r);
		}

		public static bool ContainsPoint(Vector2d P, Vector2d C, double r)
		{
			return Point.Incircle(P, C, r);
		}

		public static bool CircleIntersectionPoints(Vector2d A, Vector2d B, double r, out Vector2d P1, out Vector2d P2)
		{
			Vector2d vector2d = B - A;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = 4.0 * r * r;
			if (squareMagnitude > num)
			{
				P1 = (P2 = Vector2d.NaN);
				return false;
			}
			if (squareMagnitude == num)
			{
				P1 = (P2 = A + vector2d / 2.0);
				return true;
			}
			Vector2d vector2d2 = A + vector2d / 2.0;
			Vector2d vector2d3 = vector2d.Perpendicular / Math.Sqrt(squareMagnitude);
			double num2 = Math.Sqrt(r * r - squareMagnitude / 4.0);
			P1 = vector2d2 - vector2d3 * num2;
			P2 = vector2d2 + vector2d3 * num2;
			return true;
		}

		public static bool TangentPoints(Vector2d P, Vector2d C, double r, out Vector2d L, out Vector2d R)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				L = P;
				R = P;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				double num3 = Math.Sqrt(squareMagnitude - num);
				double num4 = r * vector2d.x;
				double num5 = r * vector2d.y;
				double num6 = num3 * vector2d.x;
				double num7 = num3 * vector2d.y;
				L = new Vector2d(C.x + (num4 + num7) * num2, C.y + (num5 - num6) * num2);
				R = new Vector2d(C.x + (num4 - num7) * num2, C.y + (num5 + num6) * num2);
				return true;
			}
			L = Vector2d.NaN;
			R = Vector2d.NaN;
			return false;
		}

		public static bool TangentPoints(Vector2d P, Vector2d C, double r, out Vector2d L, out Vector2d R, out double d)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				L = P;
				R = P;
				d = 0.0;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				d = Math.Sqrt(squareMagnitude - num);
				double num3 = r * vector2d.x;
				double num4 = r * vector2d.y;
				double num5 = d * vector2d.x;
				double num6 = d * vector2d.y;
				L = new Vector2d(C.x + (num3 + num6) * num2, C.y + (num4 - num5) * num2);
				R = new Vector2d(C.x + (num3 - num6) * num2, C.y + (num4 + num5) * num2);
				return true;
			}
			L = Vector2d.NaN;
			R = Vector2d.NaN;
			d = double.PositiveInfinity;
			return false;
		}

		public static bool LeftTangentPoints(Vector2d P, Vector2d C, double r, out Vector2d L)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				L = P;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				double num3 = Math.Sqrt(squareMagnitude - num);
				L = new Vector2d(C.x + (r * vector2d.x + num3 * vector2d.y) * num2, C.y + (r * vector2d.y - num3 * vector2d.x) * num2);
				return true;
			}
			L = Vector2d.NaN;
			return false;
		}

		public static bool LeftTangentPoints(Vector2d P, Vector2d C, double r, out Vector2d L, out double d)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				L = P;
				d = 0.0;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				d = Math.Sqrt(squareMagnitude - num);
				L = new Vector2d(C.x + (r * vector2d.x + d * vector2d.y) * num2, C.y + (r * vector2d.y - d * vector2d.x) * num2);
				return true;
			}
			L = Vector2d.NaN;
			d = double.PositiveInfinity;
			return false;
		}

		public static bool RightTangentPoints(Vector2d P, Vector2d C, double r, out Vector2d R)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				R = P;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				double num3 = Math.Sqrt(squareMagnitude - num);
				R = new Vector2d(C.x + (r * vector2d.x - num3 * vector2d.y) * num2, C.y + (r * vector2d.y + num3 * vector2d.x) * num2);
				return true;
			}
			R = Vector2d.NaN;
			return false;
		}

		public static bool RightTangentPoints(Vector2d P, Vector2d C, double r, out Vector2d R, out double d)
		{
			Vector2d vector2d = P - C;
			double squareMagnitude = vector2d.SquareMagnitude;
			double num = r * r;
			if (squareMagnitude == num)
			{
				R = P;
				d = 0.0;
				return true;
			}
			if (squareMagnitude > num)
			{
				double num2 = r / squareMagnitude;
				d = Math.Sqrt(squareMagnitude - num);
				R = new Vector2d(C.x + (r * vector2d.x - d * vector2d.y) * num2, C.y + (r * vector2d.y + d * vector2d.x) * num2);
				return true;
			}
			R = Vector2d.NaN;
			d = double.PositiveInfinity;
			return false;
		}

		public static bool LineintersectionPoints(Vector2d A, Vector2d B, Vector2d C, double r, out Vector2d P1, out Vector2d P2)
		{
			return Line.CircleIntersectionPoints(A, B, C, r, out P1, out P2);
		}

		public static bool SegmentIntersectionPoint(Vector2d A, Vector2d B, Vector2d C, double r, out Vector2d P1, out Vector2d P2)
		{
			return Segment.CircleIntersectionPoint(A, B, C, r, out P1, out P2);
		}

		public static double ArcLength(Vector2d A, Vector2d B, Vector2d C, double r)
		{
			return Vector2d.AngleNormalized((A - C) / r, (B - C) / r) * r;
		}

		public static double FastArcLength(Vector2d A, Vector2d B, Vector2d C, double r)
		{
			return Vector2d.FastAngleNormalized((A - C) / r, (B - C) / r) * r;
		}
	}
}
