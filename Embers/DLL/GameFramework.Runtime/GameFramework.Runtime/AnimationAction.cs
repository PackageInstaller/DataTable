using System;

namespace GameFramework.Runtime;

public delegate void AnimationAction<T>(T view, Action startCallback, Action endCallback) where T : IUIView;
