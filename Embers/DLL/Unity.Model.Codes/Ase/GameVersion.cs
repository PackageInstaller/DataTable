using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class GameVersion
{
	public string app_version;

	public string game_version;

	public string resource_version;

	public string code_version;

	public string dataTable_version;

	public string paradox_version;

	public string audio_version;

	public string story_version;

	public string scenes_version;

	public string cdn_url;

	public string cdn_url_fallback;

	public string platform_url;

	public string lottery_url;

	public string level_save_bucket;

	public List<ServerInfo> server_list;

	public int deviceTier;

	public int resource_version_internal;

	public int code_version_internal;

	public int dataTable_version_internal;

	public int paradox_version_internal;

	public bool force_update;

	public string app_url;

	public bool app_review;

	public bool app_testflight;

	public bool app_isupdate;

	public bool login_video;

	public long login_open_time;

	public string login_open_tip;

	public string active_resource_versions;
}
