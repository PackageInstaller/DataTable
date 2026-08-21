local config = {
  str_return_system_name = [[
Navigator
Welcome Back]],
  str_return_system_time_main = "<color=#ffffff>Event Time Remaining: </color><color=#df8e00>{1}</color>",
  str_return_system_time_login = "<color=#c46300>Next Claiming Time: </color><color=#ffdb15>{1}</color>",
  str_return_system_time_quest = "<color=#c46300>Daily Quest Refresh Countdown: </color><color=#ffdb15>{1}</color>",
  str_return_system_time_boost = "<color=#c46300>Resolve Reset Countdown: </color><color=#ffdb15>{1}</color>",
  str_return_system_btn_intro = "Event Info",
  str_return_system_btn_story = "Story Recap",
  str_return_system_btn_welecome = "You're Back!",
  str_return_system_btn_sign = "Returner Sign-In",
  str_return_system_btn_mission = "Returner Quests",
  str_return_system_btn_gift = "Returner Gifts",
  str_return_system_btn_assistance = "Returner's Resolve",
  str_return_system_btn_shop = "Returner Store",
  str_return_system_get_award = "Claim Returner Rewards!",
  str_return_system_greetings = "PlayerName, you're back! Not much has changed around here recently, but... we all missed you so much!",
  str_return_system_extra_drop_times = "Today's <color=#df8e00>[Resource Raid]</color> Extra Loots: <color=#df8e00>{1}</color>/{2}",
  str_return_system_extra_drop_times_not_enough = "You don't have enough extra Resource Raid drop chances left for today!",
  str_return_system_reset_after_d_h = "Resets in {1}d {2}h",
  str_return_system_reset_after_h_m = "Resets in {1}h {2} min",
  str_return_system_reset_after_m = "Resets in {1} min",
  str_return_system_reset_after_lt_m = "Resets in less than 1 minute",
  str_return_system_desc = [[
- Complete Resource Raid stages while you have the Returner's Resolve buff and you'll get an extra reward.
- You'll get a specific number of chances to use Returner's Resolve every day, and these chances will refresh at a fixed time, daily.
- Use a Carrier to enter Resource Raid stages and get extra rewards and consume attempts.]],
  str_return_system_desc_1 = [[
- Complete Resource Raid stages while you have the Returner's Resolve buff and you'll get <color=#df8e00>2</color> extra rewards.
- You'll get a specific number of chances to use Returner's Resolve every day, and these chances will refresh at a fixed time, daily.
- Use a Carrier to enter Resource Raid stages and get extra rewards and consume attempts.]],
  str_return_system_reward_triple = "3 July - 26 July <color=#df8e00>3×</color> Rewards!",
  str_return_system_goto_challenge = "Challenge Now!",
  str_return_system_goto_challenge_hint = "Resource Raid not available yet!",
  str_return_system_award_hello_1600061 = "Your Excellency, I hope that you are well. On behalf of Lumopolis, I would like to send you my sincerest wishes for a speedy recovery!",
  str_return_system_award_hello_1600021 = "Flowers blossom or wither, depending on the weather and seasons, but to possess good health—this is something over which we all have control. The next time we meet, let us meditate together beneath the Sakura's petals.",
  str_return_system_award_hello_1601051 = "Navigator, my brother told me you went on vacation... Is it true? Here—this is a specialty of the Rediesel Wrench... I hope you like it!",
  str_return_system_award_hello_1300521 = "I'm usually the one who stands others up, so I never expected you'd actually stand me up back! This is something I've been hiding for quite a while now. Here you go—don't tell anyone!",
  str_return_system_award_hello_1600381 = "Argh! Don't you just hate it when you crash right in the middle of a game? But don't worry, I have saved up some welcome-back bonuses for you! Take them and faceroll your way to victory! May the RNG be with you!",
  str_return_system_award_hello_1600261 = "While you were gone... I felt as though that feeling of nothingness intensified somewhat... No, I'm fine... You're back now, and that's all that matters...",
  str_return_system_award_hello_1400571 = "I haven't seen you in ages, Navigator! The Chief asked me to give you these goodies to get you back in fighting form... Which \"Chief,\" meow? Philyshy can't tell you that!",
  str_return_system_award_hello_1600251 = "My faithful audience has returned! How could I, Acheron Ferryman Charon, be on the stage without you? The curtain has been raised, and now, the shining lights of the stage await your triumphant encore!",
  str_return_system_award_from_1600061 = "A Gift from Carleen",
  str_return_system_award_from_1600021 = "A Gift from Hiiro",
  str_return_system_award_from_1601051 = "A Gift from Eve",
  str_return_system_award_from_1300521 = "A Gift from Dove",
  str_return_system_award_from_1600381 = "A Gift from Gronru",
  str_return_system_award_from_1600261 = "A Gift from Uriel",
  str_return_system_award_from_1400571 = "A Gift from Philyshy",
  str_return_system_award_from_1600251 = "A Gift from Charon",
  str_return_system_cell_locked = "Locked",
  str_return_system_intro_head_1 = "Login Rewards",
  str_return_system_intro_body_1 = "1. Log in every day during the Returner event period to claim login rewards.",
  str_return_system_intro_head_2 = "Returner Quests",
  str_return_system_intro_body_2 = [[
1. You can earn event points by completing Daily Returner Quests or regular Returner Quests.
2. Once you've accumulated the required amount of event points, you can claim Returner rewards.
3. Daily Quests refresh every day, and can be completed repeatedly.]],
  str_return_system_intro_head_3 = "Returner Assistant",
  str_return_system_intro_body_3 = [[
1.Returner's Resolve chances refresh every day (unused chances will also be refreshed).
2.When you have Returner's Resolve buff chances available, you can use them before entering Resource Raid stages to obtain extra rewards.
3.Use a Carrier to enter Resource Raid stages and get extra rewards and consume attempts.]],
  str_return_system_intro_head_4 = "Returner Store",
  str_return_system_intro_body_4 = [[
1. In the 7 days leading up to the Welcome Back, Navigator event, you'll receive a certain amount of Return Records whenever you complete Main Story stages or Resource Raid stages that consume Prism.
2. When the Welcome Back, Navigator event begins, you can spend your Return Records in the Returner Store to buy items.
3. After the Welcome Back, Navigator event ends, your unused Return Records will be deleted. Please make sure you pay attention to when the event ends!]],
  str_return_system_progress_desc_1 = "Current Points",
  str_return_system_progress_desc_2 = "You can claim rewards once you have enough points",
  str_return_system_reward_title = "Returner's Resolve",
  str_return_system_res_enter_title = "Welcome Back",
  str_return_system_huiliu_1050001 = "Return Rewards",
  str_return_system_huiliu_1050002 = "Returning Ascension Pack",
  str_return_system_huiliu_1050003 = "Returning Recruitment Kit",
  str_return_system_tip_title = "Returner Store Return Record Drop Info",
  str_return_system_tip_info = [[
1. In the 7 days leading up to the Welcome Back, Navigator event, you'll receive a certain amount of Return Records whenever you complete Main Story stages or Resource Raid stages that consume Prism.
2. When the Welcome Back, Navigator event begins, you can spend your Return Records in the Returner Store to buy items.
3. After the Welcome Back, Navigator event ends, your unused Return Records will be deleted. Please make sure you pay attention to when the event ends!]],
  str_return_system_tip_time = "Return Record Availability: {1}"
}
return config
