return {
	Play322271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322271001
		arg_1_1.duration_ = 6.99

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.9 and arg_1_1.time_ < 2 + 0.9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "ST0512"

			if arg_1_1.bgs_.ST0512 == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.ST0512

				arg_1_1.bgs_.ST0512.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0512" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_ST0512", "")
			end

			if 2.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.63333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_slime1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 1.98843149817549
			local var_4_18 = 1.45

			if 1.98843149817549 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322271001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 58 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 58)

				if (58 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 58)) > 0 and var_4_18 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_17 = var_4_17 + 0.3

					if var_4_22 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_17 + 0.3
			local var_4_24 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322271002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322271002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322271003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322271002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 5 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 5)

				if (5 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 5)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322271003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322271003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322271004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10149ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10149ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10149ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10149ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10149ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10149ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10149ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10149ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10149ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10149ui_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.05, -5.8)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			local var_16_7 = arg_13_1.actors_["10149ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10149ui_story == nil then
				arg_13_1.var_.characterEffect10149ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect10149ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10149ui_story then
				arg_13_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				if not isNil(arg_13_1.actors_["10149ui_story"]) then
					local var_16_10 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_16_10 then
						var_16_10:EnableDynamicBone(true)
					end
				end
			end

			local var_16_11 = 0
			local var_16_12 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(322271003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 14 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 14)

				if (14 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 14)) > 0 and var_16_12 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271003", "story_v_out_322271.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_322271", "322271003", "story_v_out_322271.awb") / 1000

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_322271", "322271003", "story_v_out_322271.awb")

						arg_13_1:RecordAudio("322271003", var_16_18)
						arg_13_1:RecordAudio("322271003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322271", "322271003", "story_v_out_322271.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322271", "322271003", "story_v_out_322271.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_19 and arg_13_1.time_ < var_16_11 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play322271004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322271004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322271005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10149ui_story"]) and arg_17_1.var_.characterEffect10149ui_story == nil then
				arg_17_1.var_.characterEffect10149ui_story = arg_17_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10149ui_story"]) then
				if arg_17_1.var_.characterEffect10149ui_story and not isNil(arg_17_1.actors_["10149ui_story"]) then
					arg_17_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10149ui_story"]) and arg_17_1.var_.characterEffect10149ui_story then
				arg_17_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(322271004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 21 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 21)

				if (21 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 21)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322271005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322271005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322271006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10149ui_story = arg_21_1.actors_["10149ui_story"].transform.localPosition

				local var_24_0 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_0 then
					var_24_0:EnableDynamicBone(false)
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_1)
				arg_21_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).z)
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles = arg_21_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10149ui_story"].transform.position).z)
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10149ui_story"].transform.localEulerAngles = arg_21_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_24_2 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(true)
				end
			end

			local var_24_3 = 0
			local var_24_4 = 1.05

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(322271005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 42 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 42)

				if (42 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 42)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play322271006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322271006
		arg_25_1.duration_ = 7.97

		local var_25_0 = {
			zh = 7.766,
			ja = 7.966
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322271007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10149ui_story = arg_25_1.actors_["10149ui_story"].transform.localPosition

				local var_28_0 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_0 then
					var_28_0:EnableDynamicBone(false)
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_25_1.time_ - 0) / var_28_1)
				arg_25_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).z)
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles = arg_25_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.8)
				arg_25_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10149ui_story"].transform.position).z)
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10149ui_story"].transform.localEulerAngles = arg_25_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_28_2 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(true)
				end
			end

			local var_28_3 = arg_25_1.actors_["10149ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10149ui_story == nil then
				arg_25_1.var_.characterEffect10149ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect10149ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10149ui_story then
				arg_25_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				if not isNil(arg_25_1.actors_["10149ui_story"]) then
					local var_28_6 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_28_6 then
						var_28_6:EnableDynamicBone(true)
					end
				end
			end

			local var_28_7 = 0
			local var_28_8 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(322271006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 26 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 26)

				if (26 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 26)) > 0 and var_28_8 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271006", "story_v_out_322271.awb") ~= 0 then
					local var_28_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271006", "story_v_out_322271.awb") / 1000

					if var_28_13 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_7
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_322271", "322271006", "story_v_out_322271.awb")

						arg_25_1:RecordAudio("322271006", var_28_14)
						arg_25_1:RecordAudio("322271006", var_28_14)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322271", "322271006", "story_v_out_322271.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322271", "322271006", "story_v_out_322271.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play322271007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322271007
		arg_29_1.duration_ = 11.2

		local var_29_0 = {
			zh = 11.2,
			ja = 10.4
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322271008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(322271007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 48 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 48)

				if (48 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 48)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271007", "story_v_out_322271.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271007", "story_v_out_322271.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_322271", "322271007", "story_v_out_322271.awb")

						arg_29_1:RecordAudio("322271007", var_32_6)
						arg_29_1:RecordAudio("322271007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322271", "322271007", "story_v_out_322271.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322271", "322271007", "story_v_out_322271.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322271008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322271008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322271009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10149ui_story"]) and arg_33_1.var_.characterEffect10149ui_story == nil then
				arg_33_1.var_.characterEffect10149ui_story = arg_33_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10149ui_story"]) then
				if arg_33_1.var_.characterEffect10149ui_story and not isNil(arg_33_1.actors_["10149ui_story"]) then
					arg_33_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10149ui_story"]) and arg_33_1.var_.characterEffect10149ui_story then
				arg_33_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.7

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(322271008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 28 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 28)

				if (28 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 28)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322271009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322271009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322271010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10149ui_story"]) and arg_37_1.var_.characterEffect10149ui_story == nil then
				arg_37_1.var_.characterEffect10149ui_story = arg_37_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10149ui_story"]) then
				if arg_37_1.var_.characterEffect10149ui_story and not isNil(arg_37_1.actors_["10149ui_story"]) then
					arg_37_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10149ui_story"]) and arg_37_1.var_.characterEffect10149ui_story then
				arg_37_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				if not isNil(arg_37_1.actors_["10149ui_story"]) then
					local var_40_2 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_40_2 then
						var_40_2:EnableDynamicBone(true)
					end
				end
			end

			local var_40_3 = 0
			local var_40_4 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(322271009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 17 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 17)

				if (17 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 17)) > 0 and var_40_4 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271009", "story_v_out_322271.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271009", "story_v_out_322271.awb") / 1000

					if var_40_9 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_3
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_322271", "322271009", "story_v_out_322271.awb")

						arg_37_1:RecordAudio("322271009", var_40_10)
						arg_37_1:RecordAudio("322271009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322271", "322271009", "story_v_out_322271.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322271", "322271009", "story_v_out_322271.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_11 and arg_37_1.time_ < var_40_3 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322271010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322271010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322271011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10149ui_story"]) and arg_41_1.var_.characterEffect10149ui_story == nil then
				arg_41_1.var_.characterEffect10149ui_story = arg_41_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10149ui_story"]) then
				if arg_41_1.var_.characterEffect10149ui_story and not isNil(arg_41_1.actors_["10149ui_story"]) then
					arg_41_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10149ui_story"]) and arg_41_1.var_.characterEffect10149ui_story then
				arg_41_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.475

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(322271010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 19 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 19)

				if (19 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 19)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322271011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322271011
		arg_45_1.duration_ = 6

		local var_45_0 = {
			zh = 6,
			ja = 4.7
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322271012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10149ui_story"]) and arg_45_1.var_.characterEffect10149ui_story == nil then
				arg_45_1.var_.characterEffect10149ui_story = arg_45_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10149ui_story"]) then
				if arg_45_1.var_.characterEffect10149ui_story and not isNil(arg_45_1.actors_["10149ui_story"]) then
					arg_45_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10149ui_story"]) and arg_45_1.var_.characterEffect10149ui_story then
				arg_45_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_48_2 = 0
			local var_48_3 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(322271011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 15 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 15)

				if (15 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 15)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271011", "story_v_out_322271.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271011", "story_v_out_322271.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_322271", "322271011", "story_v_out_322271.awb")

						arg_45_1:RecordAudio("322271011", var_48_9)
						arg_45_1:RecordAudio("322271011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322271", "322271011", "story_v_out_322271.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322271", "322271011", "story_v_out_322271.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322271012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322271012
		arg_49_1.duration_ = 17.2

		local var_49_0 = {
			zh = 11.233,
			ja = 17.2
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322271013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_2")
			end

			local var_52_0 = 0
			local var_52_1 = 1.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(322271012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 46 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 46)

				if (46 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 46)) > 0 and var_52_1 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271012", "story_v_out_322271.awb") ~= 0 then
					local var_52_6 = manager.audio:GetVoiceLength("story_v_out_322271", "322271012", "story_v_out_322271.awb") / 1000

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end

					if var_52_2.prefab_name ~= "" and arg_49_1.actors_[var_52_2.prefab_name] ~= nil then
						local var_52_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_2.prefab_name].transform, "story_v_out_322271", "322271012", "story_v_out_322271.awb")

						arg_49_1:RecordAudio("322271012", var_52_7)
						arg_49_1:RecordAudio("322271012", var_52_7)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322271", "322271012", "story_v_out_322271.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322271", "322271012", "story_v_out_322271.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322271013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322271013
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"

			SetActive(arg_53_1.choicesGo_, true)

			for iter_54_0, iter_54_1 in ipairs(arg_53_1.choices_) do
				SetActive(iter_54_1.go, iter_54_0 <= 2)
			end

			arg_53_1.choices_[1].txt.text = arg_53_1:FormatText(StoryChoiceCfg[1417].name)
			arg_53_1.choices_[2].txt.text = arg_53_1:FormatText(StoryChoiceCfg[1418].name)
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322271014(arg_53_1)
			end

			if arg_55_0 == 2 then
				arg_53_0:Play322271014(arg_53_1)
			end

			arg_53_1:RecordChoiceLog(322271013, 1417, 1418)
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10149ui_story"]) and arg_53_1.var_.characterEffect10149ui_story == nil then
				arg_53_1.var_.characterEffect10149ui_story = arg_53_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10149ui_story"]) then
				if arg_53_1.var_.characterEffect10149ui_story and not isNil(arg_53_1.actors_["10149ui_story"]) then
					arg_53_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10149ui_story"]) and arg_53_1.var_.characterEffect10149ui_story then
				arg_53_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322271014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322271014
		arg_57_1.duration_ = 3.4

		local var_57_0 = {
			zh = 2.666,
			ja = 3.4
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322271015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10149ui_story"]) and arg_57_1.var_.characterEffect10149ui_story == nil then
				arg_57_1.var_.characterEffect10149ui_story = arg_57_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10149ui_story"]) then
				if arg_57_1.var_.characterEffect10149ui_story and not isNil(arg_57_1.actors_["10149ui_story"]) then
					arg_57_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10149ui_story"]) and arg_57_1.var_.characterEffect10149ui_story then
				arg_57_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_60_2 = 0
			local var_60_3 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(322271014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 14 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 14)

				if (14 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 14)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271014", "story_v_out_322271.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271014", "story_v_out_322271.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_322271", "322271014", "story_v_out_322271.awb")

						arg_57_1:RecordAudio("322271014", var_60_9)
						arg_57_1:RecordAudio("322271014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322271", "322271014", "story_v_out_322271.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322271", "322271014", "story_v_out_322271.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322271015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322271015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322271016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10149ui_story = arg_61_1.actors_["10149ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).z)
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles = arg_61_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10149ui_story"].transform.position).z)
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10149ui_story"].transform.localEulerAngles = arg_61_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["10149ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect10149ui_story == nil then
				arg_61_1.var_.characterEffect10149ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect10149ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_4)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect10149ui_story then
				arg_61_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_61_1.time_ and arg_61_1.time_ <= 0.200000002980232 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_145", "se_story_145_gear1", "")
			end

			local var_64_6 = 0
			local var_64_7 = 0.55

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(322271015).content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 22 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 22)

				if (22 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 22)) > 0 and var_64_7 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_11 and arg_61_1.time_ < var_64_6 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322271016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322271016
		arg_65_1.duration_ = 11.07

		local var_65_0 = {
			zh = 6.466,
			ja = 11.066
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322271017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10149ui_story = arg_65_1.actors_["10149ui_story"].transform.localPosition

				local var_68_0 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_0 then
					var_68_0:EnableDynamicBone(false)
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_65_1.time_ - 0) / var_68_1)
				arg_65_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).z)
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles = arg_65_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.8)
				arg_65_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10149ui_story"].transform.position).z)
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10149ui_story"].transform.localEulerAngles = arg_65_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_68_2 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(true)
				end
			end

			local var_68_3 = arg_65_1.actors_["10149ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10149ui_story == nil then
				arg_65_1.var_.characterEffect10149ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10149ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10149ui_story then
				arg_65_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				if not isNil(arg_65_1.actors_["10149ui_story"]) then
					local var_68_6 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_68_6 then
						var_68_6:EnableDynamicBone(true)
					end
				end
			end

			local var_68_7 = 0
			local var_68_8 = 0.725

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(322271016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_12 = 29 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_10) / 29)

				if (29 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_10) / 29)) > 0 and var_68_8 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_7
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271016", "story_v_out_322271.awb") ~= 0 then
					local var_68_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271016", "story_v_out_322271.awb") / 1000

					if var_68_13 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_7
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_322271", "322271016", "story_v_out_322271.awb")

						arg_65_1:RecordAudio("322271016", var_68_14)
						arg_65_1:RecordAudio("322271016", var_68_14)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322271", "322271016", "story_v_out_322271.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322271", "322271016", "story_v_out_322271.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_15 = math.max(var_68_8, arg_65_1.talkMaxDuration)

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_15 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_7) / var_68_15

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_7 + var_68_15 and arg_65_1.time_ < var_68_7 + var_68_15 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play322271017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322271017
		arg_69_1.duration_ = 12.93

		local var_69_0 = {
			zh = 7.3,
			ja = 12.933
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play322271018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.875

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(322271017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)

				if (35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271017", "story_v_out_322271.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271017", "story_v_out_322271.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_322271", "322271017", "story_v_out_322271.awb")

						arg_69_1:RecordAudio("322271017", var_72_6)
						arg_69_1:RecordAudio("322271017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322271", "322271017", "story_v_out_322271.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322271", "322271017", "story_v_out_322271.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322271018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322271018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322271019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10149ui_story"]) and arg_73_1.var_.characterEffect10149ui_story == nil then
				arg_73_1.var_.characterEffect10149ui_story = arg_73_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10149ui_story"]) then
				if arg_73_1.var_.characterEffect10149ui_story and not isNil(arg_73_1.actors_["10149ui_story"]) then
					arg_73_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10149ui_story"]) and arg_73_1.var_.characterEffect10149ui_story then
				arg_73_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(322271018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 23 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 23)

				if (23 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 23)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322271019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322271019
		arg_77_1.duration_ = 4.07

		local var_77_0 = {
			zh = 4.066,
			ja = 2.566
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play322271020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10149ui_story"]) and arg_77_1.var_.characterEffect10149ui_story == nil then
				arg_77_1.var_.characterEffect10149ui_story = arg_77_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10149ui_story"]) then
				if arg_77_1.var_.characterEffect10149ui_story and not isNil(arg_77_1.actors_["10149ui_story"]) then
					arg_77_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10149ui_story"]) and arg_77_1.var_.characterEffect10149ui_story then
				arg_77_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_1")
			end

			local var_80_2 = 0
			local var_80_3 = 0.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(322271019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 11 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 11)

				if (11 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 11)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271019", "story_v_out_322271.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271019", "story_v_out_322271.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_322271", "322271019", "story_v_out_322271.awb")

						arg_77_1:RecordAudio("322271019", var_80_9)
						arg_77_1:RecordAudio("322271019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322271", "322271019", "story_v_out_322271.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322271", "322271019", "story_v_out_322271.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322271020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322271020
		arg_81_1.duration_ = 6.7

		local var_81_0 = {
			zh = 5,
			ja = 6.7
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play322271021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.575

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(322271020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 23 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 23)

				if (23 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 23)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271020", "story_v_out_322271.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271020", "story_v_out_322271.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_322271", "322271020", "story_v_out_322271.awb")

						arg_81_1:RecordAudio("322271020", var_84_6)
						arg_81_1:RecordAudio("322271020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322271", "322271020", "story_v_out_322271.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322271", "322271020", "story_v_out_322271.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play322271021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322271021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322271022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10149ui_story"]) and arg_85_1.var_.characterEffect10149ui_story == nil then
				arg_85_1.var_.characterEffect10149ui_story = arg_85_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10149ui_story"]) then
				if arg_85_1.var_.characterEffect10149ui_story and not isNil(arg_85_1.actors_["10149ui_story"]) then
					arg_85_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10149ui_story"]) and arg_85_1.var_.characterEffect10149ui_story then
				arg_85_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(322271021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 13 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 13)

				if (13 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 13)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322271022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322271022
		arg_89_1.duration_ = 9.47

		local var_89_0 = {
			zh = 6.5,
			ja = 9.466
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322271023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10149ui_story"]) and arg_89_1.var_.characterEffect10149ui_story == nil then
				arg_89_1.var_.characterEffect10149ui_story = arg_89_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10149ui_story"]) then
				if arg_89_1.var_.characterEffect10149ui_story and not isNil(arg_89_1.actors_["10149ui_story"]) then
					arg_89_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10149ui_story"]) and arg_89_1.var_.characterEffect10149ui_story then
				arg_89_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action3_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				if not isNil(arg_89_1.actors_["10149ui_story"]) then
					local var_92_2 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_92_2 then
						var_92_2:EnableDynamicBone(true)
					end
				end
			end

			local var_92_3 = 0
			local var_92_4 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:GetWordFromCfg(322271022)
				local var_92_6 = arg_89_1:FormatText(var_92_5.content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_6) / 19)

				if (19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_6) / 19)) > 0 and var_92_4 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271022", "story_v_out_322271.awb") ~= 0 then
					local var_92_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271022", "story_v_out_322271.awb") / 1000

					if var_92_9 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_3
					end

					if var_92_5.prefab_name ~= "" and arg_89_1.actors_[var_92_5.prefab_name] ~= nil then
						local var_92_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_5.prefab_name].transform, "story_v_out_322271", "322271022", "story_v_out_322271.awb")

						arg_89_1:RecordAudio("322271022", var_92_10)
						arg_89_1:RecordAudio("322271022", var_92_10)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_322271", "322271022", "story_v_out_322271.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_322271", "322271022", "story_v_out_322271.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_11 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_11 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_11

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_11 and arg_89_1.time_ < var_92_3 + var_92_11 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322271023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322271023
		arg_93_1.duration_ = 10.67

		local var_93_0 = {
			zh = 6.5,
			ja = 10.666
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322271024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(322271023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 29 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 29)

				if (29 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 29)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271023", "story_v_out_322271.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271023", "story_v_out_322271.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_322271", "322271023", "story_v_out_322271.awb")

						arg_93_1:RecordAudio("322271023", var_96_6)
						arg_93_1:RecordAudio("322271023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322271", "322271023", "story_v_out_322271.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322271", "322271023", "story_v_out_322271.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play322271024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322271024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322271025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10149ui_story"]) and arg_97_1.var_.characterEffect10149ui_story == nil then
				arg_97_1.var_.characterEffect10149ui_story = arg_97_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10149ui_story"]) then
				if arg_97_1.var_.characterEffect10149ui_story and not isNil(arg_97_1.actors_["10149ui_story"]) then
					arg_97_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10149ui_story"]) and arg_97_1.var_.characterEffect10149ui_story then
				arg_97_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(322271024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 24 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 24)

				if (24 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 24)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322271025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322271025
		arg_101_1.duration_ = 2.2

		local var_101_0 = {
			zh = 1.366,
			ja = 2.2
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322271026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10149ui_story"]) and arg_101_1.var_.characterEffect10149ui_story == nil then
				arg_101_1.var_.characterEffect10149ui_story = arg_101_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10149ui_story"]) then
				if arg_101_1.var_.characterEffect10149ui_story and not isNil(arg_101_1.actors_["10149ui_story"]) then
					arg_101_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10149ui_story"]) and arg_101_1.var_.characterEffect10149ui_story then
				arg_101_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_104_2 = 0
			local var_104_3 = 0.125

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(322271025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 5 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 5)

				if (5 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 5)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271025", "story_v_out_322271.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271025", "story_v_out_322271.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_322271", "322271025", "story_v_out_322271.awb")

						arg_101_1:RecordAudio("322271025", var_104_9)
						arg_101_1:RecordAudio("322271025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322271", "322271025", "story_v_out_322271.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322271", "322271025", "story_v_out_322271.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322271026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322271026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322271027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10149ui_story"]) and arg_105_1.var_.characterEffect10149ui_story == nil then
				arg_105_1.var_.characterEffect10149ui_story = arg_105_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10149ui_story"]) then
				if arg_105_1.var_.characterEffect10149ui_story and not isNil(arg_105_1.actors_["10149ui_story"]) then
					arg_105_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10149ui_story"]) and arg_105_1.var_.characterEffect10149ui_story then
				arg_105_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(322271026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 16 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 16)

				if (16 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 16)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322271027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322271027
		arg_109_1.duration_ = 10.13

		local var_109_0 = {
			zh = 6.466,
			ja = 10.133
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322271028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10149ui_story"]) and arg_109_1.var_.characterEffect10149ui_story == nil then
				arg_109_1.var_.characterEffect10149ui_story = arg_109_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10149ui_story"]) then
				if arg_109_1.var_.characterEffect10149ui_story and not isNil(arg_109_1.actors_["10149ui_story"]) then
					arg_109_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10149ui_story"]) and arg_109_1.var_.characterEffect10149ui_story then
				arg_109_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				if not isNil(arg_109_1.actors_["10149ui_story"]) then
					local var_112_2 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_112_2 then
						var_112_2:EnableDynamicBone(true)
					end
				end
			end

			local var_112_3 = 0
			local var_112_4 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(322271027)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 24 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 24)

				if (24 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_6) / 24)) > 0 and var_112_4 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271027", "story_v_out_322271.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271027", "story_v_out_322271.awb") / 1000

					if var_112_9 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_3
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_322271", "322271027", "story_v_out_322271.awb")

						arg_109_1:RecordAudio("322271027", var_112_10)
						arg_109_1:RecordAudio("322271027", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322271", "322271027", "story_v_out_322271.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322271", "322271027", "story_v_out_322271.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_11 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_11 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_11

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_11 and arg_109_1.time_ < var_112_3 + var_112_11 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322271028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322271028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322271029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10149ui_story"]) and arg_113_1.var_.characterEffect10149ui_story == nil then
				arg_113_1.var_.characterEffect10149ui_story = arg_113_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10149ui_story"]) then
				if arg_113_1.var_.characterEffect10149ui_story and not isNil(arg_113_1.actors_["10149ui_story"]) then
					arg_113_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10149ui_story"]) and arg_113_1.var_.characterEffect10149ui_story then
				arg_113_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 1.325

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(322271028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 53 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 53)

				if (53 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 53)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play322271029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322271029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322271030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.8

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(322271029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 32 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 32)

				if (32 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 32)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322271030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322271030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322271031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10149ui_story"]) and arg_121_1.var_.characterEffect10149ui_story == nil then
				arg_121_1.var_.characterEffect10149ui_story = arg_121_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10149ui_story"]) then
				if arg_121_1.var_.characterEffect10149ui_story and not isNil(arg_121_1.actors_["10149ui_story"]) then
					arg_121_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10149ui_story"]) and arg_121_1.var_.characterEffect10149ui_story then
				arg_121_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action9_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				if not isNil(arg_121_1.actors_["10149ui_story"]) then
					local var_124_2 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_124_2 then
						var_124_2:EnableDynamicBone(true)
					end
				end
			end

			local var_124_3 = 0
			local var_124_4 = 0.3

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(322271030)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 12 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_6) / 12)

				if (12 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_6) / 12)) > 0 and var_124_4 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271030", "story_v_out_322271.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271030", "story_v_out_322271.awb") / 1000

					if var_124_9 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_3
					end

					if var_124_5.prefab_name ~= "" and arg_121_1.actors_[var_124_5.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_5.prefab_name].transform, "story_v_out_322271", "322271030", "story_v_out_322271.awb")

						arg_121_1:RecordAudio("322271030", var_124_10)
						arg_121_1:RecordAudio("322271030", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322271", "322271030", "story_v_out_322271.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322271", "322271030", "story_v_out_322271.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_11 and arg_121_1.time_ < var_124_3 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322271031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322271031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322271032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10149ui_story"]) and arg_125_1.var_.characterEffect10149ui_story == nil then
				arg_125_1.var_.characterEffect10149ui_story = arg_125_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10149ui_story"]) then
				if arg_125_1.var_.characterEffect10149ui_story and not isNil(arg_125_1.actors_["10149ui_story"]) then
					arg_125_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10149ui_story"]) and arg_125_1.var_.characterEffect10149ui_story then
				arg_125_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 1.05

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(322271031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 42 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 42)

				if (42 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 42)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322271032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322271032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play322271033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(322271032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 55 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 55)

				if (55 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 55)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322271033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322271033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play322271034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10149ui_story = arg_133_1.actors_["10149ui_story"].transform.localPosition

				local var_136_0 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_0 then
					var_136_0:EnableDynamicBone(false)
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_1)
				arg_133_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).z)
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles = arg_133_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10149ui_story"].transform.position).z)
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10149ui_story"].transform.localEulerAngles = arg_133_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_136_2 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(true)
				end
			end

			local var_136_3 = 0
			local var_136_4 = 1.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(322271033).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 44 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 44)

				if (44 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 44)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play322271034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322271034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322271035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.625

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(322271034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 25 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 25)

				if (25 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 25)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play322271035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322271035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play322271036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10149ui_story = arg_141_1.actors_["10149ui_story"].transform.localPosition

				local var_144_0 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_0 then
					var_144_0:EnableDynamicBone(false)
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_141_1.time_ - 0) / var_144_1)
				arg_141_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).z)
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles = arg_141_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.8)
				arg_141_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10149ui_story"].transform.position).z)
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10149ui_story"].transform.localEulerAngles = arg_141_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_144_2 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(true)
				end
			end

			local var_144_3 = arg_141_1.actors_["10149ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10149ui_story == nil then
				arg_141_1.var_.characterEffect10149ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect10149ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10149ui_story then
				arg_141_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action9_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if not isNil(arg_141_1.actors_["10149ui_story"]) then
					local var_144_6 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_144_6 then
						var_144_6:EnableDynamicBone(true)
					end
				end
			end

			local var_144_7 = 0
			local var_144_8 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(322271035)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 19 <= 0 and var_144_8 or var_144_8 * (utf8.len(var_144_10) / 19)

				if (19 <= 0 and var_144_8 or var_144_8 * (utf8.len(var_144_10) / 19)) > 0 and var_144_8 < var_144_12 then
					arg_141_1.talkMaxDuration = var_144_12

					if var_144_12 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_7
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271035", "story_v_out_322271.awb") ~= 0 then
					local var_144_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271035", "story_v_out_322271.awb") / 1000

					if var_144_13 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_7
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_322271", "322271035", "story_v_out_322271.awb")

						arg_141_1:RecordAudio("322271035", var_144_14)
						arg_141_1:RecordAudio("322271035", var_144_14)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322271", "322271035", "story_v_out_322271.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322271", "322271035", "story_v_out_322271.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_7) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_7 + var_144_15 and arg_141_1.time_ < var_144_7 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play322271036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322271036
		arg_145_1.duration_ = 12.87

		local var_145_0 = {
			zh = 9.666,
			ja = 12.866
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322271037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(322271036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 44 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 44)

				if (44 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 44)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271036", "story_v_out_322271.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271036", "story_v_out_322271.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_322271", "322271036", "story_v_out_322271.awb")

						arg_145_1:RecordAudio("322271036", var_148_6)
						arg_145_1:RecordAudio("322271036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322271", "322271036", "story_v_out_322271.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322271", "322271036", "story_v_out_322271.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play322271037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322271037
		arg_149_1.duration_ = 9.37

		local var_149_0 = {
			zh = 7.433,
			ja = 9.366
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322271038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.95

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(322271037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 38 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 38)

				if (38 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 38)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271037", "story_v_out_322271.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271037", "story_v_out_322271.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_322271", "322271037", "story_v_out_322271.awb")

						arg_149_1:RecordAudio("322271037", var_152_6)
						arg_149_1:RecordAudio("322271037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322271", "322271037", "story_v_out_322271.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322271", "322271037", "story_v_out_322271.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play322271038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322271038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322271039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10149ui_story"]) and arg_153_1.var_.characterEffect10149ui_story == nil then
				arg_153_1.var_.characterEffect10149ui_story = arg_153_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10149ui_story"]) then
				if arg_153_1.var_.characterEffect10149ui_story and not isNil(arg_153_1.actors_["10149ui_story"]) then
					arg_153_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10149ui_story"]) and arg_153_1.var_.characterEffect10149ui_story then
				arg_153_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(322271038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 13 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 13)

				if (13 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 13)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322271039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322271039
		arg_157_1.duration_ = 6.2

		local var_157_0 = {
			zh = 6.2,
			ja = 5.233
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322271040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10149ui_story"]) and arg_157_1.var_.characterEffect10149ui_story == nil then
				arg_157_1.var_.characterEffect10149ui_story = arg_157_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10149ui_story"]) then
				if arg_157_1.var_.characterEffect10149ui_story and not isNil(arg_157_1.actors_["10149ui_story"]) then
					arg_157_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10149ui_story"]) and arg_157_1.var_.characterEffect10149ui_story then
				arg_157_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_160_2 = 0
			local var_160_3 = 0.55

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(322271039)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 22 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 22)

				if (22 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 22)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271039", "story_v_out_322271.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271039", "story_v_out_322271.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_out_322271", "322271039", "story_v_out_322271.awb")

						arg_157_1:RecordAudio("322271039", var_160_9)
						arg_157_1:RecordAudio("322271039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322271", "322271039", "story_v_out_322271.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322271", "322271039", "story_v_out_322271.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play322271040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322271040
		arg_161_1.duration_ = 12.93

		local var_161_0 = {
			zh = 7.966,
			ja = 12.933
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322271041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.025

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(322271040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 41 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 41)

				if (41 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 41)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271040", "story_v_out_322271.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271040", "story_v_out_322271.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_322271", "322271040", "story_v_out_322271.awb")

						arg_161_1:RecordAudio("322271040", var_164_6)
						arg_161_1:RecordAudio("322271040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322271", "322271040", "story_v_out_322271.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322271", "322271040", "story_v_out_322271.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play322271041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322271041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322271042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10149ui_story"]) and arg_165_1.var_.characterEffect10149ui_story == nil then
				arg_165_1.var_.characterEffect10149ui_story = arg_165_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10149ui_story"]) then
				if arg_165_1.var_.characterEffect10149ui_story and not isNil(arg_165_1.actors_["10149ui_story"]) then
					arg_165_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10149ui_story"]) and arg_165_1.var_.characterEffect10149ui_story then
				arg_165_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.35

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(322271041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 14 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 14)

				if (14 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 14)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play322271042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322271042
		arg_169_1.duration_ = 5.57

		local var_169_0 = {
			zh = 5.266,
			ja = 5.566
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play322271043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10149ui_story"]) and arg_169_1.var_.characterEffect10149ui_story == nil then
				arg_169_1.var_.characterEffect10149ui_story = arg_169_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10149ui_story"]) then
				if arg_169_1.var_.characterEffect10149ui_story and not isNil(arg_169_1.actors_["10149ui_story"]) then
					arg_169_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10149ui_story"]) and arg_169_1.var_.characterEffect10149ui_story then
				arg_169_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				if not isNil(arg_169_1.actors_["10149ui_story"]) then
					local var_172_2 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_172_2 then
						var_172_2:EnableDynamicBone(true)
					end
				end
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_1")
			end

			local var_172_3 = 0
			local var_172_4 = 0.625

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(322271042)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_8 = 25 <= 0 and var_172_4 or var_172_4 * (utf8.len(var_172_6) / 25)

				if (25 <= 0 and var_172_4 or var_172_4 * (utf8.len(var_172_6) / 25)) > 0 and var_172_4 < var_172_8 then
					arg_169_1.talkMaxDuration = var_172_8

					if var_172_8 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_3
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271042", "story_v_out_322271.awb") ~= 0 then
					local var_172_9 = manager.audio:GetVoiceLength("story_v_out_322271", "322271042", "story_v_out_322271.awb") / 1000

					if var_172_9 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_3
					end

					if var_172_5.prefab_name ~= "" and arg_169_1.actors_[var_172_5.prefab_name] ~= nil then
						local var_172_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_5.prefab_name].transform, "story_v_out_322271", "322271042", "story_v_out_322271.awb")

						arg_169_1:RecordAudio("322271042", var_172_10)
						arg_169_1:RecordAudio("322271042", var_172_10)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322271", "322271042", "story_v_out_322271.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322271", "322271042", "story_v_out_322271.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_11 = math.max(var_172_4, arg_169_1.talkMaxDuration)

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_11 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_3) / var_172_11

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_3 + var_172_11 and arg_169_1.time_ < var_172_3 + var_172_11 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play322271043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322271043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play322271044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10149ui_story = arg_173_1.actors_["10149ui_story"].transform.localPosition

				local var_176_0 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_0 then
					var_176_0:EnableDynamicBone(false)
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_1)
				arg_173_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).z)
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles = arg_173_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10149ui_story"].transform.position).z)
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10149ui_story"].transform.localEulerAngles = arg_173_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_176_2 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(true)
				end
			end

			if 0.55 < arg_173_1.time_ and arg_173_1.time_ <= 0.55 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_145", "se_story_145_gear2", "")
			end

			local var_176_4 = 0
			local var_176_5 = 1.55

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(322271043).content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_8 = 62 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 62)

				if (62 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 62)) > 0 and var_176_5 < var_176_8 then
					arg_173_1.talkMaxDuration = var_176_8

					if var_176_8 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_9 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_9 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_9

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_9 and arg_173_1.time_ < var_176_4 + var_176_9 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play322271044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322271044
		arg_177_1.duration_ = 11.57

		local var_177_0 = {
			zh = 5.733,
			ja = 11.566
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322271045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10149ui_story = arg_177_1.actors_["10149ui_story"].transform.localPosition

				local var_180_0 = GameObjectTools.GetOrAddComponent(arg_177_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_180_0 then
					var_180_0:EnableDynamicBone(false)
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_177_1.time_ - 0) / var_180_1)
				arg_177_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).z)
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles = arg_177_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.8)
				arg_177_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10149ui_story"].transform.position).z)
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10149ui_story"].transform.localEulerAngles = arg_177_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_180_2 = GameObjectTools.GetOrAddComponent(arg_177_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(true)
				end
			end

			local var_180_3 = arg_177_1.actors_["10149ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect10149ui_story == nil then
				arg_177_1.var_.characterEffect10149ui_story = var_180_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.characterEffect10149ui_story and not isNil(var_180_3) then
					arg_177_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect10149ui_story then
				arg_177_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action4_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				if not isNil(arg_177_1.actors_["10149ui_story"]) then
					local var_180_6 = GameObjectTools.GetOrAddComponent(arg_177_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_180_6 then
						var_180_6:EnableDynamicBone(true)
					end
				end
			end

			local var_180_7 = 0
			local var_180_8 = 0.625

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(322271044)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 25 <= 0 and var_180_8 or var_180_8 * (utf8.len(var_180_10) / 25)

				if (25 <= 0 and var_180_8 or var_180_8 * (utf8.len(var_180_10) / 25)) > 0 and var_180_8 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271044", "story_v_out_322271.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271044", "story_v_out_322271.awb") / 1000

					if var_180_13 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_7
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_out_322271", "322271044", "story_v_out_322271.awb")

						arg_177_1:RecordAudio("322271044", var_180_14)
						arg_177_1:RecordAudio("322271044", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322271", "322271044", "story_v_out_322271.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322271", "322271044", "story_v_out_322271.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_15 and arg_177_1.time_ < var_180_7 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play322271045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322271045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322271046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10149ui_story"]) and arg_181_1.var_.characterEffect10149ui_story == nil then
				arg_181_1.var_.characterEffect10149ui_story = arg_181_1.actors_["10149ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10149ui_story"]) then
				if arg_181_1.var_.characterEffect10149ui_story and not isNil(arg_181_1.actors_["10149ui_story"]) then
					arg_181_1.var_.characterEffect10149ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10149ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10149ui_story"]) and arg_181_1.var_.characterEffect10149ui_story then
				arg_181_1.var_.characterEffect10149ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10149ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.275

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(322271045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 11 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 11)

				if (11 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 11)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322271046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322271046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322271047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10149ui_story = arg_185_1.actors_["10149ui_story"].transform.localPosition

				local var_188_0 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_0 then
					var_188_0:EnableDynamicBone(false)
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_1)
				arg_185_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).z)
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles = arg_185_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10149ui_story"].transform.position).z)
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10149ui_story"].transform.localEulerAngles = arg_185_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_188_2 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(true)
				end
			end

			local var_188_3 = 0
			local var_188_4 = 1.525

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_5 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(322271046).content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 61 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 61)

				if (61 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 61)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_8 and arg_185_1.time_ < var_188_3 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play322271047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322271047
		arg_189_1.duration_ = 5

		local var_189_0 = {
			zh = 4.999999999999,
			ja = 5
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play322271048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10149ui_story = arg_189_1.actors_["10149ui_story"].transform.localPosition

				local var_192_0 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_0 then
					var_192_0:EnableDynamicBone(false)
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10149ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10149ui_story, Vector3.New(0, -1.05, -5.8), (arg_189_1.time_ - 0) / var_192_1)
				arg_189_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).z)
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles = arg_189_1.actors_["10149ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10149ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.8)
				arg_189_1.actors_["10149ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10149ui_story"].transform.position).z)
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10149ui_story"].transform.localEulerAngles = arg_189_1.actors_["10149ui_story"].transform.localEulerAngles

				local var_192_2 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10149ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(true)
				end
			end

			local var_192_3 = arg_189_1.actors_["10149ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect10149ui_story == nil then
				arg_189_1.var_.characterEffect10149ui_story = var_192_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_4 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 and not isNil(var_192_3) then
				if arg_189_1.var_.characterEffect10149ui_story and not isNil(var_192_3) then
					arg_189_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect10149ui_story then
				arg_189_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				if not isNil(arg_189_1.actors_["10149ui_story"]) then
					local var_192_6 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10149ui_story"], typeof(DynamicBoneHelper))

					if var_192_6 then
						var_192_6:EnableDynamicBone(true)
					end
				end
			end

			local var_192_7 = 0
			local var_192_8 = 0.375

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:GetWordFromCfg(322271047)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 15 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 15)

				if (15 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 15)) > 0 and var_192_8 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271047", "story_v_out_322271.awb") ~= 0 then
					local var_192_13 = manager.audio:GetVoiceLength("story_v_out_322271", "322271047", "story_v_out_322271.awb") / 1000

					if var_192_13 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_7
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_out_322271", "322271047", "story_v_out_322271.awb")

						arg_189_1:RecordAudio("322271047", var_192_14)
						arg_189_1:RecordAudio("322271047", var_192_14)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322271", "322271047", "story_v_out_322271.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322271", "322271047", "story_v_out_322271.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_15 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_15 and arg_189_1.time_ < var_192_7 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play322271048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322271048
		arg_193_1.duration_ = 5.4

		local var_193_0 = {
			zh = 3.466,
			ja = 5.4
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322271049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(322271048)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 11)

				if (11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 11)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271048", "story_v_out_322271.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271048", "story_v_out_322271.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_322271", "322271048", "story_v_out_322271.awb")

						arg_193_1:RecordAudio("322271048", var_196_6)
						arg_193_1:RecordAudio("322271048", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322271", "322271048", "story_v_out_322271.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322271", "322271048", "story_v_out_322271.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322271049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322271049
		arg_197_1.duration_ = 9

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322271050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if arg_197_1.bgs_.H02 == nil then
				local var_200_0 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_200_0.name = "H02"
				var_200_0.transform.parent = arg_197_1.stage_.transform
				var_200_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_.H02 = var_200_0
			end

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= 2 + arg_200_0 then
				local var_200_1 = arg_197_1.bgs_.H02

				arg_197_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_2 = var_200_1:GetComponent("SpriteRenderer")

				if var_200_2 and var_200_2.sprite then
					local var_200_3 = 2 * (var_200_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_1.transform.localScale = Vector3.New(var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, var_200_3 / var_200_2.sprite.bounds.size.y < var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x and var_200_3 * manager.ui.mainCameraCom_.aspect / var_200_2.sprite.bounds.size.x or var_200_3 / var_200_2.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "H02" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_4 = 4

			if 4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			if arg_197_1.time_ >= var_200_4 + 1.06666666666667 and arg_197_1.time_ < var_200_4 + 1.06666666666667 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_5 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_6 = 2

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_6 then
				local var_200_7 = Color.New(0, 0, 0)

				var_200_7.a = Mathf.Lerp(0, 1, (arg_197_1.time_ - var_200_5) / var_200_6)
				arg_197_1.mask_.color = var_200_7
			end

			if arg_197_1.time_ >= var_200_5 + var_200_6 and arg_197_1.time_ < var_200_5 + var_200_6 + arg_200_0 then
				local var_200_8 = Color.New(0, 0, 0)

				var_200_8.a = 1
				arg_197_1.mask_.color = var_200_8
			end

			local var_200_9 = 2

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_10 = 2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 then
				local var_200_11 = Color.New(0, 0, 0)

				var_200_11.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_9) / var_200_10)
				arg_197_1.mask_.color = var_200_11
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 then
				local var_200_12 = Color.New(0, 0, 0)

				arg_197_1.mask_.enabled = false
				var_200_12.a = 0
				arg_197_1.mask_.color = var_200_12
			end

			local var_200_13 = arg_197_1.actors_["10149ui_story"].transform

			if 2 < arg_197_1.time_ and arg_197_1.time_ <= 2 + arg_200_0 then
				arg_197_1.var_.moveOldPos10149ui_story = var_200_13.localPosition

				local var_200_14 = GameObjectTools.GetOrAddComponent(var_200_13.gameObject, typeof(DynamicBoneHelper))

				if var_200_14 then
					var_200_14:EnableDynamicBone(false)
				end
			end

			local var_200_15 = 0.001

			if 2 <= arg_197_1.time_ and arg_197_1.time_ < 2 + var_200_15 then
				var_200_13.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 2) / var_200_15)
				var_200_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_13.position).x, (manager.ui.mainCamera.transform.position - var_200_13.position).y, (manager.ui.mainCamera.transform.position - var_200_13.position).z)
				var_200_13.localEulerAngles.z = 0
				var_200_13.localEulerAngles.x = 0
				var_200_13.localEulerAngles = var_200_13.localEulerAngles
			end

			if arg_197_1.time_ >= 2 + var_200_15 and arg_197_1.time_ < 2 + var_200_15 + arg_200_0 then
				var_200_13.localPosition = Vector3.New(0, 100, 0)
				var_200_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_13.position).x, (manager.ui.mainCamera.transform.position - var_200_13.position).y, (manager.ui.mainCamera.transform.position - var_200_13.position).z)
				var_200_13.localEulerAngles.z = 0
				var_200_13.localEulerAngles.x = 0
				var_200_13.localEulerAngles = var_200_13.localEulerAngles

				local var_200_16 = GameObjectTools.GetOrAddComponent(var_200_13.gameObject, typeof(DynamicBoneHelper))

				if var_200_16 then
					var_200_16:EnableDynamicBone(true)
				end
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_200_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_19 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_19

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_19
						arg_197_1.bgmTxt2_.text = var_200_19
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_197_1.time_ and arg_197_1.time_ <= 0.500666666666667 + arg_200_0 then
				arg_197_1:AudioAction("play", "music", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first.awb")

				local var_200_22 = manager.audio:GetAudioName("bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first")

				if "" ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_22 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_22

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_22
						arg_197_1.bgmTxt2_.text = var_200_22
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_197_1.time_ and arg_197_1.time_ <= 1.63333333333333 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0.1 < arg_197_1.time_ and arg_197_1.time_ <= 0.1 + arg_200_0 then
				arg_197_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_ST0512", "")
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_25 = 4
			local var_200_26 = 1.15

			if 4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_27 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_27:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_197_1.dialogCg_.alpha = arg_203_0
				end))
				var_200_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_28 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(322271049).content)

				arg_197_1.text_.text = var_200_28

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_30 = 46 <= 0 and var_200_26 or var_200_26 * (utf8.len(var_200_28) / 46)

				if (46 <= 0 and var_200_26 or var_200_26 * (utf8.len(var_200_28) / 46)) > 0 and var_200_26 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30
					var_200_25 = var_200_25 + 0.3

					if var_200_30 + var_200_25 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_25
					end
				end

				arg_197_1.text_.text = var_200_28
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_31 = var_200_25 + 0.3
			local var_200_32 = math.max(var_200_26, arg_197_1.talkMaxDuration)

			if var_200_25 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_31 + var_200_32 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_31) / var_200_32

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_31 + var_200_32 and arg_197_1.time_ < var_200_31 + var_200_32 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322271050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322271050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322271051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.525

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(322271050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 21 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 21)

				if (21 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 21)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322271051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322271051
		arg_209_1.duration_ = 2

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322271052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_212_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_209_1.stage_.transform)

				var_212_0.name = "1020ui_story"
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1020ui_story"] = var_212_0

				local var_212_1 = var_212_0:GetComponentInChildren(typeof(CharacterEffect))

				var_212_1.enabled = true

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end

				arg_209_1:ShowWeapon(var_212_1.transform, false)

				arg_209_1.var_["1020ui_story" .. "Animator"] = var_212_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_209_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_209_1.var_["1020ui_story" .. "LipSync"] = var_212_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_212_3 = arg_209_1.actors_["1020ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1020ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			local var_212_5 = arg_209_1.actors_["1020ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1020ui_story == nil then
				arg_209_1.var_.characterEffect1020ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.characterEffect1020ui_story and not isNil(var_212_5) then
					arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1020ui_story then
				arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_212_8 = 0
			local var_212_9 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(322271051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 6 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 6)

				if (6 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 6)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271051", "story_v_out_322271.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_322271", "322271051", "story_v_out_322271.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_322271", "322271051", "story_v_out_322271.awb")

						arg_209_1:RecordAudio("322271051", var_212_15)
						arg_209_1:RecordAudio("322271051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322271", "322271051", "story_v_out_322271.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322271", "322271051", "story_v_out_322271.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322271052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322271052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322271053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1020ui_story"]) and arg_213_1.var_.characterEffect1020ui_story == nil then
				arg_213_1.var_.characterEffect1020ui_story = arg_213_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1020ui_story"]) then
				if arg_213_1.var_.characterEffect1020ui_story and not isNil(arg_213_1.actors_["1020ui_story"]) then
					arg_213_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1020ui_story"]) and arg_213_1.var_.characterEffect1020ui_story then
				arg_213_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(322271052).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 2 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 2)

				if (2 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 2)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322271053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322271053
		arg_217_1.duration_ = 5.13

		local var_217_0 = {
			zh = 4.566,
			ja = 5.133
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322271054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) and arg_217_1.var_.characterEffect1020ui_story == nil then
				arg_217_1.var_.characterEffect1020ui_story = arg_217_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) then
				if arg_217_1.var_.characterEffect1020ui_story and not isNil(arg_217_1.actors_["1020ui_story"]) then
					arg_217_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) and arg_217_1.var_.characterEffect1020ui_story then
				arg_217_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_220_2 = 0
			local var_220_3 = 0.45

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(322271053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 18 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 18)

				if (18 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 18)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271053", "story_v_out_322271.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271053", "story_v_out_322271.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_322271", "322271053", "story_v_out_322271.awb")

						arg_217_1:RecordAudio("322271053", var_220_9)
						arg_217_1:RecordAudio("322271053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322271", "322271053", "story_v_out_322271.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322271", "322271053", "story_v_out_322271.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play322271054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322271054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322271055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = arg_221_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) then
				if arg_221_1.var_.characterEffect1020ui_story and not isNil(arg_221_1.actors_["1020ui_story"]) then
					arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) and arg_221_1.var_.characterEffect1020ui_story then
				arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.9

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(322271054).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 36 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 36)

				if (36 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 36)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322271055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322271055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322271056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.575

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(322271055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 23 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 23)

				if (23 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 23)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play322271056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322271056
		arg_229_1.duration_ = 5.57

		local var_229_0 = {
			zh = 3.4,
			ja = 5.566
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play322271057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) and arg_229_1.var_.characterEffect1020ui_story == nil then
				arg_229_1.var_.characterEffect1020ui_story = arg_229_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) then
				if arg_229_1.var_.characterEffect1020ui_story and not isNil(arg_229_1.actors_["1020ui_story"]) then
					arg_229_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) and arg_229_1.var_.characterEffect1020ui_story then
				arg_229_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_232_2 = 0
			local var_232_3 = 0.375

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(322271056)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 15 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 15)

				if (15 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 15)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271056", "story_v_out_322271.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271056", "story_v_out_322271.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_out_322271", "322271056", "story_v_out_322271.awb")

						arg_229_1:RecordAudio("322271056", var_232_9)
						arg_229_1:RecordAudio("322271056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322271", "322271056", "story_v_out_322271.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322271", "322271056", "story_v_out_322271.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play322271057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322271057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322271058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1020ui_story"]) and arg_233_1.var_.characterEffect1020ui_story == nil then
				arg_233_1.var_.characterEffect1020ui_story = arg_233_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1020ui_story"]) then
				if arg_233_1.var_.characterEffect1020ui_story and not isNil(arg_233_1.actors_["1020ui_story"]) then
					arg_233_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1020ui_story"]) and arg_233_1.var_.characterEffect1020ui_story then
				arg_233_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.7

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(322271057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 28 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 28)

				if (28 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 28)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play322271058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322271058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322271059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.65

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(322271058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 26 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 26)

				if (26 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 26)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play322271059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322271059
		arg_241_1.duration_ = 4.5

		local var_241_0 = {
			zh = 2.4,
			ja = 4.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322271060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1020ui_story = arg_241_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).z)
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles = arg_241_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_241_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).z)
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles = arg_241_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1020ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1020ui_story == nil then
				arg_241_1.var_.characterEffect1020ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1020ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1020ui_story then
				arg_241_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_244_4 = 0
			local var_244_5 = 0.2

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(322271059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 8 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 8)

				if (8 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 8)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271059", "story_v_out_322271.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_322271", "322271059", "story_v_out_322271.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_322271", "322271059", "story_v_out_322271.awb")

						arg_241_1:RecordAudio("322271059", var_244_11)
						arg_241_1:RecordAudio("322271059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322271", "322271059", "story_v_out_322271.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322271", "322271059", "story_v_out_322271.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play322271060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322271060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322271061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = arg_245_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).z)
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles = arg_245_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1020ui_story"].transform.position).z)
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1020ui_story"].transform.localEulerAngles = arg_245_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0.6 < arg_245_1.time_ and arg_245_1.time_ <= 0.6 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_145", "se_story_145_cloth_sand", "")
			end

			local var_248_2 = manager.ui.mainCamera.transform

			if 0.6 < arg_245_1.time_ and arg_245_1.time_ <= 0.6 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_2.localPosition
			end

			local var_248_3 = 0.233333333333333

			if 0.6 <= arg_245_1.time_ and arg_245_1.time_ < 0.6 + var_248_3 then
				local var_248_4, var_248_5 = math.modf((arg_245_1.time_ - 0.6) / 0.132)

				var_248_2.localPosition = Vector3.New(var_248_5 * 0.13, var_248_5 * 0.13, var_248_5 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= 0.6 + var_248_3 and arg_245_1.time_ < 0.6 + var_248_3 + arg_248_0 then
				var_248_2.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_6 = manager.ui.mainCamera.transform

			if 0.933333333333333 < arg_245_1.time_ and arg_245_1.time_ <= 0.933333333333333 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_6.localPosition
			end

			local var_248_7 = 0.2

			if 0.933333333333333 <= arg_245_1.time_ and arg_245_1.time_ < 0.933333333333333 + var_248_7 then
				local var_248_8, var_248_9 = math.modf((arg_245_1.time_ - 0.933333333333333) / 0.132)

				var_248_6.localPosition = Vector3.New(var_248_9 * 0.13, var_248_9 * 0.13, var_248_9 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= 0.933333333333333 + var_248_7 and arg_245_1.time_ < 0.933333333333333 + var_248_7 + arg_248_0 then
				var_248_6.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_10 = manager.ui.mainCamera.transform

			if 1.23333333333333 < arg_245_1.time_ and arg_245_1.time_ <= 1.23333333333333 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_10.localPosition
			end

			local var_248_11 = 0.233333333333333

			if 1.23333333333333 <= arg_245_1.time_ and arg_245_1.time_ < 1.23333333333333 + var_248_11 then
				local var_248_12, var_248_13 = math.modf((arg_245_1.time_ - 1.23333333333333) / 0.132)

				var_248_10.localPosition = Vector3.New(var_248_13 * 0.13, var_248_13 * 0.13, var_248_13 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= 1.23333333333333 + var_248_11 and arg_245_1.time_ < 1.23333333333333 + var_248_11 + arg_248_0 then
				var_248_10.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_14 = 0
			local var_248_15 = 1.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_16 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(322271060).content)

				arg_245_1.text_.text = var_248_16

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_18 = 43 <= 0 and var_248_15 or var_248_15 * (utf8.len(var_248_16) / 43)

				if (43 <= 0 and var_248_15 or var_248_15 * (utf8.len(var_248_16) / 43)) > 0 and var_248_15 < var_248_18 then
					arg_245_1.talkMaxDuration = var_248_18

					if var_248_18 + var_248_14 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_14
					end
				end

				arg_245_1.text_.text = var_248_16
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_19 = math.max(var_248_15, arg_245_1.talkMaxDuration)

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_19 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_14) / var_248_19

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_14 + var_248_19 and arg_245_1.time_ < var_248_14 + var_248_19 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322271061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322271061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322271062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(322271061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 16 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 16)

				if (16 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 16)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322271062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322271062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322271063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.2

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(322271062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 8 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 8)

				if (8 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 8)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play322271063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322271063
		arg_257_1.duration_ = 4.97

		local var_257_0 = {
			zh = 2.8,
			ja = 4.966
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322271064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1020ui_story = arg_257_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1020ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1020ui_story == nil then
				arg_257_1.var_.characterEffect1020ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1020ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1020ui_story then
				arg_257_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_4 = 0
			local var_260_5 = 0.35

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(322271063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 14 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 14)

				if (14 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 14)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271063", "story_v_out_322271.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_322271", "322271063", "story_v_out_322271.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_322271", "322271063", "story_v_out_322271.awb")

						arg_257_1:RecordAudio("322271063", var_260_11)
						arg_257_1:RecordAudio("322271063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322271", "322271063", "story_v_out_322271.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322271", "322271063", "story_v_out_322271.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322271064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322271064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322271065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1020ui_story"]) and arg_261_1.var_.characterEffect1020ui_story == nil then
				arg_261_1.var_.characterEffect1020ui_story = arg_261_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1020ui_story"]) then
				if arg_261_1.var_.characterEffect1020ui_story and not isNil(arg_261_1.actors_["1020ui_story"]) then
					arg_261_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1020ui_story"]) and arg_261_1.var_.characterEffect1020ui_story then
				arg_261_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.525

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(322271064).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 21 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 21)

				if (21 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 21)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322271065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322271065
		arg_265_1.duration_ = 11.23

		local var_265_0 = {
			zh = 7.5,
			ja = 11.233
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322271066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story == nil then
				arg_265_1.var_.characterEffect1020ui_story = arg_265_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) then
				if arg_265_1.var_.characterEffect1020ui_story and not isNil(arg_265_1.actors_["1020ui_story"]) then
					arg_265_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story then
				arg_265_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_268_2 = 0
			local var_268_3 = 0.925

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(322271065)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 37 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 37)

				if (37 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 37)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271065", "story_v_out_322271.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271065", "story_v_out_322271.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_322271", "322271065", "story_v_out_322271.awb")

						arg_265_1:RecordAudio("322271065", var_268_9)
						arg_265_1:RecordAudio("322271065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322271", "322271065", "story_v_out_322271.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322271", "322271065", "story_v_out_322271.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322271066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322271066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322271067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story == nil then
				arg_269_1.var_.characterEffect1020ui_story = arg_269_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) then
				if arg_269_1.var_.characterEffect1020ui_story and not isNil(arg_269_1.actors_["1020ui_story"]) then
					arg_269_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story then
				arg_269_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.95

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(322271066).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 38 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 38)

				if (38 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 38)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322271067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322271067
		arg_273_1.duration_ = 4.37

		local var_273_0 = {
			zh = 2.933,
			ja = 4.366
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322271068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1020ui_story"]) and arg_273_1.var_.characterEffect1020ui_story == nil then
				arg_273_1.var_.characterEffect1020ui_story = arg_273_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1020ui_story"]) then
				if arg_273_1.var_.characterEffect1020ui_story and not isNil(arg_273_1.actors_["1020ui_story"]) then
					arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1020ui_story"]) and arg_273_1.var_.characterEffect1020ui_story then
				arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_276_2 = 0
			local var_276_3 = 0.35

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(322271067)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 14 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 14)

				if (14 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 14)) > 0 and var_276_3 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271067", "story_v_out_322271.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271067", "story_v_out_322271.awb") / 1000

					if var_276_8 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_2
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_out_322271", "322271067", "story_v_out_322271.awb")

						arg_273_1:RecordAudio("322271067", var_276_9)
						arg_273_1:RecordAudio("322271067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322271", "322271067", "story_v_out_322271.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322271", "322271067", "story_v_out_322271.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_10 and arg_273_1.time_ < var_276_2 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322271068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322271068
		arg_277_1.duration_ = 5.53

		local var_277_0 = {
			zh = 1.733,
			ja = 5.533
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322271069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.225

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(322271068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 9 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 9)

				if (9 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 9)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271068", "story_v_out_322271.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_322271", "322271068", "story_v_out_322271.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_322271", "322271068", "story_v_out_322271.awb")

						arg_277_1:RecordAudio("322271068", var_280_6)
						arg_277_1:RecordAudio("322271068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322271", "322271068", "story_v_out_322271.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322271", "322271068", "story_v_out_322271.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322271069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322271069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322271070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) and arg_281_1.var_.characterEffect1020ui_story == nil then
				arg_281_1.var_.characterEffect1020ui_story = arg_281_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) then
				if arg_281_1.var_.characterEffect1020ui_story and not isNil(arg_281_1.actors_["1020ui_story"]) then
					arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) and arg_281_1.var_.characterEffect1020ui_story then
				arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 0.675

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(322271069).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 27 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 27)

				if (27 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 27)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322271070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322271070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322271071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 1.2

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(322271070).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 48 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 48)

				if (48 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 48)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322271071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322271071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322271072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(322271071).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)

				if (42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322271072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322271072
		arg_293_1.duration_ = 16.5

		local var_293_0 = {
			zh = 9.466,
			ja = 16.5
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322271073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = arg_293_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) then
				if arg_293_1.var_.characterEffect1020ui_story and not isNil(arg_293_1.actors_["1020ui_story"]) then
					arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story then
				arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_296_2 = 0
			local var_296_3 = 1.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(322271072)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 45 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 45)

				if (45 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 45)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322271", "322271072", "story_v_out_322271.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_322271", "322271072", "story_v_out_322271.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_322271", "322271072", "story_v_out_322271.awb")

						arg_293_1:RecordAudio("322271072", var_296_9)
						arg_293_1:RecordAudio("322271072", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322271", "322271072", "story_v_out_322271.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322271", "322271072", "story_v_out_322271.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322271073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322271073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322271074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1020ui_story = arg_297_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).z)
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles = arg_297_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).z)
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles = arg_297_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_300_1 = 0
			local var_300_2 = 0.9

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(322271073).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 36 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 36)

				if (36 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 36)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322271074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322271074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
			arg_301_1.auto_ = false
		end

		function arg_301_1.playNext_(arg_303_0)
			arg_301_1.onStoryFinished_()
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.5

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(322271074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 20)

				if (20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 20)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0512",
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_322271.awb"
	}
}
