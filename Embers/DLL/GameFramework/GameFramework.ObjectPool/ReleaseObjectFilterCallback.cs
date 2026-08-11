using System;
using System.Collections.Generic;

namespace GameFramework.ObjectPool;

public delegate List<T> ReleaseObjectFilterCallback<T>(List<T> candidateObjects, int toReleaseCount, DateTime expireTime) where T : ObjectBase;
