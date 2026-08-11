namespace System.Text.RegularExpressions;

public abstract class RegexRunner
{
	protected internal int runtextbeg;

	protected internal int runtextend;

	protected internal int runtextstart;

	protected internal string runtext;

	protected internal int runtextpos;

	protected internal int[] runtrack;

	protected internal int runtrackpos;

	protected internal int[] runstack;

	protected internal int runstackpos;

	protected internal int[] runcrawl;

	protected internal int runcrawlpos;

	protected internal int runtrackcount;

	protected internal Match runmatch;

	protected internal Regex runregex;

	private int _timeout;

	private bool _ignoreTimeout;

	private int _timeoutOccursAt;

	private const int TimeoutCheckFrequency = 1000;

	private int _timeoutChecksToSkip;

	protected internal RegexRunner()
	{
	}

	protected internal Match Scan(Regex regex, string text, int textbeg, int textend, int textstart, int prevlen, bool quick, TimeSpan timeout)
	{
		bool flag = false;
		Regex.ValidateMatchTimeout(timeout);
		_ignoreTimeout = Regex.InfiniteMatchTimeout == timeout;
		_timeout = (_ignoreTimeout ? ((int)Regex.InfiniteMatchTimeout.TotalMilliseconds) : ((int)(timeout.TotalMilliseconds + 0.5)));
		runregex = regex;
		runtext = text;
		runtextbeg = textbeg;
		runtextend = textend;
		runtextstart = textstart;
		int num = ((!runregex.RightToLeft) ? 1 : (-1));
		int num2 = (runregex.RightToLeft ? runtextbeg : runtextend);
		runtextpos = textstart;
		if (prevlen == 0)
		{
			if (runtextpos == num2)
			{
				return Match.Empty;
			}
			runtextpos += num;
		}
		StartTimeoutWatch();
		while (true)
		{
			if (FindFirstChar())
			{
				CheckTimeout();
				if (!flag)
				{
					InitMatch();
					flag = true;
				}
				Go();
				if (runmatch._matchcount[0] > 0)
				{
					return TidyMatch(quick);
				}
				runtrackpos = runtrack.Length;
				runstackpos = runstack.Length;
				runcrawlpos = runcrawl.Length;
			}
			if (runtextpos == num2)
			{
				break;
			}
			runtextpos += num;
		}
		TidyMatch(quick: true);
		return Match.Empty;
	}

	private void StartTimeoutWatch()
	{
		if (!_ignoreTimeout)
		{
			_timeoutChecksToSkip = 1000;
			_timeoutOccursAt = Environment.TickCount + _timeout;
		}
	}

	protected void CheckTimeout()
	{
		if (!_ignoreTimeout)
		{
			DoCheckTimeout();
		}
	}

	private void DoCheckTimeout()
	{
		if (--_timeoutChecksToSkip == 0)
		{
			_timeoutChecksToSkip = 1000;
			int tickCount = Environment.TickCount;
			if (tickCount >= _timeoutOccursAt && (0 <= _timeoutOccursAt || 0 >= tickCount))
			{
				throw new RegexMatchTimeoutException(runtext, runregex.pattern, TimeSpan.FromMilliseconds(_timeout));
			}
		}
	}

	protected abstract void Go();

	protected abstract bool FindFirstChar();

	protected abstract void InitTrackCount();

	private void InitMatch()
	{
		if (runmatch == null)
		{
			if (runregex.caps != null)
			{
				runmatch = new MatchSparse(runregex, runregex.caps, runregex.capsize, runtext, runtextbeg, runtextend - runtextbeg, runtextstart);
			}
			else
			{
				runmatch = new Match(runregex, runregex.capsize, runtext, runtextbeg, runtextend - runtextbeg, runtextstart);
			}
		}
		else
		{
			runmatch.Reset(runregex, runtext, runtextbeg, runtextend, runtextstart);
		}
		if (runcrawl != null)
		{
			runtrackpos = runtrack.Length;
			runstackpos = runstack.Length;
			runcrawlpos = runcrawl.Length;
			return;
		}
		InitTrackCount();
		int num = runtrackcount * 8;
		int num2 = runtrackcount * 8;
		if (num < 32)
		{
			num = 32;
		}
		if (num2 < 16)
		{
			num2 = 16;
		}
		runtrack = new int[num];
		runtrackpos = num;
		runstack = new int[num2];
		runstackpos = num2;
		runcrawl = new int[32];
		runcrawlpos = 32;
	}

