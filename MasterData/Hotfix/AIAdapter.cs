using System;
using UnityEngine;

public class AIAdapter
{
	private bool _isInitialized;

	private bool _isEnabled;

	private AIFromLocal _ai;

	public bool isPaused { get; private set; }

	public bool isRunning { get; private set; }

	public bool Initialize(string typeString, GameObject owner)
	{
		try
		{
			_ai = new AIFromLocal();
			_isInitialized = _ai.Initialize(typeString, owner);
			return _isInitialized;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			_ai = null;
			_isInitialized = false;
			return _isInitialized;
		}
	}

	public void SpecialEnable()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.SpecialEnable();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void Start()
	{
		try
		{
			if (_isInitialized && !_isEnabled)
			{
				_isEnabled = true;
				_ai?.Enable();
			}
			if (_isInitialized && !isRunning)
			{
				isRunning = true;
				isPaused = false;
				_ai?.Start();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void Update()
	{
		if (!_isInitialized || !isRunning || isPaused)
		{
			return;
		}
		try
		{
			_ai?.Update();
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
		finally
		{
		}
	}

	public void Pause()
	{
		if (!_isInitialized || isPaused)
		{
			return;
		}
		isPaused = true;
		try
		{
			_ai?.Pause();
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void Resume()
	{
		if (!_isInitialized || !isPaused)
		{
			return;
		}
		isPaused = false;
		try
		{
			_ai?.Resume();
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void Stop()
	{
		if (!_isInitialized || !isRunning)
		{
			return;
		}
		isRunning = false;
		try
		{
			_ai?.Stop();
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void Disable()
	{
		if (!_isInitialized || !_isEnabled)
		{
			return;
		}
		_isEnabled = false;
		isRunning = false;
		try
		{
			_ai?.Disable();
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void SpecialDisable()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.SpecialDisable();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void LevelStart()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.LevelStart();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void LevelEnd()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.LevelEnd();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void LoadLevelController()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.LoadLevelController();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}

	public void LoadDynamicModuleLevelController()
	{
		try
		{
			if (_isInitialized)
			{
				_ai?.LoadDynamicModuleLevelController();
			}
		}
		catch (Exception exception)
		{
			_ai = null;
			Debug.LogException(exception);
		}
	}
}
