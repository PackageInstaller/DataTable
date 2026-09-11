using System;
using System.Diagnostics;
using UnityEngine;

namespace Pathfinding;

public class Profile
{
	private const bool PROFILE_MEM = false;

	public readonly string name;

	private readonly Stopwatch watch;

	private int counter;

	private long mem;

	private long smem;

	private int control = 1073741824;

	private const bool dontCountFirst = false;

	public int ControlValue()
	{
		return control;
	}

	public Profile(string name)
	{
		this.name = name;
		watch = new Stopwatch();
	}

	public static void WriteCSV(string path, params Profile[] profiles)
	{
	}

	public void Run(Action action)
	{
		action();
	}

	[Conditional("PROFILE")]
	public void Start()
	{
		watch.Start();
	}

	[Conditional("PROFILE")]
	public void Stop()
	{
		counter++;
		watch.Stop();
	}

	[Conditional("PROFILE")]
	public void Log()
	{
		Debug.Log((object)ToString());
	}

	[Conditional("PROFILE")]
	public void ConsoleLog()
	{
		Console.WriteLine(ToString());
	}

	[Conditional("PROFILE")]
	public void Stop(int control)
	{
		counter++;
		watch.Stop();
		if (this.control == 1073741824)
		{
			this.control = control;
		}
		else if (this.control != control)
		{
			throw new Exception("Control numbers do not match " + this.control + " != " + control);
		}
	}

	[Conditional("PROFILE")]
	public void Control(Profile other)
	{
		if (ControlValue() != other.ControlValue())
		{
			throw new Exception("Control numbers do not match (" + name + " " + other.name + ") " + ControlValue() + " != " + other.ControlValue());
		}
	}

	public override string ToString()
	{
		return name + " #" + counter + " " + watch.Elapsed.TotalMilliseconds.ToString("0.0 ms") + " avg: " + (watch.Elapsed.TotalMilliseconds / (double)counter).ToString("0.00 ms");
	}
}