	private Match TidyMatch(bool quick)
	{
		if (!quick)
		{
			Match match = runmatch;
			runmatch = null;
			match.Tidy(runtextpos);
			return match;
		}
		return null;
	}

	protected void EnsureStorage()
	{
		if (runstackpos < runtrackcount * 4)
		{
			DoubleStack();
		}
		if (runtrackpos < runtrackcount * 4)
		{
			DoubleTrack();
		}
	}

	protected bool IsBoundary(int index, int startpos, int endpos)
	{
		return (index > startpos && RegexCharClass.IsWordChar(runtext[index - 1])) != (index < endpos && RegexCharClass.IsWordChar(runtext[index]));
	}

	protected bool IsECMABoundary(int index, int startpos, int endpos)
	{
		return (index > startpos && RegexCharClass.IsECMAWordChar(runtext[index - 1])) != (index < endpos && RegexCharClass.IsECMAWordChar(runtext[index]));
	}

	protected void DoubleTrack()
	{
		int[] destinationArray = new int[runtrack.Length * 2];
		Array.Copy(runtrack, 0, destinationArray, runtrack.Length, runtrack.Length);
		runtrackpos += runtrack.Length;
		runtrack = destinationArray;
	}

	protected void DoubleStack()
	{
		int[] destinationArray = new int[runstack.Length * 2];
		Array.Copy(runstack, 0, destinationArray, runstack.Length, runstack.Length);
		runstackpos += runstack.Length;
		runstack = destinationArray;
	}

	protected void DoubleCrawl()
	{
		int[] destinationArray = new int[runcrawl.Length * 2];
		Array.Copy(runcrawl, 0, destinationArray, runcrawl.Length, runcrawl.Length);
		runcrawlpos += runcrawl.Length;
		runcrawl = destinationArray;
	}

	protected void Crawl(int i)
	{
		if (runcrawlpos == 0)
		{
			DoubleCrawl();
		}
		runcrawl[--runcrawlpos] = i;
	}

	protected int Popcrawl()
	{
		return runcrawl[runcrawlpos++];
	}

	protected int Crawlpos()
	{
		return runcrawl.Length - runcrawlpos;
	}

	protected void Capture(int capnum, int start, int end)
	{
		if (end < start)
		{
			int num = end;
			end = start;
			start = num;
		}
		Crawl(capnum);
		runmatch.AddMatch(capnum, start, end - start);
	}

	protected void TransferCapture(int capnum, int uncapnum, int start, int end)
	{
		if (end < start)
		{
			int num = end;
			end = start;
			start = num;
		}
		int num2 = MatchIndex(uncapnum);
		int num3 = num2 + MatchLength(uncapnum);
		if (start >= num3)
		{
			end = start;
			start = num3;
		}
		else if (end <= num2)
		{
			start = num2;
		}
		else
		{
			if (end > num3)
			{
				end = num3;
			}
			if (num2 > start)
			{
				start = num2;
			}
		}
		Crawl(uncapnum);
		runmatch.BalanceMatch(uncapnum);
		if (capnum != -1)
		{
			Crawl(capnum);
			runmatch.AddMatch(capnum, start, end - start);
		}
	}

	protected void Uncapture()
	{
		int cap = Popcrawl();
		runmatch.RemoveMatch(cap);
	}

	protected bool IsMatched(int cap)
	{
		return runmatch.IsMatched(cap);
	}

	protected int MatchIndex(int cap)
	{
		return runmatch.MatchIndex(cap);
	}

	protected int MatchLength(int cap)
	{
		return runmatch.MatchLength(cap);
	}
}
