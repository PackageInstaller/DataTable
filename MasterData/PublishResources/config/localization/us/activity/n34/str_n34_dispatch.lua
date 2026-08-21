local config = {
  str_n34_dispatch_plot_review_btn = "Recap",
  str_n34_dispatch_wait_btn = "Investigate Now",
  str_n34_dispatch_progress_btn = "Anticipated Time: {1}",
  str_n34_dispatch_wait_btn_status = "Advance Team Ready",
  str_n34_dispatch_progress_btn_status = "Investigation in Progress...",
  str_n34_dispatch_complete_title = "Investigation Completed",
  str_n34_dispatch_reward_title = "Obtained:",
  str_n34_dispatch_dialogue_btn = "Activate Terminal",
  str_n34_dispatch_dialogue_return_btn = "Back",
  str_n34_dispatch_all_over_tips = "Advance Team returned. Investigation completed.",
  str_n34_dispatch_need_selected_tips = "Please select an area to dispatch the team",
  str_n34_dispatch_selected_locked_tips = "Complete the investigation in the previous area to unlock.",
  str_n34_dispatch_selected_progress_tips = "The area is under the team's investigation.",
  str_n34_dispatch_selected_completed_tips = "The investigation in this area has been completed.",
  str_n34_dispatch_complete_node = "Investigation Completed",
  str_n34_dispatch_main_title = "Portable Terminal",
  str_n34_dispatch_log_open = "View",
  str_n34_dispatch_log_return = "Back",
  str_n34_dispatch_toast_tips = "The area is locked.",
  str_n34_dispatch_toast_tips_2 = "Please carry out the investigation based on the given order.",
  str_n34_dispatch_toast_tips_3 = "The investigation has not started.",
  str_n34_dispatch_toast_tips_4 = "Please dispatch the Advance Team first.",
  str_n34_dispatch_toast_tips_5 = "The dispatch quest is still in progress",
  str_n34_dispatch_toast_tips_6 = "Please wait for the team to be back",
  str_n34_dispatch_award_title = "Rewards Preview",
  str_n34_dispatch_now = "Current",
  str_n34_dispatch_log_title = "Mission",
  str_n34_dispatch_dialogue_title = "Terminal Log",
  str_n34_dispatch_log_tips = "Receiving signal... ",
  str_n34_dispatch_over_title = "Advance Team Returned!",
  str_n34_dispatch_over_desc = "After overcoming many hardships, the Advance Team returned to Twilight under the leadership of Gram. They also bring us substantial information that will be of great value to our next exploration.",
  str_n34_dispatch_over_btn_status = "Advance Team Returned",
  str_n34_dispatch_over_btn = "Investigation Completed",
  str_n34_dispatch_over_ok = "Okay.",
  str_n34_dispatch_task_name_1 = "Outpost 459",
  str_n34_dispatch_task_name_2 = "Supply Station 9543",
  str_n34_dispatch_task_name_3 = "Pathmarker S78865",
  str_n34_dispatch_task_name_4 = "Gorge Stone Bridge",
  str_n34_dispatch_task_name_5 = "Frost Marshland",
  str_n34_dispatch_task_name_6 = "Glacial Grove",
  str_n34_dispatch_task_name_7 = "Darkmist Mountain Pass",
  str_n34_dispatch_task_1_log_1 = [[
0.5 Hours into the Investigation
Moving into rough terrain, we're slowing down.]],
  str_n34_dispatch_task_1_log_2 = [[
1 Hour into the Investigation
Wow, the wind's really going wild! Hit the brakes! Now!]],
  str_n34_dispatch_task_1_log_3 = [[
1.5 Hours into the Investigation
Vehicle's broken down. Setting up camp temporarily for repairs. Benny, Curo, and Revy are staying on guard.]],
  str_n34_dispatch_task_1_log_4 = [[
3 Hours into the Investigation
The vehicle's back in action, and we're on track to reach Outpost 459 soon.]],
  str_n34_dispatch_task_1_log_5 = [[
4 Hours into the Investigation
Outpost 459 reached, and no enemy presence detected.]],
  str_n34_dispatch_task_1_log_6 = [[
4.5 Hours into the Investigation
Traps from the Eclipsites spotted and neutralized.]],
  str_n34_dispatch_task_1_log_7 = [[
5 Hours into the Investigation
Search complete. The team's splitting up for restocking and resting. Shift switch in 2 hours.]],
  str_n34_dispatch_task_1_log_8 = [[
7 Hours into the Investigation
Supply replenishment complete. It's time to change shift, resting in turns.]],
  str_n34_dispatch_task_1_log_9 = [[
9 Hours into the Investigation
Everyone's had their rest and is ready to go.]],
  str_n34_dispatch_task_2_log_1 = [[
0.5 Hours into the Investigation
Approaching the target location, we are confirming the exact spot.]],
  str_n34_dispatch_task_2_log_2 = [[
1 Hour into the Investigation
Wind's blowing like mad! Non-stop! Looks like we're gonna be lost!]],
  str_n34_dispatch_task_2_log_3 = [[
1.2 Hours into the Investigation
Looks like we're a bit off course. No clue about our directions...]],
  str_n34_dispatch_task_2_log_4 = [[
1.22 Hours into the Investigation
No need to worry. We're back on track and searching for Supply Station 9543.]],
  str_n34_dispatch_task_2_log_5 = [[
4 Hours into the Investigation
Supply Station 9543 located, buried deep underground. We're cleaning up the site now.]],
  str_n34_dispatch_task_2_log_6 = [[
4.2 Hours into the Investigation
No sign of Eclipsite activity. We're currently taking inventory of supplies.]],
  str_n34_dispatch_task_2_log_7 = [[
7 Hours into the Investigation
Fuel's plentiful; rations are squared away, although water's running a bit low. We're working on a distribution plan.]],
  str_n34_dispatch_task_2_log_8 = [[
7.5 Hours into the Investigation
Supply replenishment's done. We're good to push forward.]],
  str_n34_dispatch_task_3_log_1 = [[
1 Hour into the Investigation
Pathmarker S78865 located. Everything looks good.]],
  str_n34_dispatch_task_3_log_2 = [[
1.5 Hours into the Investigation
Pathmarker S78865 is in the wrong spot! Repositioning! Even Gram got it wrong this time!]],
  str_n34_dispatch_task_3_log_3 = [[
2 Hours into the Investigation
Based on our investigation, Pathmarker S78865 seems to have been moved. Gotta be those dreadful Eclipsites.]],
  str_n34_dispatch_task_3_log_4 = [[
2.2 Hours into the Investigation
We've assigned a team on guard and are trying to reset the coordinates of Pathmarker S78865.]],
  str_n34_dispatch_task_3_log_5 = [[
4 Hours into the Investigation
Coordinates have been reset. We've fixed Pathmarker S78865 in a hidden place and recorded its position.]],
  str_n34_dispatch_task_3_log_6 = [[
4.5 Hours into the Investigation
Setting up camp; staying on guard.]],
  str_n34_dispatch_task_3_log_7 = [[
5 Hours into the Investigation
Gram says we'll have to continue on foot from here. The vehicle's getting buried. Gotta find a cave, and gotta find it quick.]],
  str_n34_dispatch_task_3_log_8 = [[
7 Hours into the Investigation
Match in the wilderness? We're second to none! Those backpacks are no problem for us at all!]],
  str_n34_dispatch_task_3_log_9 = [[
7.2 Hours into the Investigation
Just to set the record straight, I'm the one carrying the backpacks. Benny and Curo are focused on keeping us on track.]],
  str_n34_dispatch_task_3_log_10 = [[
7.5 Hours into the Investigation
Sense of direction... Let's make sure we're not getting lost, okay?]],
  str_n34_dispatch_task_3_log_11 = [[
9 Hours into the Investigation
On the way to the gorge. Situation's under control.]],
  str_n34_dispatch_task_4_log_1 = [[
1.5 Hours into the Investigation
The gorge is unbelievably wide! How in the world do we get across it...]],
  str_n34_dispatch_task_4_log_2 = [[
2 Hours into the Investigation
Given the wild winds out here on the wasteland, flying over would be dangerous. A bridge would help us a lot.]],
  str_n34_dispatch_task_4_log_3 = [[
2.5 Hours into the Investigation
Actually, based on the info I've got, there's a stone bridge around. We just need to locate a hollow hill with three openings in the middle. The bridge should be close by there.]],
  str_n34_dispatch_task_4_log_4 = "3 Hours into the Investigation\nOne, two, three... three openings! This doesn't look like a rocky hill—it's more like a mini castle.",
  str_n34_dispatch_task_4_log_5 = [[
3.5 Hours into the Investigation
We're taking a 2-hour break, getting ready to cross that bridge.]],
  str_n34_dispatch_task_4_log_6 = [[
5.5 Hours into the Investigation
We're on the move across the bridge. No guardrails here, so be wary of gusts from the gorge. The first one is Gram.]],
  str_n34_dispatch_task_4_log_7 = [[
6 Hours into the Investigation
Gram's safely reached the other side. Safety ropes are all set and secured.]],
  str_n34_dispatch_task_4_log_8 = [[
6.5 Hours into the Investigation
We've reached the other side! And we brought Philyshy along! Turns out she's pretty lightweight.]],
  str_n34_dispatch_task_4_log_9 = [[
7 Hours into the Investigation
Chandra and Revy have made it safely to the other side with their gear. We're now radioing from the other side of the gorge, and everyone will take a 3-hour rest.]],
  str_n34_dispatch_task_4_log_10 = [[
10 Hours into the Investigation
The wind's getting colder... Time to hit the road.]],
  str_n34_dispatch_task_5_log_1 = [[
1 Hour into the Investigation
The wasteland comes to an end here, and who would've thought there'd be such a damp swamp in a place like this?]],
  str_n34_dispatch_task_5_log_2 = "1.5 Hours into the Investigation\nYou won't believe how bizarre the plants in this swamp are! Many of them have spikes and thorns, and get this—they're showing signs of mobility! Some are even exhaling icy breaths!",
  str_n34_dispatch_task_5_log_3 = [[
2 Hours into the Investigation
No one is allowed to touch the plants here. They may be poisonous.]],
  str_n34_dispatch_task_5_log_4 = [[
2.2 Hours into the Investigation
I'll clear a way out with my Alter-Blade, mostly to crack the ice.]],
  str_n34_dispatch_task_5_log_5 = [[
2.5 Hours into the Investigation
This swamp we're treading is a real danger zone, mainly because of all the fragile ice. Step without caution, and you might just crash right through and get stuck in it. Even if we manage to pull you out, you'd be drenched. In this biting cold, that's a fast track to hypothermia.]],
  str_n34_dispatch_task_5_log_6 = [[
3 Hours into the Investigation
Found a solid patch of ground. We're taking a 3-hour break to build a fire and dry our gear and shoes.]],
  str_n34_dispatch_task_5_log_7 = "6 Hours into the Investigation\nCan you believe it—no Eclipsites bugging us! This is getting way too dull!",
  str_n34_dispatch_task_5_log_8 = "6.2 Hours into the Investigation\nI doubt the Eclipsites ever imagined that Aurorians would go through this swamp. Our challenges are solely the immediate natural threats. Camp's over, everyone—let's keep pushing ahead.",
  str_n34_dispatch_task_5_log_9 = [[
8 Hours into the Investigation
All the swamp! Nearly got me drowned!]],
  str_n34_dispatch_task_5_log_10 = [[
8.2 Hours into the Investigation
Revy just got stuck in the swamp. When we pulled her out, she was drenched from head to toe. But Gram's decided to keep pushing forward! Let's hope his gut's got it right this time.]],
  str_n34_dispatch_task_5_log_11 = [[
9.5 Hours into the Investigation
Finally out of that mess! It even got me starting to miss the Dunefire Line.]],
  str_n34_dispatch_task_6_log_1 = [[
1 Hour into the Investigation
It's hills! Hills!]],
  str_n34_dispatch_task_6_log_2 = [[
1.2 Hours into the Investigation
The terrain ahead is unsettling, with a narrow field of view. Everyone, stay vigilant and watch out for Eclipsite ambushes.]],
  str_n34_dispatch_task_6_log_3 = [[
2 Hours into the Investigation
These pillars... they're covered in thick ice, reflecting light like mirrors. It's almost transparent... Don't let your guard down, team.]],
  str_n34_dispatch_task_6_log_4 = "2.2 Hours into the Investigation\nLooks like we're officially lost—even I can tell that.",
  str_n34_dispatch_task_6_log_5 = [[
2.5 Hours into the Investigation
Let's take a 4-hour break first. Gotta get our directions right before moving on.]],
  str_n34_dispatch_task_6_log_6 = [[
7 Hours into the Investigation
The light's way too dim! Can't use the sun or stars for navigation. So we have to turn to... machinery?]],
  str_n34_dispatch_task_6_log_7 = [[
7.5 Hours into the Investigation
Improvised a makeshift compass using a watch. Let's get out of this icy hillside first.]],
  str_n34_dispatch_task_6_log_8 = [[
8 Hours into the Investigation
Catching a whiff of... Eclipsite stench.]],
  str_n34_dispatch_task_6_log_9 = [[
8.2 Hours into the Investigation
Three Eclipsites just showed up and got sliced into six pieces by Revy.]],
  str_n34_dispatch_task_6_log_10 = [[
9 Hours into the Investigation
Finally out of that ice grove. While not as dangerous as the swamp, it's super easy to get lost in there...]],
  str_n34_dispatch_task_7_log_1 = [[
0.5 Hours into the Investigation
A huge mountain range blocks our path!]],
  str_n34_dispatch_task_7_log_2 = [[
0.8 Hours into the Investigation
We're currently seeking a route around the mountain range.]],
  str_n34_dispatch_task_7_log_3 = [[
2 Hours into the Investigation
Found an entrance to a cave, but the place is covered with Eclipsite footprints. We've decided to find an alternative route first.]],
  str_n34_dispatch_task_7_log_4 = [[
5 Hours into the Investigation
No luck finding another path. We're back to the cave to set up camp and explore.]],
  str_n34_dispatch_task_7_log_5 = [[
5.5 Hours into the Investigation
We've set up our camp. We decided to send Revy and Philyshy into the cave first. They're expected to be back in 1 hour.]],
  str_n34_dispatch_task_7_log_6 = [[
6 Hours into the Investigation
Eclipsites just attacked our camp! Not a big swarm, but a few managed to slip away.]],
  str_n34_dispatch_task_7_log_7 = [[
6.5 Hours into the Investigation
Revy and Philyshy didn't come back on time. We decided to wait one more hour here.]],
  str_n34_dispatch_task_7_log_8 = [[
7.5 Hours into the Investigation
Revy and Philyshy have not been back till now. Now Chandra will have the command, and I'll enter the cave to find the two.]],
  str_n34_dispatch_task_7_log_9 = [[
8 Hours into the Investigation
Eclipsites struck camp once more. We're relocating to a spot nearby, staking the flag as a signpost.]],
  str_n34_dispatch_task_7_log_10 = [[
9 Hours into the Investigation
Reporting to the Grand Marshal: if they don't return within 1 hour, Chandra, Benny, and Curo will make their way back.]],
  str_n34_dispatch_task_7_log_11 = [[
10 Hours into the Investigation
Thank the heavens above! They're back! Time to get out of here, everyone!]],
  str_n34_dispatch_task_1_com_1 = "Grand Marshal, Gram is reporting. Over.",
  str_n34_dispatch_task_1_com_2 = "Grand Marshal here. Over.",
  str_n34_dispatch_task_1_com_3 = "As the documents recorded, Outpost 459 has been destroyed by Eclipsites.",
  str_n34_dispatch_task_1_com_4 = "Tell me more about the traps you discovered. Over.",
  str_n34_dispatch_task_1_com_5 = "Most of them are natural sinkholes and loose rocks with an average level of tactics and camouflage, indicating that they're primitive devices set by the Eclipsites. Over.",
  str_n34_dispatch_task_1_com_6 = "What about the vehicles and personnel? Over.",
  str_n34_dispatch_task_1_com_7 = "Everything is normal. Over.",
  str_n34_dispatch_task_1_com_8 = "And the supplies? Over.",
  str_n34_dispatch_task_1_com_9 = "Food and water are abundant. We also have sufficient fuel that can secure our advance near the eternal night zone since the warehouse was spared by Eclipsites. Over.",
  str_n34_dispatch_task_1_com_10 = "Your camping equipment will be an emergency preparation in case of vehicle breakdown. Please ensure they're in good condition. Over.",
  str_n34_dispatch_task_1_com_11 = "Yes, Grand Marshal. Over.",
  str_n34_dispatch_task_1_com_12 = "And pay attention to the team member's mental health along the way. Over.",
  str_n34_dispatch_task_1_com_13 = "Yes, Grand Marshal!",
  str_n34_dispatch_task_1_com_14 = "We're fine!",
  str_n34_dispatch_task_1_com_15 = "Dried fish!",
  str_n34_dispatch_task_1_com_16 = "One, two, three Eclipsites, slashed into two, four, six parts...",
  str_n34_dispatch_task_1_com_17 = "Seems that they are safe and sound now, Grand Marshal. Over.",
  str_n34_dispatch_task_1_com_18 = "I've noticed too. Stay on alert. Over.",
  str_n34_dispatch_task_2_com_1 = "Have you got this message? Over.",
  str_n34_dispatch_task_2_com_2 = "The signals are clear. Got it. Over.",
  str_n34_dispatch_task_2_com_3 = "You said you're slightly short of water. Tell me more. Over.",
  str_n34_dispatch_task_2_com_4 = "We're short of clean water if said precisely. The water tank in Outpost 9543 was contaminated by silt.",
  str_n34_dispatch_task_2_com_5 = "If we processed the liquid in the supply station, our operation would be delayed. So we decided to use that part of the reserve as non-drinkable water. Over.",
  str_n34_dispatch_task_2_com_6 = "Which means we could only use muddy water to wash our faces then!",
  str_n34_dispatch_task_2_com_7 = "I may hear an unbearable jarring sound if I use it to wipe the weapon.",
  str_n34_dispatch_task_2_com_8 = "It seems that you're being troubled by unclean water. Over.",
  str_n34_dispatch_task_2_com_9 = "They're just minor issues. We may still drink the water if we boil and filter it.",
  str_n34_dispatch_task_2_com_10 = "Yes! After all, we're in the wilderness!",
  str_n34_dispatch_task_2_com_11 = "It is still much better than cold water!",
  str_n34_dispatch_task_2_com_12 = "Though the rusty taste in it makes our teeth ache...",
  str_n34_dispatch_task_2_com_13 = "At least your morale is high now. Over.",
  str_n34_dispatch_task_2_com_14 = "Yes, Grand Marshal. They don't need my help yet. Over.",
  str_n34_dispatch_task_2_com_15 = "Keep going. And remember to be vigilant all the way. Over.",
  str_n34_dispatch_task_2_com_16 = "Yes. We'll go! Over.",
  str_n34_dispatch_task_3_com_1 = "Reporting in, Grand Marshal. We're heading to the gorge. Over.",
  str_n34_dispatch_task_3_com_2 = "Now you'd continue the operation on foot. How about your condition? Over.",
  str_n34_dispatch_task_3_com_3 = "We've planned our load. Revy can carry the food and water for our team, and we remodeled her backpack for that purpose. Over.",
  str_n34_dispatch_task_3_com_4 = "It would be a tiresome task for a team member. Remember to shift regularly. Over.",
  str_n34_dispatch_task_3_com_5 = "I, Benny, and Curo will replace Revy to carry the load 4 hours later. Over.",
  str_n34_dispatch_task_3_com_6 = "Any difficulty in your march? Over.",
  str_n34_dispatch_task_3_com_7 = "We're still marching in the wilderness, so it's important to ascertain the directions. But Philyshy seems to be very good at it.",
  str_n34_dispatch_task_3_com_8 = "It's because I'm the Intel Chief, meow!",
  str_n34_dispatch_task_3_com_9 = "Didn't expect that I would lose to her in the march here...",
  str_n34_dispatch_task_3_com_10 = "Good to see a little competition among teammates. You're in high spirits now, please keep it up, Captain Gram. Over.",
  str_n34_dispatch_task_3_com_11 = "I wouldn't need to offer my help if we could always be in a high mood! Over.",
  str_n34_dispatch_task_3_com_12 = "It would be the best condition, but you shouldn't slack off either. If things get out of control, you may retreat to ensure there are no casualties. Over.",
  str_n34_dispatch_task_3_com_13 = "Yes, Grand Marshal. Over.",
  str_n34_dispatch_task_4_com_1 = "Tell me about the other side. Over.",
  str_n34_dispatch_task_4_com_2 = "The wind is not fierce but continues to blow. The temperature decreased. Frost on the ground. Over.",
  str_n34_dispatch_task_4_com_3 = "My hair all stands up... It's so cold.",
  str_n34_dispatch_task_4_com_4 = "We've put on our cold-proof gear and got wear in them. Over.",
  str_n34_dispatch_task_4_com_5 = "What about the stone bridge? And how will you return from there? Over.",
  str_n34_dispatch_task_4_com_6 = "The stone bridge is a piece of naturally eroded rock. The safety rope has been tightly fixed. Even Revy didn't slip when walking here. Over.",
  str_n34_dispatch_task_4_com_7 = "The bridge is very firm! It may even stand my bullets!",
  str_n34_dispatch_task_4_com_8 = "The way through the gorge is not so dangerous, as long as you don't try to see what's beneath you. At least that's what I thought.",
  str_n34_dispatch_task_4_com_9 = "People who can easily focus have an advantage in it. You may let Revy be the first when you return from there. Over.",
  str_n34_dispatch_task_4_com_10 = "Revy is not such people... It's only because she can't think about two things at once, meow!",
  str_n34_dispatch_task_4_com_11 = "It would also be an advantage if we see it from a certain point of view.",
  str_n34_dispatch_task_4_com_12 = "Your morale is high. The road ahead will be more difficult, please mind your health and supplies. Report if in any emergencies. Over.",
  str_n34_dispatch_task_4_com_13 = "Yes!",
  str_n34_dispatch_task_5_com_1 = "Cough... Gram is reporting, Grand Marshal. Over.",
  str_n34_dispatch_task_5_com_2 = "What about your condition? Can you persist? Over.",
  str_n34_dispatch_task_5_com_3 = "I've been in Illumina for years, but this is the first time I've seen such a strange terrain. It's cold and wet, but the ice layer here is so thin! I think I'd bring the personnel from the Research Lab here. Over.",
  str_n34_dispatch_task_5_com_4 = "Based on my experience, there must be invisible impurity in the water, so it cannot freeze easily.",
  str_n34_dispatch_task_5_com_5 = "The Intel Chief is right. We mustn't get water from the swamp unless in an emergency. Over.",
  str_n34_dispatch_task_5_com_6 = "But I've swallowed some. Maybe I got choked by the liquid when stuck in the swamp, and now my stomach hurts.",
  str_n34_dispatch_task_5_com_7 = "I've checked her condition. Revy only took in a bit, and I guess her unwell didn't come from the water but from the spasm caused by the cold and the wetness. We may press on her abdomen to relieve the pain.",
  str_n34_dispatch_task_5_com_8 = "Let us do it! Revy, we'll press on you with our might!",
  str_n34_dispatch_task_5_com_9 = "I'm here! Just aim at me!",
  str_n34_dispatch_task_5_com_10 = "We've set up our camp and are resting now.",
  str_n34_dispatch_task_5_com_11 = "Finally, dried fish and boiled water... If only there was a cup of coffee...",
  str_n34_dispatch_task_5_com_12 = "What about I treat you all after we return? My ration is abundant, and you will certainly get as much coffee or dried fish as you want.",
  str_n34_dispatch_task_5_com_13 = "Okay!",
  str_n34_dispatch_task_5_com_14 = "I'm not particularly fond of coffee.",
  str_n34_dispatch_task_5_com_15 = "May I order assorted dried fish now?",
  str_n34_dispatch_task_5_com_16 = "It seems that Chandra plays an important role, Gram.",
  str_n34_dispatch_task_5_com_17 = "Yes, Grand Marshal.",
  str_n34_dispatch_task_6_com_1 = "Grand Marshal here. What is your condition? Over.",
  str_n34_dispatch_task_6_com_2 = "Grand Marshal here. Please reply if you can hear me. Over.",
  str_n34_dispatch_task_6_com_3 = "It was so dangerous! The ice was all like mirrors.",
  str_n34_dispatch_task_6_com_4 = "Mirrors? What do you mean?",
  str_n34_dispatch_task_6_com_5 = "They would impair our sense of direction, which made the marching far more difficult than usual. Even our vision became unreliable there.",
  str_n34_dispatch_task_6_com_6 = "I am not certain what you are saying, please explain it. Over.",
  str_n34_dispatch_task_6_com_7 = "Here. Gram is reporting, Grand Marshal.",
  str_n34_dispatch_task_6_com_8 = "We've passed through a hilly area. The slope there was mild, but the terrain was unpredictable and full of ice-covered stone pillars.",
  str_n34_dispatch_task_6_com_9 = "Therefore we marched in a forest of stone pillars. Our vision was blocked by them, and our senses would also be disturbed by the light reflected on the ice. We would feel dizzy and even lose our way if we stayed there for too long.",
  str_n34_dispatch_task_6_com_10 = "If we were affected severely, we would lose our minds and sink into madness.",
  str_n34_dispatch_task_6_com_11 = "Sounds dangerous indeed... Then how could you get out of them?",
  str_n34_dispatch_task_6_com_12 = "Thanks to the advice from Benny and Curo. We assembled a device to direct us using my watch, the steel cord on Revy's weapon, and the pulley in our camping equipment.",
  str_n34_dispatch_task_6_com_13 = "The device functioned like a cane. We used it to probe the ground ahead of us, and once we got away from the previous direction, the device would indicate the angle we turned.",
  str_n34_dispatch_task_6_com_14 = "Though it wasn't very precise, it was better than nothing. As for the dazzling ice, Chandra suggested we keep our heads low in marching.",
  str_n34_dispatch_task_6_com_15 = "But what if we were assaulted by Eclipsites? We wouldn't even have the time to draw out weapons!",
  str_n34_dispatch_task_6_com_16 = "It doesn't matter. They would all be dealt with.",
  str_n34_dispatch_task_6_com_17 = "Anyway, we've come out. Now we're close to the border into the eternal night. Over.",
  str_n34_dispatch_task_6_com_18 = "Keep an eye on the team's condition and don't push yourselves too hard. Retreat if necessary. Over.",
  str_n34_dispatch_task_7_com_1 = "Chandra, Chandra! What is your condition? Over.",
  str_n34_dispatch_task_7_com_2 = "No casualties. We've returned. Over.",
  str_n34_dispatch_task_7_com_3 = "Tell me what you've seen along the way briefly. Over.",
  str_n34_dispatch_task_7_com_4 = "A pitch-black cave! With a high ceiling and vast space!",
  str_n34_dispatch_task_7_com_5 = "And wind.",
  str_n34_dispatch_task_7_com_6 = "And it may affect the light inside it. We could only see a few steps away even if we lit the best lamp.",
  str_n34_dispatch_task_7_com_7 = "The reeking air made it hard to breathe, and people would easily lose their way there.",
  str_n34_dispatch_task_7_com_8 = "I'll tell you what happened next, Grand Marshal.",
  str_n34_dispatch_task_7_com_9 = "Got your report. Over.",
  str_n34_dispatch_task_7_com_10 = "We expected them to be back in 1 hour, but they didn't even if we waited for another hour. So I went into the cave to find them. Over.",
  str_n34_dispatch_task_7_com_11 = "What supplies did you have? Over.",
  str_n34_dispatch_task_7_com_12 = "Food and water for 7 days, arms, cold-proof gear, a lamp for a whole day of lighting, climbing tools, safety ropes, and a can of fuel. Over.",
  str_n34_dispatch_task_7_com_13 = "You didn't take the directional device with you? Over.",
  str_n34_dispatch_task_7_com_14 = "The teammates in the camp would need it to direct them through the nasty stone pillars if I couldn't be back. Over.",
  str_n34_dispatch_task_7_com_15 = "You're a good captain. Go on. Over.",
  str_n34_dispatch_task_7_com_16 = "Just as we've done before, I kept my head low and focused on their footprints on the ground. I marked some blurred ones with climbing pitons, and after I ran out of them, I cut a length from my rope and dipped it in the fuel to mark the unclear footprints. Over.",
  str_n34_dispatch_task_7_com_17 = "The fuel may attract Eclipsites. A risky choice, but you've been proven right. Over.",
  str_n34_dispatch_task_7_com_18 = "We couldn't always rely on our luck, Grand Marshal. Currently, we've reached the farthest in our exploration into the eternal night. Over.",
  str_n34_dispatch_task_7_com_19 = "Come back now. Abandon some supplies if necessary. Over.",
  str_n34_dispatch_task_7_com_20 = "Yes, Grand Marshal. Over.",
  str_n34_dispatch_task_7_com_21 = "Be careful and ensure the personnel's safety first. I'll wait for you in the Twilight. Over.",
  str_n34_dispatch_task_7_com_22 = "See you there, Grand Marshal. Over."
}
return config
