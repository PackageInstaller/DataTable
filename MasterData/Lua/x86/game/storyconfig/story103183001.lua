return {
	Play318301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318301001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.75

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318301001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 30 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 30)

				if (30 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 30)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318301002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318301002
		arg_9_1.duration_ = 5.7

		local var_9_0 = {
			zh = 4.066666666666,
			ja = 5.7
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318301003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.bgs_.K11g == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11g")
				var_12_0.name = "K11g"
				var_12_0.transform.parent = arg_9_1.stage_.transform
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_.K11g = var_12_0
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_1 = arg_9_1.bgs_.K11g

				arg_9_1.bgs_.K11g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_2 = var_12_1:GetComponent("SpriteRenderer")

				if var_12_2 and var_12_2.sprite then
					local var_12_3 = 2 * (var_12_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_1.transform.localScale = Vector3.New(var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "K11g" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_4 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_5 = 2

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_5 then
				local var_12_6 = Color.New(0, 0, 0)

				var_12_6.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_4) / var_12_5)
				arg_9_1.mask_.color = var_12_6
			end

			if arg_9_1.time_ >= var_12_4 + var_12_5 and arg_9_1.time_ < var_12_4 + var_12_5 + arg_12_0 then
				local var_12_7 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_7.a = 0
				arg_9_1.mask_.color = var_12_7
			end

			local var_12_8 = "1049ui_story"

			if arg_9_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_12_9 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_9_1.stage_.transform)

				var_12_9.name = var_12_8
				var_12_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_8] = var_12_9

				local var_12_10 = var_12_9:GetComponentInChildren(typeof(CharacterEffect))

				var_12_10.enabled = true

				local var_12_11 = GameObjectTools.GetOrAddComponent(var_12_9, typeof(DynamicBoneHelper))

				if var_12_11 then
					var_12_11:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_10.transform, false)

				arg_9_1.var_[var_12_8 .. "Animator"] = var_12_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_8 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_8 .. "LipSync"] = var_12_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_12 = arg_9_1.actors_["1049ui_story"].transform

			if 1.8 < arg_9_1.time_ and arg_9_1.time_ <= 1.8 + arg_12_0 then
				arg_9_1.var_.moveOldPos1049ui_story = var_12_12.localPosition
			end

			local var_12_13 = 0.001

			if 1.8 <= arg_9_1.time_ and arg_9_1.time_ < 1.8 + var_12_13 then
				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_9_1.time_ - 1.8) / var_12_13)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			if arg_9_1.time_ >= 1.8 + var_12_13 and arg_9_1.time_ < 1.8 + var_12_13 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(0, -1.2, -6)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			local var_12_14 = arg_9_1.actors_["1049ui_story"]

			if 1.8 < arg_9_1.time_ and arg_9_1.time_ <= 1.8 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_15 = 0.200000002980232

			if 1.8 <= arg_9_1.time_ and arg_9_1.time_ < 1.8 + var_12_15 and not isNil(var_12_14) then
				if arg_9_1.var_.characterEffect1049ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 1.8 + var_12_15 and arg_9_1.time_ < 1.8 + var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 1.8 < arg_9_1.time_ and arg_9_1.time_ <= 1.8 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 1.8 < arg_9_1.time_ and arg_9_1.time_ <= 1.8 + arg_12_0 then
				arg_9_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_17 = 2
			local var_12_18 = 0.25

			if 2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_19 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_19:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_20 = arg_9_1:GetWordFromCfg(318301002)
				local var_12_21 = arg_9_1:FormatText(var_12_20.content)

				arg_9_1.text_.text = var_12_21

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_23 = 10 <= 0 and var_12_18 or var_12_18 * (utf8.len(var_12_21) / 10)

				if (10 <= 0 and var_12_18 or var_12_18 * (utf8.len(var_12_21) / 10)) > 0 and var_12_18 < var_12_23 then
					arg_9_1.talkMaxDuration = var_12_23
					var_12_17 = var_12_17 + 0.3

					if var_12_23 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_23 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_21
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301002", "story_v_out_318301.awb") ~= 0 then
					local var_12_24 = manager.audio:GetVoiceLength("story_v_out_318301", "318301002", "story_v_out_318301.awb") / 1000

					if var_12_24 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_24 + var_12_17
					end

					if var_12_20.prefab_name ~= "" and arg_9_1.actors_[var_12_20.prefab_name] ~= nil then
						local var_12_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_20.prefab_name].transform, "story_v_out_318301", "318301002", "story_v_out_318301.awb")

						arg_9_1:RecordAudio("318301002", var_12_25)
						arg_9_1:RecordAudio("318301002", var_12_25)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318301", "318301002", "story_v_out_318301.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318301", "318301002", "story_v_out_318301.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_26 = var_12_17 + 0.3
			local var_12_27 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_17 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_27 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_27

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_27 and arg_9_1.time_ < var_12_26 + var_12_27 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play318301003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 318301003
		arg_15_1.duration_ = 15.1

		local var_15_0 = {
			zh = 7.7,
			ja = 15.1
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play318301004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.625

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(318301003)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 25 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 25)

				if (25 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 25)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301003", "story_v_out_318301.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301003", "story_v_out_318301.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_318301", "318301003", "story_v_out_318301.awb")

						arg_15_1:RecordAudio("318301003", var_18_6)
						arg_15_1:RecordAudio("318301003", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_318301", "318301003", "story_v_out_318301.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_318301", "318301003", "story_v_out_318301.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play318301004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 318301004
		arg_19_1.duration_ = 5.23

		local var_19_0 = {
			zh = 3.766,
			ja = 5.233
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play318301005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1199ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1199ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1199ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1199ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1199ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1199ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1199ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1199ui_story == nil then
				arg_19_1.var_.characterEffect1199ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1199ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1199ui_story then
				arg_19_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_8 = arg_19_1.actors_["1049ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1049ui_story = var_22_8.localPosition
			end

			local var_22_9 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 then
				var_22_8.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_9)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 then
				var_22_8.localPosition = Vector3.New(0, 100, 0)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			local var_22_10 = arg_19_1.actors_["1049ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.characterEffect1049ui_story == nil then
				arg_19_1.var_.characterEffect1049ui_story = var_22_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_11 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_11 and not isNil(var_22_10) then
				if arg_19_1.var_.characterEffect1049ui_story and not isNil(var_22_10) then
					arg_19_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_11)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_11 and arg_19_1.time_ < 0 + var_22_11 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.characterEffect1049ui_story then
				arg_19_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_22_12 = 0
			local var_22_13 = 0.275

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_14 = arg_19_1:GetWordFromCfg(318301004)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 11 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 11)

				if (11 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 11)) > 0 and var_22_13 < var_22_17 then
					arg_19_1.talkMaxDuration = var_22_17

					if var_22_17 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_17 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301004", "story_v_out_318301.awb") ~= 0 then
					local var_22_18 = manager.audio:GetVoiceLength("story_v_out_318301", "318301004", "story_v_out_318301.awb") / 1000

					if var_22_18 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_12
					end

					if var_22_14.prefab_name ~= "" and arg_19_1.actors_[var_22_14.prefab_name] ~= nil then
						local var_22_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_14.prefab_name].transform, "story_v_out_318301", "318301004", "story_v_out_318301.awb")

						arg_19_1:RecordAudio("318301004", var_22_19)
						arg_19_1:RecordAudio("318301004", var_22_19)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_318301", "318301004", "story_v_out_318301.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_318301", "318301004", "story_v_out_318301.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_20 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_20 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_12) / var_22_20

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_12 + var_22_20 and arg_19_1.time_ < var_22_12 + var_22_20 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play318301005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 318301005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play318301006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1199ui_story = arg_23_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).z)
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles = arg_23_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1199ui_story"].transform.position).z)
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1199ui_story"].transform.localEulerAngles = arg_23_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1199ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1199ui_story == nil then
				arg_23_1.var_.characterEffect1199ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1199ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1199ui_story then
				arg_23_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_26_3 = 0
			local var_26_4 = 0.6

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_5 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(318301005).content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 24 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 24)

				if (24 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 24)) > 0 and var_26_4 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_3 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_3
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_4, arg_23_1.talkMaxDuration)

			if var_26_3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_3 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_3) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_3 + var_26_8 and arg_23_1.time_ < var_26_3 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play318301006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 318301006
		arg_27_1.duration_ = 3.17

		local var_27_0 = {
			zh = 3,
			ja = 3.166
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play318301007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1049ui_story = arg_27_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).z)
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles = arg_27_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_27_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1049ui_story"].transform.position).z)
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1049ui_story"].transform.localEulerAngles = arg_27_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1049ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1049ui_story == nil then
				arg_27_1.var_.characterEffect1049ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1049ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1049ui_story then
				arg_27_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_4 = 0
			local var_30_5 = 0.325

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(318301006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 13 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 13)

				if (13 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 13)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301006", "story_v_out_318301.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301006", "story_v_out_318301.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_out_318301", "318301006", "story_v_out_318301.awb")

						arg_27_1:RecordAudio("318301006", var_30_11)
						arg_27_1:RecordAudio("318301006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_318301", "318301006", "story_v_out_318301.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_318301", "318301006", "story_v_out_318301.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play318301007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 318301007
		arg_31_1.duration_ = 3.3

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play318301008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1199ui_story = arg_31_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).z)
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles = arg_31_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_31_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1199ui_story"].transform.position).z)
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1199ui_story"].transform.localEulerAngles = arg_31_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1199ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1199ui_story == nil then
				arg_31_1.var_.characterEffect1199ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1199ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1199ui_story then
				arg_31_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_2")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_4 = arg_31_1.actors_["1049ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1049ui_story = var_34_4.localPosition
			end

			local var_34_5 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 then
				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_5)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(0, 100, 0)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			local var_34_6 = arg_31_1.actors_["1049ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect1049ui_story == nil then
				arg_31_1.var_.characterEffect1049ui_story = var_34_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_7 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 and not isNil(var_34_6) then
				if arg_31_1.var_.characterEffect1049ui_story and not isNil(var_34_6) then
					arg_31_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_7)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect1049ui_story then
				arg_31_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_34_8 = 0
			local var_34_9 = 0.225

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(318301007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 9 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 9)

				if (9 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 9)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301007", "story_v_out_318301.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301007", "story_v_out_318301.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_318301", "318301007", "story_v_out_318301.awb")

						arg_31_1:RecordAudio("318301007", var_34_15)
						arg_31_1:RecordAudio("318301007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_318301", "318301007", "story_v_out_318301.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_318301", "318301007", "story_v_out_318301.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play318301008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 318301008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play318301009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1199ui_story = arg_35_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).z)
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles = arg_35_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1199ui_story"].transform.position).z)
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1199ui_story"].transform.localEulerAngles = arg_35_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1199ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1199ui_story == nil then
				arg_35_1.var_.characterEffect1199ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1199ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_2)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1199ui_story then
				arg_35_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_38_3 = 0
			local var_38_4 = 1.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(318301008).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 51 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 51)

				if (51 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 51)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play318301009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 318301009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play318301010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(318301009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 32 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 32)

				if (32 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 32)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play318301010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 318301010
		arg_43_1.duration_ = 4.83

		local var_43_0 = {
			zh = 3.766,
			ja = 4.833
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play318301011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1199ui_story = arg_43_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).z)
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles = arg_43_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_43_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1199ui_story"].transform.position).z)
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1199ui_story"].transform.localEulerAngles = arg_43_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1199ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1199ui_story == nil then
				arg_43_1.var_.characterEffect1199ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1199ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1199ui_story then
				arg_43_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.225

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(318301010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 9 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 9)

				if (9 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 9)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301010", "story_v_out_318301.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301010", "story_v_out_318301.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_318301", "318301010", "story_v_out_318301.awb")

						arg_43_1:RecordAudio("318301010", var_46_11)
						arg_43_1:RecordAudio("318301010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_318301", "318301010", "story_v_out_318301.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_318301", "318301010", "story_v_out_318301.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play318301011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 318301011
		arg_47_1.duration_ = 2.93

		local var_47_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play318301012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_50_0 = 0
			local var_50_1 = 0.125

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(318301011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 5 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 5)

				if (5 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 5)) > 0 and var_50_1 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301011", "story_v_out_318301.awb") ~= 0 then
					local var_50_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301011", "story_v_out_318301.awb") / 1000

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end

					if var_50_2.prefab_name ~= "" and arg_47_1.actors_[var_50_2.prefab_name] ~= nil then
						local var_50_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_2.prefab_name].transform, "story_v_out_318301", "318301011", "story_v_out_318301.awb")

						arg_47_1:RecordAudio("318301011", var_50_7)
						arg_47_1:RecordAudio("318301011", var_50_7)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_318301", "318301011", "story_v_out_318301.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_318301", "318301011", "story_v_out_318301.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play318301012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 318301012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play318301013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1199ui_story = arg_51_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).z)
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles = arg_51_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1199ui_story"].transform.position).z)
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1199ui_story"].transform.localEulerAngles = arg_51_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1199ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1199ui_story == nil then
				arg_51_1.var_.characterEffect1199ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1199ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1199ui_story then
				arg_51_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_54_3 = 0
			local var_54_4 = 0.7

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(318301012).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 28 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 28)

				if (28 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 28)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play318301013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 318301013
		arg_55_1.duration_ = 3.3

		local var_55_0 = {
			zh = 1.4,
			ja = 3.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play318301014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1049ui_story = arg_55_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).z)
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles = arg_55_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_55_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1049ui_story"].transform.position).z)
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1049ui_story"].transform.localEulerAngles = arg_55_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1049ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1049ui_story == nil then
				arg_55_1.var_.characterEffect1049ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1049ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1049ui_story then
				arg_55_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.15

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(318301013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 6 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 6)

				if (6 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 6)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301013", "story_v_out_318301.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301013", "story_v_out_318301.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_318301", "318301013", "story_v_out_318301.awb")

						arg_55_1:RecordAudio("318301013", var_58_11)
						arg_55_1:RecordAudio("318301013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_318301", "318301013", "story_v_out_318301.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_318301", "318301013", "story_v_out_318301.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play318301014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 318301014
		arg_59_1.duration_ = 3.1

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play318301015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1199ui_story = arg_59_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).z)
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles = arg_59_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_59_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1199ui_story"].transform.position).z)
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1199ui_story"].transform.localEulerAngles = arg_59_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1199ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1199ui_story == nil then
				arg_59_1.var_.characterEffect1199ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1199ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1199ui_story then
				arg_59_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action3_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = arg_59_1.actors_["1049ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1049ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0, 100, 0)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["1049ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1049ui_story == nil then
				arg_59_1.var_.characterEffect1049ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect1049ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1049ui_story then
				arg_59_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_62_8 = 0
			local var_62_9 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(318301014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 7 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 7)

				if (7 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 7)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301014", "story_v_out_318301.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301014", "story_v_out_318301.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_318301", "318301014", "story_v_out_318301.awb")

						arg_59_1:RecordAudio("318301014", var_62_15)
						arg_59_1:RecordAudio("318301014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_318301", "318301014", "story_v_out_318301.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_318301", "318301014", "story_v_out_318301.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play318301015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318301015
		arg_63_1.duration_ = 5.43

		local var_63_0 = {
			zh = 4.7,
			ja = 5.433
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318301016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1049ui_story = arg_63_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).z)
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles = arg_63_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_63_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1049ui_story"].transform.position).z)
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1049ui_story"].transform.localEulerAngles = arg_63_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1049ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1049ui_story == nil then
				arg_63_1.var_.characterEffect1049ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1049ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1049ui_story then
				arg_63_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_4 = arg_63_1.actors_["1199ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1199ui_story = var_66_4.localPosition
			end

			local var_66_5 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 then
				var_66_4.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_5)
				var_66_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_4.position).x, (manager.ui.mainCamera.transform.position - var_66_4.position).y, (manager.ui.mainCamera.transform.position - var_66_4.position).z)
				var_66_4.localEulerAngles.z = 0
				var_66_4.localEulerAngles.x = 0
				var_66_4.localEulerAngles = var_66_4.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 then
				var_66_4.localPosition = Vector3.New(0, 100, 0)
				var_66_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_4.position).x, (manager.ui.mainCamera.transform.position - var_66_4.position).y, (manager.ui.mainCamera.transform.position - var_66_4.position).z)
				var_66_4.localEulerAngles.z = 0
				var_66_4.localEulerAngles.x = 0
				var_66_4.localEulerAngles = var_66_4.localEulerAngles
			end

			local var_66_6 = arg_63_1.actors_["1199ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1199ui_story == nil then
				arg_63_1.var_.characterEffect1199ui_story = var_66_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 and not isNil(var_66_6) then
				if arg_63_1.var_.characterEffect1199ui_story and not isNil(var_66_6) then
					arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_7)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1199ui_story then
				arg_63_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_66_8 = 0
			local var_66_9 = 0.25

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(318301015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 10 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 10)

				if (10 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 10)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301015", "story_v_out_318301.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301015", "story_v_out_318301.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_318301", "318301015", "story_v_out_318301.awb")

						arg_63_1:RecordAudio("318301015", var_66_15)
						arg_63_1:RecordAudio("318301015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_318301", "318301015", "story_v_out_318301.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_318301", "318301015", "story_v_out_318301.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play318301016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318301016
		arg_67_1.duration_ = 3.73

		local var_67_0 = {
			zh = 3.733,
			ja = 2.5
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318301017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1199ui_story = arg_67_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).z)
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles = arg_67_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_67_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1199ui_story"].transform.position).z)
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1199ui_story"].transform.localEulerAngles = arg_67_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1199ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1199ui_story == nil then
				arg_67_1.var_.characterEffect1199ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1199ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1199ui_story then
				arg_67_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_4 = arg_67_1.actors_["1049ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1049ui_story = var_70_4.localPosition
			end

			local var_70_5 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 then
				var_70_4.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_5)
				var_70_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_4.position).x, (manager.ui.mainCamera.transform.position - var_70_4.position).y, (manager.ui.mainCamera.transform.position - var_70_4.position).z)
				var_70_4.localEulerAngles.z = 0
				var_70_4.localEulerAngles.x = 0
				var_70_4.localEulerAngles = var_70_4.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 then
				var_70_4.localPosition = Vector3.New(0, 100, 0)
				var_70_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_4.position).x, (manager.ui.mainCamera.transform.position - var_70_4.position).y, (manager.ui.mainCamera.transform.position - var_70_4.position).z)
				var_70_4.localEulerAngles.z = 0
				var_70_4.localEulerAngles.x = 0
				var_70_4.localEulerAngles = var_70_4.localEulerAngles
			end

			local var_70_6 = arg_67_1.actors_["1049ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1049ui_story == nil then
				arg_67_1.var_.characterEffect1049ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_7 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 and not isNil(var_70_6) then
				if arg_67_1.var_.characterEffect1049ui_story and not isNil(var_70_6) then
					arg_67_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_7)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1049ui_story then
				arg_67_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_70_8 = 0
			local var_70_9 = 0.275

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(318301016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 11 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 11)

				if (11 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 11)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301016", "story_v_out_318301.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301016", "story_v_out_318301.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_318301", "318301016", "story_v_out_318301.awb")

						arg_67_1:RecordAudio("318301016", var_70_15)
						arg_67_1:RecordAudio("318301016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_318301", "318301016", "story_v_out_318301.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_318301", "318301016", "story_v_out_318301.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play318301017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318301017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play318301018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.bgs_.K13f == nil then
				local var_74_0 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K13f")
				var_74_0.name = "K13f"
				var_74_0.transform.parent = arg_71_1.stage_.transform
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_.K13f = var_74_0
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_1 = arg_71_1.bgs_.K13f

				arg_71_1.bgs_.K13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_2 = var_74_1:GetComponent("SpriteRenderer")

				if var_74_2 and var_74_2.sprite then
					local var_74_3 = 2 * (var_74_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_1.transform.localScale = Vector3.New(var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "K13f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_4 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_5 = 2

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_5 then
				local var_74_6 = Color.New(0, 0, 0)

				var_74_6.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_4) / var_74_5)
				arg_71_1.mask_.color = var_74_6
			end

			if arg_71_1.time_ >= var_74_4 + var_74_5 and arg_71_1.time_ < var_74_4 + var_74_5 + arg_74_0 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = 1
				arg_71_1.mask_.color = var_74_7
			end

			local var_74_8 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_9 = 2

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 then
				local var_74_10 = Color.New(0, 0, 0)

				var_74_10.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_8) / var_74_9)
				arg_71_1.mask_.color = var_74_10
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 then
				local var_74_11 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_11.a = 0
				arg_71_1.mask_.color = var_74_11
			end

			local var_74_12 = arg_71_1.actors_["1199ui_story"].transform

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 then
				arg_71_1.var_.moveOldPos1199ui_story = var_74_12.localPosition
			end

			local var_74_13 = 0.001

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_13 then
				var_74_12.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 1.96599999815226) / var_74_13)
				var_74_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_12.position).x, (manager.ui.mainCamera.transform.position - var_74_12.position).y, (manager.ui.mainCamera.transform.position - var_74_12.position).z)
				var_74_12.localEulerAngles.z = 0
				var_74_12.localEulerAngles.x = 0
				var_74_12.localEulerAngles = var_74_12.localEulerAngles
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_13 and arg_71_1.time_ < 1.96599999815226 + var_74_13 + arg_74_0 then
				var_74_12.localPosition = Vector3.New(0, 100, 0)
				var_74_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_12.position).x, (manager.ui.mainCamera.transform.position - var_74_12.position).y, (manager.ui.mainCamera.transform.position - var_74_12.position).z)
				var_74_12.localEulerAngles.z = 0
				var_74_12.localEulerAngles.x = 0
				var_74_12.localEulerAngles = var_74_12.localEulerAngles
			end

			local var_74_14 = arg_71_1.actors_["1199ui_story"]

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 and not isNil(var_74_14) and arg_71_1.var_.characterEffect1199ui_story == nil then
				arg_71_1.var_.characterEffect1199ui_story = var_74_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_15 = 0.034000001847744

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_15 and not isNil(var_74_14) then
				if arg_71_1.var_.characterEffect1199ui_story and not isNil(var_74_14) then
					arg_71_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 1.96599999815226) / var_74_15)
				end
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_15 and arg_71_1.time_ < 1.96599999815226 + var_74_15 + arg_74_0 and not isNil(var_74_14) and arg_71_1.var_.characterEffect1199ui_story then
				arg_71_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_16 = 4
			local var_74_17 = 0.925

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_18 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_18:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_19 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(318301017).content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_21 = 37 <= 0 and var_74_17 or var_74_17 * (utf8.len(var_74_19) / 37)

				if (37 <= 0 and var_74_17 or var_74_17 * (utf8.len(var_74_19) / 37)) > 0 and var_74_17 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21
					var_74_16 = var_74_16 + 0.3

					if var_74_21 + var_74_16 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_16
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = var_74_16 + 0.3
			local var_74_23 = math.max(var_74_17, arg_71_1.talkMaxDuration)

			if var_74_16 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_22 + var_74_23 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_22) / var_74_23

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_22 + var_74_23 and arg_71_1.time_ < var_74_22 + var_74_23 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play318301018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318301018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play318301019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(318301018).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 28)

				if (28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 28)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play318301019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318301019
		arg_81_1.duration_ = 4.83

		local var_81_0 = {
			zh = 4.833,
			ja = 3.5
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
				arg_81_0:Play318301020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_84_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_81_1.stage_.transform)

				var_84_0.name = "1093ui_story"
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1093ui_story"] = var_84_0

				local var_84_1 = var_84_0:GetComponentInChildren(typeof(CharacterEffect))

				var_84_1.enabled = true

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_1.transform, false)

				arg_81_1.var_["1093ui_story" .. "Animator"] = var_84_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_81_1.var_["1093ui_story" .. "LipSync"] = var_84_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_3 = arg_81_1.actors_["1093ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1093ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_84_8 = 0
			local var_84_9 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(318301019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 20 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 20)

				if (20 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 20)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301019", "story_v_out_318301.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301019", "story_v_out_318301.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_318301", "318301019", "story_v_out_318301.awb")

						arg_81_1:RecordAudio("318301019", var_84_15)
						arg_81_1:RecordAudio("318301019", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318301", "318301019", "story_v_out_318301.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318301", "318301019", "story_v_out_318301.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play318301020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318301020
		arg_85_1.duration_ = 8.4

		local var_85_0 = {
			zh = 7.366,
			ja = 8.4
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play318301021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(318301020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 33)

				if (33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 33)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301020", "story_v_out_318301.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301020", "story_v_out_318301.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_318301", "318301020", "story_v_out_318301.awb")

						arg_85_1:RecordAudio("318301020", var_88_6)
						arg_85_1:RecordAudio("318301020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_318301", "318301020", "story_v_out_318301.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_318301", "318301020", "story_v_out_318301.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play318301021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318301021
		arg_89_1.duration_ = 6

		local var_89_0 = {
			zh = 4.7,
			ja = 6
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
				arg_89_0:Play318301022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(318301021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)

				if (18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301021", "story_v_out_318301.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301021", "story_v_out_318301.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_318301", "318301021", "story_v_out_318301.awb")

						arg_89_1:RecordAudio("318301021", var_92_6)
						arg_89_1:RecordAudio("318301021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318301", "318301021", "story_v_out_318301.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318301", "318301021", "story_v_out_318301.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play318301022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318301022
		arg_93_1.duration_ = 3.53

		local var_93_0 = {
			zh = 3.533,
			ja = 2.3
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
				arg_93_0:Play318301023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "1055ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1055ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["1055ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["1055ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["1055ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1055ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["1055ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1055ui_story == nil then
				arg_93_1.var_.characterEffect1055ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.characterEffect1055ui_story and not isNil(var_96_5) then
					arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1055ui_story then
				arg_93_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_8 = arg_93_1.actors_["1093ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = var_96_8.localPosition
			end

			local var_96_9 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 then
				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_9)
				var_96_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_8.position).x, (manager.ui.mainCamera.transform.position - var_96_8.position).y, (manager.ui.mainCamera.transform.position - var_96_8.position).z)
				var_96_8.localEulerAngles.z = 0
				var_96_8.localEulerAngles.x = 0
				var_96_8.localEulerAngles = var_96_8.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, 100, 0)
				var_96_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_8.position).x, (manager.ui.mainCamera.transform.position - var_96_8.position).y, (manager.ui.mainCamera.transform.position - var_96_8.position).z)
				var_96_8.localEulerAngles.z = 0
				var_96_8.localEulerAngles.x = 0
				var_96_8.localEulerAngles = var_96_8.localEulerAngles
			end

			local var_96_10 = arg_93_1.actors_["1093ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_11 and not isNil(var_96_10) then
				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_10) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_11)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_11 and arg_93_1.time_ < 0 + var_96_11 + arg_96_0 and not isNil(var_96_10) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_96_12 = 0
			local var_96_13 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(318301022)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 14 <= 0 and var_96_13 or var_96_13 * (utf8.len(var_96_15) / 14)

				if (14 <= 0 and var_96_13 or var_96_13 * (utf8.len(var_96_15) / 14)) > 0 and var_96_13 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301022", "story_v_out_318301.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_318301", "318301022", "story_v_out_318301.awb") / 1000

					if var_96_18 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_12
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_318301", "318301022", "story_v_out_318301.awb")

						arg_93_1:RecordAudio("318301022", var_96_19)
						arg_93_1:RecordAudio("318301022", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318301", "318301022", "story_v_out_318301.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318301", "318301022", "story_v_out_318301.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_20 and arg_93_1.time_ < var_96_12 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play318301023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318301023
		arg_97_1.duration_ = 3.9

		local var_97_0 = {
			zh = 3.333,
			ja = 3.9
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play318301024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if arg_97_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_100_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_97_1.stage_.transform)

				var_100_0.name = "1150ui_story"
				var_100_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1150ui_story"] = var_100_0

				local var_100_1 = var_100_0:GetComponentInChildren(typeof(CharacterEffect))

				var_100_1.enabled = true

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end

				arg_97_1:ShowWeapon(var_100_1.transform, false)

				arg_97_1.var_["1150ui_story" .. "Animator"] = var_100_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_97_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_97_1.var_["1150ui_story" .. "LipSync"] = var_100_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_100_3 = arg_97_1.actors_["1150ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1150ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["1150ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1150ui_story == nil then
				arg_97_1.var_.characterEffect1150ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect1150ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1150ui_story then
				arg_97_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_100_8 = arg_97_1.actors_["1055ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1055ui_story = var_100_8.localPosition
			end

			local var_100_9 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 then
				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_9)
				var_100_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_8.position).x, (manager.ui.mainCamera.transform.position - var_100_8.position).y, (manager.ui.mainCamera.transform.position - var_100_8.position).z)
				var_100_8.localEulerAngles.z = 0
				var_100_8.localEulerAngles.x = 0
				var_100_8.localEulerAngles = var_100_8.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, 100, 0)
				var_100_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_8.position).x, (manager.ui.mainCamera.transform.position - var_100_8.position).y, (manager.ui.mainCamera.transform.position - var_100_8.position).z)
				var_100_8.localEulerAngles.z = 0
				var_100_8.localEulerAngles.x = 0
				var_100_8.localEulerAngles = var_100_8.localEulerAngles
			end

			local var_100_10 = arg_97_1.actors_["1055ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_10) and arg_97_1.var_.characterEffect1055ui_story == nil then
				arg_97_1.var_.characterEffect1055ui_story = var_100_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_11 and not isNil(var_100_10) then
				if arg_97_1.var_.characterEffect1055ui_story and not isNil(var_100_10) then
					arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_11)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_11 and arg_97_1.time_ < 0 + var_100_11 + arg_100_0 and not isNil(var_100_10) and arg_97_1.var_.characterEffect1055ui_story then
				arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_100_12 = 0
			local var_100_13 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(318301023)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 14 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 14)

				if (14 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 14)) > 0 and var_100_13 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301023", "story_v_out_318301.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_318301", "318301023", "story_v_out_318301.awb") / 1000

					if var_100_18 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_12
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_318301", "318301023", "story_v_out_318301.awb")

						arg_97_1:RecordAudio("318301023", var_100_19)
						arg_97_1:RecordAudio("318301023", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318301", "318301023", "story_v_out_318301.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318301", "318301023", "story_v_out_318301.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_20 and arg_97_1.time_ < var_100_12 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play318301024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318301024
		arg_101_1.duration_ = 5.7

		local var_101_0 = {
			zh = 3.233,
			ja = 5.7
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
				arg_101_0:Play318301025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1093ui_story = arg_101_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).z)
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles = arg_101_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_101_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1093ui_story"].transform.position).z)
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1093ui_story"].transform.localEulerAngles = arg_101_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1093ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1093ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["1150ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1150ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, 100, 0)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			local var_104_6 = arg_101_1.actors_["1150ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1150ui_story == nil then
				arg_101_1.var_.characterEffect1150ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect1150ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1150ui_story then
				arg_101_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_104_8 = 0
			local var_104_9 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(318301024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 11 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 11)

				if (11 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 11)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301024", "story_v_out_318301.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301024", "story_v_out_318301.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_318301", "318301024", "story_v_out_318301.awb")

						arg_101_1:RecordAudio("318301024", var_104_15)
						arg_101_1:RecordAudio("318301024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318301", "318301024", "story_v_out_318301.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318301", "318301024", "story_v_out_318301.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play318301025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318301025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318301026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1093ui_story = arg_105_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1093ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_108_3 = 0
			local var_108_4 = 0.625

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(318301025).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 25 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 25)

				if (25 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 25)) > 0 and var_108_4 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_8 and arg_105_1.time_ < var_108_3 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play318301026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318301026
		arg_109_1.duration_ = 2.47

		local var_109_0 = {
			zh = 1.2,
			ja = 2.466
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
				arg_109_0:Play318301027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1093ui_story = arg_109_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).z)
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles = arg_109_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_109_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).z)
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles = arg_109_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1093ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(318301026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 4 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 4)

				if (4 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 4)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301026", "story_v_out_318301.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301026", "story_v_out_318301.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_318301", "318301026", "story_v_out_318301.awb")

						arg_109_1:RecordAudio("318301026", var_112_11)
						arg_109_1:RecordAudio("318301026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318301", "318301026", "story_v_out_318301.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318301", "318301026", "story_v_out_318301.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play318301027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318301027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play318301028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = arg_113_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).z)
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles = arg_113_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1093ui_story"].transform.position).z)
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1093ui_story"].transform.localEulerAngles = arg_113_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1093ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1093ui_story then
				arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_116_3 = 0
			local var_116_4 = 0.425

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
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

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(318301027).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 17 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 17)

				if (17 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 17)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play318301028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318301028
		arg_117_1.duration_ = 9.33

		local var_117_0 = {
			zh = 6.1,
			ja = 9.333
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play318301029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1199ui_story = arg_117_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1199ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story == nil then
				arg_117_1.var_.characterEffect1199ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1199ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story then
				arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.625

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(318301028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 25 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 25)

				if (25 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 25)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301028", "story_v_out_318301.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301028", "story_v_out_318301.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_318301", "318301028", "story_v_out_318301.awb")

						arg_117_1:RecordAudio("318301028", var_120_11)
						arg_117_1:RecordAudio("318301028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318301", "318301028", "story_v_out_318301.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318301", "318301028", "story_v_out_318301.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play318301029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318301029
		arg_121_1.duration_ = 5.53

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 5.533
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play318301030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1150ui_story = arg_121_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).z)
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles = arg_121_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_121_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1150ui_story"].transform.position).z)
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1150ui_story"].transform.localEulerAngles = arg_121_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1150ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1150ui_story == nil then
				arg_121_1.var_.characterEffect1150ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1150ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1150ui_story then
				arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = arg_121_1.actors_["1199ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1199ui_story = var_124_4.localPosition
			end

			local var_124_5 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				var_124_4.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_5)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				var_124_4.localPosition = Vector3.New(0, 100, 0)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles
			end

			local var_124_6 = arg_121_1.actors_["1199ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_7 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 and not isNil(var_124_6) then
				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_7)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1199ui_story then
				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_124_8 = 0
			local var_124_9 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(318301029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)

				if (8 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 8)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301029", "story_v_out_318301.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301029", "story_v_out_318301.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_318301", "318301029", "story_v_out_318301.awb")

						arg_121_1:RecordAudio("318301029", var_124_15)
						arg_121_1:RecordAudio("318301029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318301", "318301029", "story_v_out_318301.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318301", "318301029", "story_v_out_318301.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play318301030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318301030
		arg_125_1.duration_ = 7

		local var_125_0 = {
			zh = 7,
			ja = 4.033
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318301031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1199ui_story = arg_125_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).z)
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles = arg_125_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_125_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1199ui_story"].transform.position).z)
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1199ui_story"].transform.localEulerAngles = arg_125_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1199ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1199ui_story == nil then
				arg_125_1.var_.characterEffect1199ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1199ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1199ui_story then
				arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = arg_125_1.actors_["1150ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1150ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(0, 100, 0)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["1150ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1150ui_story == nil then
				arg_125_1.var_.characterEffect1150ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect1150ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1150ui_story then
				arg_125_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_128_8 = 0
			local var_128_9 = 0.6

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(318301030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 24 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 24)

				if (24 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 24)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301030", "story_v_out_318301.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301030", "story_v_out_318301.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_318301", "318301030", "story_v_out_318301.awb")

						arg_125_1:RecordAudio("318301030", var_128_15)
						arg_125_1:RecordAudio("318301030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318301", "318301030", "story_v_out_318301.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318301", "318301030", "story_v_out_318301.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play318301031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318301031
		arg_129_1.duration_ = 2.83

		local var_129_0 = {
			zh = 2.833,
			ja = 2.633
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318301032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1093ui_story = arg_129_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1093ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1093ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = arg_129_1.actors_["1199ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1199ui_story = var_132_4.localPosition
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_5)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0, 100, 0)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			local var_132_6 = arg_129_1.actors_["1199ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1199ui_story == nil then
				arg_129_1.var_.characterEffect1199ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 and not isNil(var_132_6) then
				if arg_129_1.var_.characterEffect1199ui_story and not isNil(var_132_6) then
					arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_7)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1199ui_story then
				arg_129_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_132_8 = 0
			local var_132_9 = 0.25

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(318301031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 10 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 10)

				if (10 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 10)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301031", "story_v_out_318301.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301031", "story_v_out_318301.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_318301", "318301031", "story_v_out_318301.awb")

						arg_129_1:RecordAudio("318301031", var_132_15)
						arg_129_1:RecordAudio("318301031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318301", "318301031", "story_v_out_318301.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318301", "318301031", "story_v_out_318301.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play318301032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318301032
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.3
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318301033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1199ui_story = arg_133_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).z)
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles = arg_133_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_133_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1199ui_story"].transform.position).z)
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1199ui_story"].transform.localEulerAngles = arg_133_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1199ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1199ui_story == nil then
				arg_133_1.var_.characterEffect1199ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1199ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1199ui_story then
				arg_133_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = arg_133_1.actors_["1093ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1093ui_story = var_136_4.localPosition
			end

			local var_136_5 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_5)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0, 100, 0)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			local var_136_6 = arg_133_1.actors_["1093ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1093ui_story == nil then
				arg_133_1.var_.characterEffect1093ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_7 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 and not isNil(var_136_6) then
				if arg_133_1.var_.characterEffect1093ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_7)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1093ui_story then
				arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_136_8 = 0
			local var_136_9 = 0.15

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(318301032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 6 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 6)

				if (6 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 6)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301032", "story_v_out_318301.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301032", "story_v_out_318301.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_318301", "318301032", "story_v_out_318301.awb")

						arg_133_1:RecordAudio("318301032", var_136_15)
						arg_133_1:RecordAudio("318301032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318301", "318301032", "story_v_out_318301.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318301", "318301032", "story_v_out_318301.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318301033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318301034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1199ui_story = arg_137_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).z)
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles = arg_137_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1199ui_story"].transform.position).z)
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1199ui_story"].transform.localEulerAngles = arg_137_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1199ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1199ui_story == nil then
				arg_137_1.var_.characterEffect1199ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1199ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1199ui_story then
				arg_137_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_140_3 = 0
			local var_140_4 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(318301033).content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 33 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 33)

				if (33 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 33)) > 0 and var_140_4 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_3
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_4, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_3) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_8 and arg_137_1.time_ < var_140_3 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play318301034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318301034
		arg_141_1.duration_ = 2.77

		local var_141_0 = {
			zh = 2.6,
			ja = 2.766
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318301035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1199ui_story = arg_141_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).z)
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles = arg_141_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_141_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).z)
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles = arg_141_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1199ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1199ui_story == nil then
				arg_141_1.var_.characterEffect1199ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1199ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1199ui_story then
				arg_141_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.175

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(318301034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 7 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 7)

				if (7 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 7)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301034", "story_v_out_318301.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301034", "story_v_out_318301.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_318301", "318301034", "story_v_out_318301.awb")

						arg_141_1:RecordAudio("318301034", var_144_11)
						arg_141_1:RecordAudio("318301034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318301", "318301034", "story_v_out_318301.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318301", "318301034", "story_v_out_318301.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318301035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318301035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318301036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1199ui_story = arg_145_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).z)
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles = arg_145_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1199ui_story"].transform.position).z)
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1199ui_story"].transform.localEulerAngles = arg_145_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1199ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1199ui_story == nil then
				arg_145_1.var_.characterEffect1199ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1199ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1199ui_story then
				arg_145_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_148_3 = 0
			local var_148_4 = 0.475

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(318301035).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 19 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 19)

				if (19 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 19)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play318301036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318301036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318301037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.7

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(318301036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 28 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 28)

				if (28 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 28)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318301037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318301037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318301038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(318301037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 28)

				if (28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 28)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318301038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318301038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318301039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(318301038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 42 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 42)

				if (42 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 42)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318301039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318301039
		arg_161_1.duration_ = 2.1

		local var_161_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_161_0:Play318301040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1150ui_story = arg_161_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).z)
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles = arg_161_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_161_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1150ui_story"].transform.position).z)
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1150ui_story"].transform.localEulerAngles = arg_161_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1150ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1150ui_story == nil then
				arg_161_1.var_.characterEffect1150ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1150ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1150ui_story then
				arg_161_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.05

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(318301039)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 2 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 2)

				if (2 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 2)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301039", "story_v_out_318301.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301039", "story_v_out_318301.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_318301", "318301039", "story_v_out_318301.awb")

						arg_161_1:RecordAudio("318301039", var_164_11)
						arg_161_1:RecordAudio("318301039", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318301", "318301039", "story_v_out_318301.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318301", "318301039", "story_v_out_318301.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play318301040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318301040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318301041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1150ui_story = arg_165_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).z)
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles = arg_165_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1150ui_story"].transform.position).z)
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1150ui_story"].transform.localEulerAngles = arg_165_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1150ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1150ui_story == nil then
				arg_165_1.var_.characterEffect1150ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1150ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1150ui_story then
				arg_165_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_168_3 = 0
			local var_168_4 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
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

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_5 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(318301040).content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 10 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 10)

				if (10 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 10)) > 0 and var_168_4 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_3
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_4, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_3) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_8 and arg_165_1.time_ < var_168_3 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play318301041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318301041
		arg_169_1.duration_ = 8.7

		local var_169_0 = {
			zh = 8.5,
			ja = 8.7
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
				arg_169_0:Play318301042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1093ui_story = arg_169_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).z)
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles = arg_169_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_169_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).z)
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles = arg_169_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1093ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1093ui_story == nil then
				arg_169_1.var_.characterEffect1093ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1093ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1093ui_story then
				arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(318301041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 39 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 39)

				if (39 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 39)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301041", "story_v_out_318301.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301041", "story_v_out_318301.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_318301", "318301041", "story_v_out_318301.awb")

						arg_169_1:RecordAudio("318301041", var_172_11)
						arg_169_1:RecordAudio("318301041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_318301", "318301041", "story_v_out_318301.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_318301", "318301041", "story_v_out_318301.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play318301042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318301042
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318301043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1150ui_story = arg_173_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).z)
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles = arg_173_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_173_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1150ui_story"].transform.position).z)
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1150ui_story"].transform.localEulerAngles = arg_173_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1150ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1150ui_story == nil then
				arg_173_1.var_.characterEffect1150ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1150ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1150ui_story then
				arg_173_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = arg_173_1.actors_["1093ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1093ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(0, 100, 0)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			local var_176_6 = arg_173_1.actors_["1093ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect1093ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1093ui_story then
				arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_176_8 = 0
			local var_176_9 = 0.1

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(318301042)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 4 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 4)

				if (4 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 4)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301042", "story_v_out_318301.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301042", "story_v_out_318301.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_318301", "318301042", "story_v_out_318301.awb")

						arg_173_1:RecordAudio("318301042", var_176_15)
						arg_173_1:RecordAudio("318301042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318301", "318301042", "story_v_out_318301.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318301", "318301042", "story_v_out_318301.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318301043
		arg_177_1.duration_ = 6.1

		local var_177_0 = {
			zh = 4.966,
			ja = 6.1
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
				arg_177_0:Play318301044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1199ui_story = arg_177_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).z)
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles = arg_177_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_177_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1199ui_story"].transform.position).z)
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1199ui_story"].transform.localEulerAngles = arg_177_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1199ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1199ui_story == nil then
				arg_177_1.var_.characterEffect1199ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1199ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1199ui_story then
				arg_177_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_4 = arg_177_1.actors_["1150ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1150ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(0, 100, 0)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			local var_180_6 = arg_177_1.actors_["1150ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1150ui_story == nil then
				arg_177_1.var_.characterEffect1150ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect1150ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1150ui_story then
				arg_177_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_180_8 = 0
			local var_180_9 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(318301043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 19 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 19)

				if (19 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 19)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301043", "story_v_out_318301.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301043", "story_v_out_318301.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_318301", "318301043", "story_v_out_318301.awb")

						arg_177_1:RecordAudio("318301043", var_180_15)
						arg_177_1:RecordAudio("318301043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_318301", "318301043", "story_v_out_318301.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_318301", "318301043", "story_v_out_318301.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318301044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play318301045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1199ui_story = arg_181_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1199ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story == nil then
				arg_181_1.var_.characterEffect1199ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1199ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story then
				arg_181_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_184_3 = 0
			local var_184_4 = 0.6

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(318301044).content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 24 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 24)

				if (24 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 24)) > 0 and var_184_4 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_8 and arg_181_1.time_ < var_184_3 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play318301045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318301045
		arg_185_1.duration_ = 3.6

		local var_185_0 = {
			zh = 1.999999999999,
			ja = 3.6
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play318301046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1150ui_story = arg_185_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).z)
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles = arg_185_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_185_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1150ui_story"].transform.position).z)
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1150ui_story"].transform.localEulerAngles = arg_185_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1150ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1150ui_story == nil then
				arg_185_1.var_.characterEffect1150ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1150ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1150ui_story then
				arg_185_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.125

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(318301045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 5 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 5)

				if (5 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 5)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301045", "story_v_out_318301.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301045", "story_v_out_318301.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_318301", "318301045", "story_v_out_318301.awb")

						arg_185_1:RecordAudio("318301045", var_188_11)
						arg_185_1:RecordAudio("318301045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_318301", "318301045", "story_v_out_318301.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_318301", "318301045", "story_v_out_318301.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318301046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play318301047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1150ui_story = arg_189_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).z)
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles = arg_189_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1150ui_story"].transform.position).z)
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1150ui_story"].transform.localEulerAngles = arg_189_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1150ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1150ui_story == nil then
				arg_189_1.var_.characterEffect1150ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1150ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1150ui_story then
				arg_189_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_192_3 = 0
			local var_192_4 = 0.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(318301046).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 23 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 23)

				if (23 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 23)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318301047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318301047
		arg_193_1.duration_ = 2.87

		local var_193_0 = {
			zh = 2.866,
			ja = 2.333
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
				arg_193_0:Play318301048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1055ui_story = arg_193_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).z)
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles = arg_193_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_193_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1055ui_story"].transform.position).z)
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1055ui_story"].transform.localEulerAngles = arg_193_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1055ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1055ui_story == nil then
				arg_193_1.var_.characterEffect1055ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1055ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1055ui_story then
				arg_193_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(318301047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 11 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 11)

				if (11 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 11)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301047", "story_v_out_318301.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301047", "story_v_out_318301.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_318301", "318301047", "story_v_out_318301.awb")

						arg_193_1:RecordAudio("318301047", var_196_11)
						arg_193_1:RecordAudio("318301047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_318301", "318301047", "story_v_out_318301.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_318301", "318301047", "story_v_out_318301.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play318301048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318301048
		arg_197_1.duration_ = 3.9

		local var_197_0 = {
			zh = 3.833,
			ja = 3.9
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318301049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1093ui_story = arg_197_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).z)
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles = arg_197_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_197_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1093ui_story"].transform.position).z)
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1093ui_story"].transform.localEulerAngles = arg_197_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1093ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1093ui_story == nil then
				arg_197_1.var_.characterEffect1093ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1093ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1093ui_story then
				arg_197_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action468")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_200_4 = arg_197_1.actors_["1055ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1055ui_story = var_200_4.localPosition
			end

			local var_200_5 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 then
				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_5)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(0, 100, 0)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			local var_200_6 = arg_197_1.actors_["1055ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1055ui_story == nil then
				arg_197_1.var_.characterEffect1055ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 and not isNil(var_200_6) then
				if arg_197_1.var_.characterEffect1055ui_story and not isNil(var_200_6) then
					arg_197_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_7)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1055ui_story then
				arg_197_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_200_8 = 0
			local var_200_9 = 0.425

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(318301048)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 17 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 17)

				if (17 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 17)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301048", "story_v_out_318301.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301048", "story_v_out_318301.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_318301", "318301048", "story_v_out_318301.awb")

						arg_197_1:RecordAudio("318301048", var_200_15)
						arg_197_1:RecordAudio("318301048", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_318301", "318301048", "story_v_out_318301.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_318301", "318301048", "story_v_out_318301.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play318301049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318301049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play318301050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1093ui_story = arg_201_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).z)
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles = arg_201_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1093ui_story"].transform.position).z)
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1093ui_story"].transform.localEulerAngles = arg_201_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1093ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1093ui_story == nil then
				arg_201_1.var_.characterEffect1093ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1093ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_2)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1093ui_story then
				arg_201_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_204_3 = 0
			local var_204_4 = 0.65

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(318301049).content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 26 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 26)

				if (26 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 26)) > 0 and var_204_4 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_3 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_3
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_4, arg_201_1.talkMaxDuration)

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_3) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_3 + var_204_8 and arg_201_1.time_ < var_204_3 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play318301050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318301050
		arg_205_1.duration_ = 2.9

		local var_205_0 = {
			zh = 2.9,
			ja = 2.066
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play318301051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1093ui_story = arg_205_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).z)
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles = arg_205_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_205_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1093ui_story"].transform.position).z)
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1093ui_story"].transform.localEulerAngles = arg_205_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1093ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1093ui_story == nil then
				arg_205_1.var_.characterEffect1093ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1093ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1093ui_story then
				arg_205_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_2")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_208_4 = 0
			local var_208_5 = 0.25

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(318301050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 10 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 10)

				if (10 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 10)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301050", "story_v_out_318301.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301050", "story_v_out_318301.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_318301", "318301050", "story_v_out_318301.awb")

						arg_205_1:RecordAudio("318301050", var_208_11)
						arg_205_1:RecordAudio("318301050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_318301", "318301050", "story_v_out_318301.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_318301", "318301050", "story_v_out_318301.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play318301051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 318301051
		arg_209_1.duration_ = 5.33

		local var_209_0 = {
			zh = 3.633,
			ja = 5.333
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play318301052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1150ui_story = arg_209_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).z)
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles = arg_209_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_209_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1150ui_story"].transform.position).z)
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1150ui_story"].transform.localEulerAngles = arg_209_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1150ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1150ui_story == nil then
				arg_209_1.var_.characterEffect1150ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1150ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1150ui_story then
				arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_4 = arg_209_1.actors_["1093ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1093ui_story = var_212_4.localPosition
			end

			local var_212_5 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 then
				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_5)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(0, 100, 0)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			local var_212_6 = arg_209_1.actors_["1093ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect1093ui_story == nil then
				arg_209_1.var_.characterEffect1093ui_story = var_212_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_7 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 and not isNil(var_212_6) then
				if arg_209_1.var_.characterEffect1093ui_story and not isNil(var_212_6) then
					arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_7)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect1093ui_story then
				arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_212_8 = 0
			local var_212_9 = 0.45

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(318301051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 18 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 18)

				if (18 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 18)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301051", "story_v_out_318301.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301051", "story_v_out_318301.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_318301", "318301051", "story_v_out_318301.awb")

						arg_209_1:RecordAudio("318301051", var_212_15)
						arg_209_1:RecordAudio("318301051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_318301", "318301051", "story_v_out_318301.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_318301", "318301051", "story_v_out_318301.awb")
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
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318301052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 318301052
		arg_213_1.duration_ = 3.97

		local var_213_0 = {
			zh = 3.6,
			ja = 3.966
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play318301053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1055ui_story = arg_213_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).z)
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles = arg_213_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_213_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1055ui_story"].transform.position).z)
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1055ui_story"].transform.localEulerAngles = arg_213_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1055ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1055ui_story == nil then
				arg_213_1.var_.characterEffect1055ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1055ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1055ui_story then
				arg_213_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_216_4 = arg_213_1.actors_["1150ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1150ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(0, 100, 0)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			local var_216_6 = arg_213_1.actors_["1150ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1150ui_story == nil then
				arg_213_1.var_.characterEffect1150ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1150ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1150ui_story then
				arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_216_8 = 0
			local var_216_9 = 0.3

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(318301052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 12 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 12)

				if (12 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 12)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301052", "story_v_out_318301.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301052", "story_v_out_318301.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_318301", "318301052", "story_v_out_318301.awb")

						arg_213_1:RecordAudio("318301052", var_216_15)
						arg_213_1:RecordAudio("318301052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_318301", "318301052", "story_v_out_318301.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_318301", "318301052", "story_v_out_318301.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play318301053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 318301053
		arg_217_1.duration_ = 13.5

		local var_217_0 = {
			zh = 6.333,
			ja = 13.5
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
				arg_217_0:Play318301054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1093ui_story = arg_217_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).z)
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles = arg_217_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_217_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1093ui_story"].transform.position).z)
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1093ui_story"].transform.localEulerAngles = arg_217_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1093ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1093ui_story == nil then
				arg_217_1.var_.characterEffect1093ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1093ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1093ui_story then
				arg_217_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_220_4 = arg_217_1.actors_["1055ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1055ui_story = var_220_4.localPosition
			end

			local var_220_5 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 then
				var_220_4.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_5)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 then
				var_220_4.localPosition = Vector3.New(0, 100, 0)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			local var_220_6 = arg_217_1.actors_["1055ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1055ui_story == nil then
				arg_217_1.var_.characterEffect1055ui_story = var_220_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_7 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 and not isNil(var_220_6) then
				if arg_217_1.var_.characterEffect1055ui_story and not isNil(var_220_6) then
					arg_217_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_7)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1055ui_story then
				arg_217_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_220_8 = 0
			local var_220_9 = 0.625

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(318301053)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 25 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 25)

				if (25 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 25)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301053", "story_v_out_318301.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301053", "story_v_out_318301.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_318301", "318301053", "story_v_out_318301.awb")

						arg_217_1:RecordAudio("318301053", var_220_15)
						arg_217_1:RecordAudio("318301053", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_318301", "318301053", "story_v_out_318301.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_318301", "318301053", "story_v_out_318301.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play318301054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 318301054
		arg_221_1.duration_ = 8.63

		local var_221_0 = {
			zh = 6.033,
			ja = 8.633
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play318301055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1055ui_story = arg_221_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).z)
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles = arg_221_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_221_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).z)
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles = arg_221_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1055ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1055ui_story == nil then
				arg_221_1.var_.characterEffect1055ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1055ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1055ui_story then
				arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_224_4 = arg_221_1.actors_["1093ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1093ui_story = var_224_4.localPosition
			end

			local var_224_5 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 then
				var_224_4.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_5)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 then
				var_224_4.localPosition = Vector3.New(0, 100, 0)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			local var_224_6 = arg_221_1.actors_["1093ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect1093ui_story == nil then
				arg_221_1.var_.characterEffect1093ui_story = var_224_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_7 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 and not isNil(var_224_6) then
				if arg_221_1.var_.characterEffect1093ui_story and not isNil(var_224_6) then
					arg_221_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_7)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect1093ui_story then
				arg_221_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_224_8 = 0
			local var_224_9 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(318301054)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 22 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 22)

				if (22 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 22)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301054", "story_v_out_318301.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301054", "story_v_out_318301.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_318301", "318301054", "story_v_out_318301.awb")

						arg_221_1:RecordAudio("318301054", var_224_15)
						arg_221_1:RecordAudio("318301054", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_318301", "318301054", "story_v_out_318301.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_318301", "318301054", "story_v_out_318301.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play318301055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 318301055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play318301056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1055ui_story = arg_225_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).z)
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles = arg_225_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1055ui_story"].transform.position).z)
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1055ui_story"].transform.localEulerAngles = arg_225_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1055ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1055ui_story == nil then
				arg_225_1.var_.characterEffect1055ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1055ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_2)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1055ui_story then
				arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_228_3 = 0
			local var_228_4 = 0.65

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_5 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(318301055).content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 26 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 26)

				if (26 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 26)) > 0 and var_228_4 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_3
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_4, arg_225_1.talkMaxDuration)

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_3) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_3 + var_228_8 and arg_225_1.time_ < var_228_3 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play318301056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 318301056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play318301057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.65

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(318301056).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 26 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 26)

				if (26 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 26)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play318301057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 318301057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play318301058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.425

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
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

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(318301057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 17 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 17)

				if (17 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 17)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play318301058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 318301058
		arg_237_1.duration_ = 2.43

		local var_237_0 = {
			zh = 1.466,
			ja = 2.433
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play318301059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1093ui_story = arg_237_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).z)
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles = arg_237_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_237_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1093ui_story"].transform.position).z)
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1093ui_story"].transform.localEulerAngles = arg_237_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1093ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1093ui_story == nil then
				arg_237_1.var_.characterEffect1093ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1093ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1093ui_story then
				arg_237_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(318301058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 5 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 5)

				if (5 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 5)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301058", "story_v_out_318301.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301058", "story_v_out_318301.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_318301", "318301058", "story_v_out_318301.awb")

						arg_237_1:RecordAudio("318301058", var_240_11)
						arg_237_1:RecordAudio("318301058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_318301", "318301058", "story_v_out_318301.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_318301", "318301058", "story_v_out_318301.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play318301059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 318301059
		arg_241_1.duration_ = 4.8

		local var_241_0 = {
			zh = 2.666,
			ja = 4.8
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
				arg_241_0:Play318301060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1093ui_story = arg_241_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).z)
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles = arg_241_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_241_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1093ui_story"].transform.position).z)
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1093ui_story"].transform.localEulerAngles = arg_241_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1093ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1093ui_story == nil then
				arg_241_1.var_.characterEffect1093ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1093ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1093ui_story then
				arg_241_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.35

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(318301059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)

				if (14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301059", "story_v_out_318301.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301059", "story_v_out_318301.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_318301", "318301059", "story_v_out_318301.awb")

						arg_241_1:RecordAudio("318301059", var_244_11)
						arg_241_1:RecordAudio("318301059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_318301", "318301059", "story_v_out_318301.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_318301", "318301059", "story_v_out_318301.awb")
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
				actorName = "1093ui_story",
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
	Play318301060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 318301060
		arg_245_1.duration_ = 7

		local var_245_0 = {
			zh = 7,
			ja = 6.366
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play318301061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.75

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(318301060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 30 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 30)

				if (30 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 30)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301060", "story_v_out_318301.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301060", "story_v_out_318301.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_318301", "318301060", "story_v_out_318301.awb")

						arg_245_1:RecordAudio("318301060", var_248_6)
						arg_245_1:RecordAudio("318301060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_318301", "318301060", "story_v_out_318301.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_318301", "318301060", "story_v_out_318301.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play318301061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 318301061
		arg_249_1.duration_ = 5.6

		local var_249_0 = {
			zh = 4.5,
			ja = 5.6
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play318301062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1150ui_story = arg_249_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).z)
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles = arg_249_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_249_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1150ui_story"].transform.position).z)
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1150ui_story"].transform.localEulerAngles = arg_249_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1150ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1150ui_story == nil then
				arg_249_1.var_.characterEffect1150ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1150ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1150ui_story then
				arg_249_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_4 = arg_249_1.actors_["1093ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1093ui_story = var_252_4.localPosition
			end

			local var_252_5 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 then
				var_252_4.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_5)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 then
				var_252_4.localPosition = Vector3.New(0, 100, 0)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			local var_252_6 = arg_249_1.actors_["1093ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1093ui_story == nil then
				arg_249_1.var_.characterEffect1093ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 and not isNil(var_252_6) then
				if arg_249_1.var_.characterEffect1093ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_7)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1093ui_story then
				arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_252_8 = 0
			local var_252_9 = 0.525

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(318301061)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 21 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 21)

				if (21 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 21)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301061", "story_v_out_318301.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301061", "story_v_out_318301.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_318301", "318301061", "story_v_out_318301.awb")

						arg_249_1:RecordAudio("318301061", var_252_15)
						arg_249_1:RecordAudio("318301061", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_318301", "318301061", "story_v_out_318301.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_318301", "318301061", "story_v_out_318301.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play318301062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 318301062
		arg_253_1.duration_ = 3.1

		local var_253_0 = {
			zh = 3.1,
			ja = 2.666
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play318301063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1093ui_story = arg_253_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1093ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1093ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_256_4 = arg_253_1.actors_["1150ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1150ui_story = var_256_4.localPosition
			end

			local var_256_5 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 then
				var_256_4.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_5)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 then
				var_256_4.localPosition = Vector3.New(0, 100, 0)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			local var_256_6 = arg_253_1.actors_["1150ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1150ui_story == nil then
				arg_253_1.var_.characterEffect1150ui_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_7 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 and not isNil(var_256_6) then
				if arg_253_1.var_.characterEffect1150ui_story and not isNil(var_256_6) then
					arg_253_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_7)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect1150ui_story then
				arg_253_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_256_8 = 0
			local var_256_9 = 0.2

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(318301062)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 8 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 8)

				if (8 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 8)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301062", "story_v_out_318301.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301062", "story_v_out_318301.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_318301", "318301062", "story_v_out_318301.awb")

						arg_253_1:RecordAudio("318301062", var_256_15)
						arg_253_1:RecordAudio("318301062", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_318301", "318301062", "story_v_out_318301.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_318301", "318301062", "story_v_out_318301.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play318301063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 318301063
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play318301064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if arg_257_1.bgs_.K13g == nil then
				local var_260_0 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K13g")
				var_260_0.name = "K13g"
				var_260_0.transform.parent = arg_257_1.stage_.transform
				var_260_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_.K13g = var_260_0
			end

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				local var_260_1 = arg_257_1.bgs_.K13g

				arg_257_1.bgs_.K13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_2 = var_260_1:GetComponent("SpriteRenderer")

				if var_260_2 and var_260_2.sprite then
					local var_260_3 = 2 * (var_260_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_1.transform.localScale = Vector3.New(var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "K13g" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_4 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_5 = 2

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_5 then
				local var_260_6 = Color.New(0, 0, 0)

				var_260_6.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_4) / var_260_5)
				arg_257_1.mask_.color = var_260_6
			end

			if arg_257_1.time_ >= var_260_4 + var_260_5 and arg_257_1.time_ < var_260_4 + var_260_5 + arg_260_0 then
				local var_260_7 = Color.New(0, 0, 0)

				var_260_7.a = 1
				arg_257_1.mask_.color = var_260_7
			end

			local var_260_8 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_9 = 2

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 then
				local var_260_10 = Color.New(0, 0, 0)

				var_260_10.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_8) / var_260_9)
				arg_257_1.mask_.color = var_260_10
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 then
				local var_260_11 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_11.a = 0
				arg_257_1.mask_.color = var_260_11
			end

			local var_260_12 = arg_257_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_257_1.time_ and arg_257_1.time_ <= 1.96599999815226 + arg_260_0 then
				arg_257_1.var_.moveOldPos1093ui_story = var_260_12.localPosition
			end

			local var_260_13 = 0.001

			if 1.96599999815226 <= arg_257_1.time_ and arg_257_1.time_ < 1.96599999815226 + var_260_13 then
				var_260_12.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 1.96599999815226) / var_260_13)
				var_260_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_12.position).x, (manager.ui.mainCamera.transform.position - var_260_12.position).y, (manager.ui.mainCamera.transform.position - var_260_12.position).z)
				var_260_12.localEulerAngles.z = 0
				var_260_12.localEulerAngles.x = 0
				var_260_12.localEulerAngles = var_260_12.localEulerAngles
			end

			if arg_257_1.time_ >= 1.96599999815226 + var_260_13 and arg_257_1.time_ < 1.96599999815226 + var_260_13 + arg_260_0 then
				var_260_12.localPosition = Vector3.New(0, 100, 0)
				var_260_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_12.position).x, (manager.ui.mainCamera.transform.position - var_260_12.position).y, (manager.ui.mainCamera.transform.position - var_260_12.position).z)
				var_260_12.localEulerAngles.z = 0
				var_260_12.localEulerAngles.x = 0
				var_260_12.localEulerAngles = var_260_12.localEulerAngles
			end

			local var_260_14 = arg_257_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_257_1.time_ and arg_257_1.time_ <= 1.96599999815226 + arg_260_0 and not isNil(var_260_14) and arg_257_1.var_.characterEffect1093ui_story == nil then
				arg_257_1.var_.characterEffect1093ui_story = var_260_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_15 = 0.034000001847744

			if 1.96599999815226 <= arg_257_1.time_ and arg_257_1.time_ < 1.96599999815226 + var_260_15 and not isNil(var_260_14) then
				if arg_257_1.var_.characterEffect1093ui_story and not isNil(var_260_14) then
					arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 1.96599999815226) / var_260_15)
				end
			end

			if arg_257_1.time_ >= 1.96599999815226 + var_260_15 and arg_257_1.time_ < 1.96599999815226 + var_260_15 + arg_260_0 and not isNil(var_260_14) and arg_257_1.var_.characterEffect1093ui_story then
				arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_16 = 4
			local var_260_17 = 0.625

			if 4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_18 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_18:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(318301063).content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 25 <= 0 and var_260_17 or var_260_17 * (utf8.len(var_260_19) / 25)

				if (25 <= 0 and var_260_17 or var_260_17 * (utf8.len(var_260_19) / 25)) > 0 and var_260_17 < var_260_21 then
					arg_257_1.talkMaxDuration = var_260_21
					var_260_16 = var_260_16 + 0.3

					if var_260_21 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_21 + var_260_16
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = var_260_16 + 0.3
			local var_260_23 = math.max(var_260_17, arg_257_1.talkMaxDuration)

			if var_260_16 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_22 + var_260_23 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_22) / var_260_23

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_22 + var_260_23 and arg_257_1.time_ < var_260_22 + var_260_23 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play318301064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318301064
		arg_263_1.duration_ = 1.97

		local var_263_0 = {
			zh = 1.633,
			ja = 1.966
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318301065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1093ui_story = arg_263_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).z)
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles = arg_263_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_263_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).z)
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles = arg_263_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1093ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1093ui_story == nil then
				arg_263_1.var_.characterEffect1093ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1093ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1093ui_story then
				arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_4 = 0
			local var_266_5 = 0.175

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(318301064)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 7 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 7)

				if (7 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 7)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301064", "story_v_out_318301.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301064", "story_v_out_318301.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_318301", "318301064", "story_v_out_318301.awb")

						arg_263_1:RecordAudio("318301064", var_266_11)
						arg_263_1:RecordAudio("318301064", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_318301", "318301064", "story_v_out_318301.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_318301", "318301064", "story_v_out_318301.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play318301065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318301065
		arg_267_1.duration_ = 5.1

		local var_267_0 = {
			zh = 4.3,
			ja = 5.1
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318301066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.45

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(318301065)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 18 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 18)

				if (18 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 18)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301065", "story_v_out_318301.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301065", "story_v_out_318301.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_318301", "318301065", "story_v_out_318301.awb")

						arg_267_1:RecordAudio("318301065", var_270_6)
						arg_267_1:RecordAudio("318301065", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_318301", "318301065", "story_v_out_318301.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_318301", "318301065", "story_v_out_318301.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play318301066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318301066
		arg_271_1.duration_ = 2.8

		local var_271_0 = {
			zh = 2.533,
			ja = 2.8
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318301067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_274_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_271_1.stage_.transform)

				var_274_0.name = "1015ui_story"
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["1015ui_story"] = var_274_0

				local var_274_1 = var_274_0:GetComponentInChildren(typeof(CharacterEffect))

				var_274_1.enabled = true

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end

				arg_271_1:ShowWeapon(var_274_1.transform, false)

				arg_271_1.var_["1015ui_story" .. "Animator"] = var_274_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_271_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_271_1.var_["1015ui_story" .. "LipSync"] = var_274_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_274_3 = arg_271_1.actors_["1015ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1015ui_story = var_274_3.localPosition
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_271_1.time_ - 0) / var_274_4)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			local var_274_5 = arg_271_1.actors_["1015ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1015ui_story == nil then
				arg_271_1.var_.characterEffect1015ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.characterEffect1015ui_story and not isNil(var_274_5) then
					arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1015ui_story then
				arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_8 = arg_271_1.actors_["1093ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1093ui_story = var_274_8.localPosition
			end

			local var_274_9 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_9 then
				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_9)
				var_274_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_8.position).x, (manager.ui.mainCamera.transform.position - var_274_8.position).y, (manager.ui.mainCamera.transform.position - var_274_8.position).z)
				var_274_8.localEulerAngles.z = 0
				var_274_8.localEulerAngles.x = 0
				var_274_8.localEulerAngles = var_274_8.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_9 and arg_271_1.time_ < 0 + var_274_9 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(0, 100, 0)
				var_274_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_8.position).x, (manager.ui.mainCamera.transform.position - var_274_8.position).y, (manager.ui.mainCamera.transform.position - var_274_8.position).z)
				var_274_8.localEulerAngles.z = 0
				var_274_8.localEulerAngles.x = 0
				var_274_8.localEulerAngles = var_274_8.localEulerAngles
			end

			local var_274_10 = arg_271_1.actors_["1093ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_10) and arg_271_1.var_.characterEffect1093ui_story == nil then
				arg_271_1.var_.characterEffect1093ui_story = var_274_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_11 and not isNil(var_274_10) then
				if arg_271_1.var_.characterEffect1093ui_story and not isNil(var_274_10) then
					arg_271_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_11)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_11 and arg_271_1.time_ < 0 + var_274_11 + arg_274_0 and not isNil(var_274_10) and arg_271_1.var_.characterEffect1093ui_story then
				arg_271_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_274_12 = 0
			local var_274_13 = 0.375

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_14 = arg_271_1:GetWordFromCfg(318301066)
				local var_274_15 = arg_271_1:FormatText(var_274_14.content)

				arg_271_1.text_.text = var_274_15

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 15 <= 0 and var_274_13 or var_274_13 * (utf8.len(var_274_15) / 15)

				if (15 <= 0 and var_274_13 or var_274_13 * (utf8.len(var_274_15) / 15)) > 0 and var_274_13 < var_274_17 then
					arg_271_1.talkMaxDuration = var_274_17

					if var_274_17 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_17 + var_274_12
					end
				end

				arg_271_1.text_.text = var_274_15
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301066", "story_v_out_318301.awb") ~= 0 then
					local var_274_18 = manager.audio:GetVoiceLength("story_v_out_318301", "318301066", "story_v_out_318301.awb") / 1000

					if var_274_18 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_18 + var_274_12
					end

					if var_274_14.prefab_name ~= "" and arg_271_1.actors_[var_274_14.prefab_name] ~= nil then
						local var_274_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_14.prefab_name].transform, "story_v_out_318301", "318301066", "story_v_out_318301.awb")

						arg_271_1:RecordAudio("318301066", var_274_19)
						arg_271_1:RecordAudio("318301066", var_274_19)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_318301", "318301066", "story_v_out_318301.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_318301", "318301066", "story_v_out_318301.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_20 = math.max(var_274_13, arg_271_1.talkMaxDuration)

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_20 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_12) / var_274_20

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_12 + var_274_20 and arg_271_1.time_ < var_274_12 + var_274_20 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play318301067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318301067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play318301068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1015ui_story = arg_275_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).z)
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles = arg_275_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1015ui_story"].transform.position).z)
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1015ui_story"].transform.localEulerAngles = arg_275_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1015ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1015ui_story == nil then
				arg_275_1.var_.characterEffect1015ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1015ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_2)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1015ui_story then
				arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_278_3 = 0
			local var_278_4 = 0.775

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_5 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(318301067).content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 31 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 31)

				if (31 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 31)) > 0 and var_278_4 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_3 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_3
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_4, arg_275_1.talkMaxDuration)

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_3) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_3 + var_278_8 and arg_275_1.time_ < var_278_3 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play318301068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318301068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318301069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.925

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(318301068).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 37 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 37)

				if (37 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 37)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play318301069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318301069
		arg_283_1.duration_ = 3.9

		local var_283_0 = {
			zh = 3.9,
			ja = 3.066
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play318301070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_286_0 = 0.6

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				local var_286_1, var_286_2 = math.modf((arg_283_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_286_2 * 0.13, var_286_2 * 0.13, var_286_2 * 0.13) + arg_283_1.var_.shakeOldPos
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				manager.ui.mainCamera.transform.localPosition = arg_283_1.var_.shakeOldPos
			end

			local var_286_3 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_3 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_3 + 0.6 and arg_283_1.time_ < var_286_3 + 0.6 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_4 = 0
			local var_286_5 = 0.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_6 = arg_283_1:GetWordFromCfg(318301069)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)

				if (7 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 7)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301069", "story_v_out_318301.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301069", "story_v_out_318301.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_318301", "318301069", "story_v_out_318301.awb")

						arg_283_1:RecordAudio("318301069", var_286_11)
						arg_283_1:RecordAudio("318301069", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_318301", "318301069", "story_v_out_318301.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_318301", "318301069", "story_v_out_318301.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play318301070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318301070
		arg_287_1.duration_ = 4.37

		local var_287_0 = {
			zh = 4.366,
			ja = 3.4
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play318301071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1093ui_story = arg_287_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).z)
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles = arg_287_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_287_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1093ui_story"].transform.position).z)
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1093ui_story"].transform.localEulerAngles = arg_287_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1093ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1093ui_story == nil then
				arg_287_1.var_.characterEffect1093ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1093ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1093ui_story then
				arg_287_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_4 = arg_287_1.actors_["1015ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1015ui_story = var_290_4.localPosition
			end

			local var_290_5 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 then
				var_290_4.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 0) / var_290_5)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 then
				var_290_4.localPosition = Vector3.New(0, 100, 0)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			local var_290_6 = arg_287_1.actors_["1015ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 and not isNil(var_290_6) then
				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_6) then
					arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_7)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1015ui_story then
				arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_290_8 = 0
			local var_290_9 = 0.55

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:GetWordFromCfg(318301070)
				local var_290_11 = arg_287_1:FormatText(var_290_10.content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 22 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 22)

				if (22 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 22)) > 0 and var_290_9 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301070", "story_v_out_318301.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301070", "story_v_out_318301.awb") / 1000

					if var_290_14 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_8
					end

					if var_290_10.prefab_name ~= "" and arg_287_1.actors_[var_290_10.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_10.prefab_name].transform, "story_v_out_318301", "318301070", "story_v_out_318301.awb")

						arg_287_1:RecordAudio("318301070", var_290_15)
						arg_287_1:RecordAudio("318301070", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_318301", "318301070", "story_v_out_318301.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_318301", "318301070", "story_v_out_318301.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_16 and arg_287_1.time_ < var_290_8 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play318301071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 318301071
		arg_291_1.duration_ = 5.23

		local var_291_0 = {
			zh = 3.266,
			ja = 5.233
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play318301072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.375

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(318301071)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 15 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 15)

				if (15 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 15)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301071", "story_v_out_318301.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301071", "story_v_out_318301.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_318301", "318301071", "story_v_out_318301.awb")

						arg_291_1:RecordAudio("318301071", var_294_6)
						arg_291_1:RecordAudio("318301071", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_318301", "318301071", "story_v_out_318301.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_318301", "318301071", "story_v_out_318301.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play318301072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 318301072
		arg_295_1.duration_ = 3

		local var_295_0 = {
			zh = 2.166,
			ja = 3
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play318301073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1015ui_story = arg_295_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).z)
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles = arg_295_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_295_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).z)
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles = arg_295_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1015ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1015ui_story == nil then
				arg_295_1.var_.characterEffect1015ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1015ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1015ui_story then
				arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = arg_295_1.actors_["1093ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1093ui_story = var_298_4.localPosition
			end

			local var_298_5 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_5 then
				var_298_4.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_5)
				var_298_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_4.position).x, (manager.ui.mainCamera.transform.position - var_298_4.position).y, (manager.ui.mainCamera.transform.position - var_298_4.position).z)
				var_298_4.localEulerAngles.z = 0
				var_298_4.localEulerAngles.x = 0
				var_298_4.localEulerAngles = var_298_4.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_5 and arg_295_1.time_ < 0 + var_298_5 + arg_298_0 then
				var_298_4.localPosition = Vector3.New(0, 100, 0)
				var_298_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_4.position).x, (manager.ui.mainCamera.transform.position - var_298_4.position).y, (manager.ui.mainCamera.transform.position - var_298_4.position).z)
				var_298_4.localEulerAngles.z = 0
				var_298_4.localEulerAngles.x = 0
				var_298_4.localEulerAngles = var_298_4.localEulerAngles
			end

			local var_298_6 = arg_295_1.actors_["1093ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1093ui_story == nil then
				arg_295_1.var_.characterEffect1093ui_story = var_298_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_7 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 and not isNil(var_298_6) then
				if arg_295_1.var_.characterEffect1093ui_story and not isNil(var_298_6) then
					arg_295_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_7)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1093ui_story then
				arg_295_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_298_8 = 0
			local var_298_9 = 0.1

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(318301072)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 4 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 4)

				if (4 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 4)) > 0 and var_298_9 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301072", "story_v_out_318301.awb") ~= 0 then
					local var_298_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301072", "story_v_out_318301.awb") / 1000

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end

					if var_298_10.prefab_name ~= "" and arg_295_1.actors_[var_298_10.prefab_name] ~= nil then
						local var_298_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_10.prefab_name].transform, "story_v_out_318301", "318301072", "story_v_out_318301.awb")

						arg_295_1:RecordAudio("318301072", var_298_15)
						arg_295_1:RecordAudio("318301072", var_298_15)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_318301", "318301072", "story_v_out_318301.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_318301", "318301072", "story_v_out_318301.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_16 and arg_295_1.time_ < var_298_8 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play318301073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 318301073
		arg_299_1.duration_ = 3.13

		local var_299_0 = {
			zh = 3.133,
			ja = 2.1
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play318301074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.325

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(318301073)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 13 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 13)

				if (13 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 13)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301073", "story_v_out_318301.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301073", "story_v_out_318301.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_318301", "318301073", "story_v_out_318301.awb")

						arg_299_1:RecordAudio("318301073", var_302_6)
						arg_299_1:RecordAudio("318301073", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_318301", "318301073", "story_v_out_318301.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_318301", "318301073", "story_v_out_318301.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play318301074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 318301074
		arg_303_1.duration_ = 5.03

		local var_303_0 = {
			zh = 3.9,
			ja = 5.033
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play318301075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1093ui_story = arg_303_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).z)
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles = arg_303_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_303_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1093ui_story"].transform.position).z)
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1093ui_story"].transform.localEulerAngles = arg_303_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1093ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1093ui_story == nil then
				arg_303_1.var_.characterEffect1093ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1093ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1093ui_story then
				arg_303_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_306_4 = arg_303_1.actors_["1015ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1015ui_story = var_306_4.localPosition
			end

			local var_306_5 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_5 then
				var_306_4.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_5)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_5 and arg_303_1.time_ < 0 + var_306_5 + arg_306_0 then
				var_306_4.localPosition = Vector3.New(0, 100, 0)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			local var_306_6 = arg_303_1.actors_["1015ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect1015ui_story == nil then
				arg_303_1.var_.characterEffect1015ui_story = var_306_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_7 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 and not isNil(var_306_6) then
				if arg_303_1.var_.characterEffect1015ui_story and not isNil(var_306_6) then
					arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_7)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect1015ui_story then
				arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_306_8 = 0
			local var_306_9 = 0.45

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(318301074)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 18 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 18)

				if (18 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 18)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301074", "story_v_out_318301.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301074", "story_v_out_318301.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_318301", "318301074", "story_v_out_318301.awb")

						arg_303_1:RecordAudio("318301074", var_306_15)
						arg_303_1:RecordAudio("318301074", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_318301", "318301074", "story_v_out_318301.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_318301", "318301074", "story_v_out_318301.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_16 and arg_303_1.time_ < var_306_8 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play318301075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 318301075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play318301076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1093ui_story = arg_307_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).z)
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles = arg_307_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1093ui_story"].transform.position).z)
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1093ui_story"].transform.localEulerAngles = arg_307_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1093ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1093ui_story == nil then
				arg_307_1.var_.characterEffect1093ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1093ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_2)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1093ui_story then
				arg_307_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_310_3 = 0
			local var_310_4 = 0.575

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_5 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(318301075).content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 23 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 23)

				if (23 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 23)) > 0 and var_310_4 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_3) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_8 and arg_307_1.time_ < var_310_3 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play318301076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 318301076
		arg_311_1.duration_ = 5.27

		local var_311_0 = {
			zh = 5.266,
			ja = 5
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play318301077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1093ui_story = arg_311_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).z)
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles = arg_311_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_311_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1093ui_story"].transform.position).z)
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1093ui_story"].transform.localEulerAngles = arg_311_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1093ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1093ui_story == nil then
				arg_311_1.var_.characterEffect1093ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1093ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1093ui_story then
				arg_311_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_314_4 = 0
			local var_314_5 = 0.6

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(318301076)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 24 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 24)

				if (24 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 24)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301076", "story_v_out_318301.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301076", "story_v_out_318301.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_out_318301", "318301076", "story_v_out_318301.awb")

						arg_311_1:RecordAudio("318301076", var_314_11)
						arg_311_1:RecordAudio("318301076", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_318301", "318301076", "story_v_out_318301.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_318301", "318301076", "story_v_out_318301.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play318301077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 318301077
		arg_315_1.duration_ = 4.77

		local var_315_0 = {
			zh = 4.766,
			ja = 2.966
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play318301078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(318301077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 22 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 22)

				if (22 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 22)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301077", "story_v_out_318301.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301077", "story_v_out_318301.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_318301", "318301077", "story_v_out_318301.awb")

						arg_315_1:RecordAudio("318301077", var_318_6)
						arg_315_1:RecordAudio("318301077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_318301", "318301077", "story_v_out_318301.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_318301", "318301077", "story_v_out_318301.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play318301078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 318301078
		arg_319_1.duration_ = 4.2

		local var_319_0 = {
			zh = 2.4,
			ja = 4.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play318301079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_0 = 0
			local var_322_1 = 0.275

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(318301078)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 11 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 11)

				if (11 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 11)) > 0 and var_322_1 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301078", "story_v_out_318301.awb") ~= 0 then
					local var_322_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301078", "story_v_out_318301.awb") / 1000

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end

					if var_322_2.prefab_name ~= "" and arg_319_1.actors_[var_322_2.prefab_name] ~= nil then
						local var_322_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_2.prefab_name].transform, "story_v_out_318301", "318301078", "story_v_out_318301.awb")

						arg_319_1:RecordAudio("318301078", var_322_7)
						arg_319_1:RecordAudio("318301078", var_322_7)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_318301", "318301078", "story_v_out_318301.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_318301", "318301078", "story_v_out_318301.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play318301079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 318301079
		arg_323_1.duration_ = 5.7

		local var_323_0 = {
			zh = 5.7,
			ja = 4.7
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play318301080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1015ui_story = arg_323_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).z)
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles = arg_323_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_323_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).z)
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles = arg_323_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1015ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1015ui_story == nil then
				arg_323_1.var_.characterEffect1015ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1015ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1015ui_story then
				arg_323_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_4 = arg_323_1.actors_["1093ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1093ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, 100, 0)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			local var_326_6 = arg_323_1.actors_["1093ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1093ui_story == nil then
				arg_323_1.var_.characterEffect1093ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_7 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 and not isNil(var_326_6) then
				if arg_323_1.var_.characterEffect1093ui_story and not isNil(var_326_6) then
					arg_323_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_7)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1093ui_story then
				arg_323_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_326_8 = 0
			local var_326_9 = 0.525

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(318301079)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 21 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 21)

				if (21 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 21)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301079", "story_v_out_318301.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301079", "story_v_out_318301.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_318301", "318301079", "story_v_out_318301.awb")

						arg_323_1:RecordAudio("318301079", var_326_15)
						arg_323_1:RecordAudio("318301079", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_318301", "318301079", "story_v_out_318301.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_318301", "318301079", "story_v_out_318301.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play318301080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 318301080
		arg_327_1.duration_ = 6

		local var_327_0 = {
			zh = 4.3,
			ja = 6
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play318301081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1093ui_story = arg_327_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).z)
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles = arg_327_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_327_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1093ui_story"].transform.position).z)
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1093ui_story"].transform.localEulerAngles = arg_327_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["1093ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1093ui_story == nil then
				arg_327_1.var_.characterEffect1093ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect1093ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect1093ui_story then
				arg_327_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_4 = arg_327_1.actors_["1015ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1015ui_story = var_330_4.localPosition
			end

			local var_330_5 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_5 then
				var_330_4.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_5)
				var_330_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_4.position).x, (manager.ui.mainCamera.transform.position - var_330_4.position).y, (manager.ui.mainCamera.transform.position - var_330_4.position).z)
				var_330_4.localEulerAngles.z = 0
				var_330_4.localEulerAngles.x = 0
				var_330_4.localEulerAngles = var_330_4.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_5 and arg_327_1.time_ < 0 + var_330_5 + arg_330_0 then
				var_330_4.localPosition = Vector3.New(0, 100, 0)
				var_330_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_4.position).x, (manager.ui.mainCamera.transform.position - var_330_4.position).y, (manager.ui.mainCamera.transform.position - var_330_4.position).z)
				var_330_4.localEulerAngles.z = 0
				var_330_4.localEulerAngles.x = 0
				var_330_4.localEulerAngles = var_330_4.localEulerAngles
			end

			local var_330_6 = arg_327_1.actors_["1015ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect1015ui_story == nil then
				arg_327_1.var_.characterEffect1015ui_story = var_330_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_7 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 and not isNil(var_330_6) then
				if arg_327_1.var_.characterEffect1015ui_story and not isNil(var_330_6) then
					arg_327_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_7)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 and not isNil(var_330_6) and arg_327_1.var_.characterEffect1015ui_story then
				arg_327_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_330_8 = 0
			local var_330_9 = 0.475

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(318301080)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 19 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 19)

				if (19 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 19)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301080", "story_v_out_318301.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301080", "story_v_out_318301.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_318301", "318301080", "story_v_out_318301.awb")

						arg_327_1:RecordAudio("318301080", var_330_15)
						arg_327_1:RecordAudio("318301080", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_318301", "318301080", "story_v_out_318301.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_318301", "318301080", "story_v_out_318301.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play318301081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 318301081
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play318301082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if arg_331_1.bgs_.ST06 == nil then
				local var_334_0 = Object.Instantiate(arg_331_1.paintGo_)

				var_334_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_334_0.name = "ST06"
				var_334_0.transform.parent = arg_331_1.stage_.transform
				var_334_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.bgs_.ST06 = var_334_0
			end

			if 2 < arg_331_1.time_ and arg_331_1.time_ <= 2 + arg_334_0 then
				local var_334_1 = arg_331_1.bgs_.ST06

				arg_331_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_334_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_2 = var_334_1:GetComponent("SpriteRenderer")

				if var_334_2 and var_334_2.sprite then
					local var_334_3 = 2 * (var_334_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_334_1.transform.localScale = Vector3.New(var_334_3 / var_334_2.sprite.bounds.size.y < var_334_3 * manager.ui.mainCameraCom_.aspect / var_334_2.sprite.bounds.size.x and var_334_3 * manager.ui.mainCameraCom_.aspect / var_334_2.sprite.bounds.size.x or var_334_3 / var_334_2.sprite.bounds.size.y, var_334_3 / var_334_2.sprite.bounds.size.y < var_334_3 * manager.ui.mainCameraCom_.aspect / var_334_2.sprite.bounds.size.x and var_334_3 * manager.ui.mainCameraCom_.aspect / var_334_2.sprite.bounds.size.x or var_334_3 / var_334_2.sprite.bounds.size.y, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "ST06" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_4 = 0

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_5 = 2

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_5 then
				local var_334_6 = Color.New(0, 0, 0)

				var_334_6.a = Mathf.Lerp(0, 1, (arg_331_1.time_ - var_334_4) / var_334_5)
				arg_331_1.mask_.color = var_334_6
			end

			if arg_331_1.time_ >= var_334_4 + var_334_5 and arg_331_1.time_ < var_334_4 + var_334_5 + arg_334_0 then
				local var_334_7 = Color.New(0, 0, 0)

				var_334_7.a = 1
				arg_331_1.mask_.color = var_334_7
			end

			local var_334_8 = 2

			if 2 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_9 = 2

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 then
				local var_334_10 = Color.New(0, 0, 0)

				var_334_10.a = Mathf.Lerp(1, 0, (arg_331_1.time_ - var_334_8) / var_334_9)
				arg_331_1.mask_.color = var_334_10
			end

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 then
				local var_334_11 = Color.New(0, 0, 0)

				arg_331_1.mask_.enabled = false
				var_334_11.a = 0
				arg_331_1.mask_.color = var_334_11
			end

			local var_334_12 = arg_331_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_331_1.time_ and arg_331_1.time_ <= 1.96599999815226 + arg_334_0 then
				arg_331_1.var_.moveOldPos1093ui_story = var_334_12.localPosition
			end

			local var_334_13 = 0.001

			if 1.96599999815226 <= arg_331_1.time_ and arg_331_1.time_ < 1.96599999815226 + var_334_13 then
				var_334_12.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 1.96599999815226) / var_334_13)
				var_334_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_12.position).x, (manager.ui.mainCamera.transform.position - var_334_12.position).y, (manager.ui.mainCamera.transform.position - var_334_12.position).z)
				var_334_12.localEulerAngles.z = 0
				var_334_12.localEulerAngles.x = 0
				var_334_12.localEulerAngles = var_334_12.localEulerAngles
			end

			if arg_331_1.time_ >= 1.96599999815226 + var_334_13 and arg_331_1.time_ < 1.96599999815226 + var_334_13 + arg_334_0 then
				var_334_12.localPosition = Vector3.New(0, 100, 0)
				var_334_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_12.position).x, (manager.ui.mainCamera.transform.position - var_334_12.position).y, (manager.ui.mainCamera.transform.position - var_334_12.position).z)
				var_334_12.localEulerAngles.z = 0
				var_334_12.localEulerAngles.x = 0
				var_334_12.localEulerAngles = var_334_12.localEulerAngles
			end

			local var_334_14 = arg_331_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_331_1.time_ and arg_331_1.time_ <= 1.96599999815226 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.characterEffect1093ui_story == nil then
				arg_331_1.var_.characterEffect1093ui_story = var_334_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_15 = 0.034000001847744

			if 1.96599999815226 <= arg_331_1.time_ and arg_331_1.time_ < 1.96599999815226 + var_334_15 and not isNil(var_334_14) then
				if arg_331_1.var_.characterEffect1093ui_story and not isNil(var_334_14) then
					arg_331_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 1.96599999815226) / var_334_15)
				end
			end

			if arg_331_1.time_ >= 1.96599999815226 + var_334_15 and arg_331_1.time_ < 1.96599999815226 + var_334_15 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.characterEffect1093ui_story then
				arg_331_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_16 = 4
			local var_334_17 = 0.9

			if 4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_18 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_18:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_19 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(318301081).content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_21 = 36 <= 0 and var_334_17 or var_334_17 * (utf8.len(var_334_19) / 36)

				if (36 <= 0 and var_334_17 or var_334_17 * (utf8.len(var_334_19) / 36)) > 0 and var_334_17 < var_334_21 then
					arg_331_1.talkMaxDuration = var_334_21
					var_334_16 = var_334_16 + 0.3

					if var_334_21 + var_334_16 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_21 + var_334_16
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_22 = var_334_16 + 0.3
			local var_334_23 = math.max(var_334_17, arg_331_1.talkMaxDuration)

			if var_334_16 + 0.3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_22 + var_334_23 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_22) / var_334_23

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_22 + var_334_23 and arg_331_1.time_ < var_334_22 + var_334_23 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play318301082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 318301082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play318301083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.225

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(318301082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 49 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 49)

				if (49 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 49)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play318301083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 318301083
		arg_341_1.duration_ = 4.43

		local var_341_0 = {
			zh = 3.633,
			ja = 4.433
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play318301084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1049ui_story = arg_341_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).z)
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles = arg_341_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_341_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1049ui_story"].transform.position).z)
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1049ui_story"].transform.localEulerAngles = arg_341_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1049ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1049ui_story == nil then
				arg_341_1.var_.characterEffect1049ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1049ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1049ui_story then
				arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.2

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(318301083)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 8 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 8)

				if (8 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 8)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301083", "story_v_out_318301.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301083", "story_v_out_318301.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_318301", "318301083", "story_v_out_318301.awb")

						arg_341_1:RecordAudio("318301083", var_344_11)
						arg_341_1:RecordAudio("318301083", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_318301", "318301083", "story_v_out_318301.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_318301", "318301083", "story_v_out_318301.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play318301084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 318301084
		arg_345_1.duration_ = 4.43

		local var_345_0 = {
			zh = 3.166,
			ja = 4.433
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play318301085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if arg_345_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_348_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_345_1.stage_.transform)

				var_348_0.name = "10053ui_story"
				var_348_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["10053ui_story"] = var_348_0

				local var_348_1 = var_348_0:GetComponentInChildren(typeof(CharacterEffect))

				var_348_1.enabled = true

				local var_348_2 = GameObjectTools.GetOrAddComponent(var_348_0, typeof(DynamicBoneHelper))

				if var_348_2 then
					var_348_2:EnableDynamicBone(false)
				end

				arg_345_1:ShowWeapon(var_348_1.transform, false)

				arg_345_1.var_["10053ui_story" .. "Animator"] = var_348_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_345_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_345_1.var_["10053ui_story" .. "LipSync"] = var_348_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_348_3 = arg_345_1.actors_["10053ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10053ui_story = var_348_3.localPosition
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_3.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_345_1.time_ - 0) / var_348_4)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			local var_348_5 = arg_345_1.actors_["10053ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.characterEffect10053ui_story == nil then
				arg_345_1.var_.characterEffect10053ui_story = var_348_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_6 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 and not isNil(var_348_5) then
				if arg_345_1.var_.characterEffect10053ui_story and not isNil(var_348_5) then
					arg_345_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.characterEffect10053ui_story then
				arg_345_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_8 = arg_345_1.actors_["1049ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1049ui_story = var_348_8.localPosition
			end

			local var_348_9 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_9 then
				var_348_8.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_9)
				var_348_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_8.position).x, (manager.ui.mainCamera.transform.position - var_348_8.position).y, (manager.ui.mainCamera.transform.position - var_348_8.position).z)
				var_348_8.localEulerAngles.z = 0
				var_348_8.localEulerAngles.x = 0
				var_348_8.localEulerAngles = var_348_8.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_9 and arg_345_1.time_ < 0 + var_348_9 + arg_348_0 then
				var_348_8.localPosition = Vector3.New(0, 100, 0)
				var_348_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_8.position).x, (manager.ui.mainCamera.transform.position - var_348_8.position).y, (manager.ui.mainCamera.transform.position - var_348_8.position).z)
				var_348_8.localEulerAngles.z = 0
				var_348_8.localEulerAngles.x = 0
				var_348_8.localEulerAngles = var_348_8.localEulerAngles
			end

			local var_348_10 = arg_345_1.actors_["1049ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_10) and arg_345_1.var_.characterEffect1049ui_story == nil then
				arg_345_1.var_.characterEffect1049ui_story = var_348_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_11 and not isNil(var_348_10) then
				if arg_345_1.var_.characterEffect1049ui_story and not isNil(var_348_10) then
					arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_11)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_11 and arg_345_1.time_ < 0 + var_348_11 + arg_348_0 and not isNil(var_348_10) and arg_345_1.var_.characterEffect1049ui_story then
				arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_348_12 = 0
			local var_348_13 = 0.325

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_12 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_14 = arg_345_1:GetWordFromCfg(318301084)
				local var_348_15 = arg_345_1:FormatText(var_348_14.content)

				arg_345_1.text_.text = var_348_15

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_17 = 13 <= 0 and var_348_13 or var_348_13 * (utf8.len(var_348_15) / 13)

				if (13 <= 0 and var_348_13 or var_348_13 * (utf8.len(var_348_15) / 13)) > 0 and var_348_13 < var_348_17 then
					arg_345_1.talkMaxDuration = var_348_17

					if var_348_17 + var_348_12 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_17 + var_348_12
					end
				end

				arg_345_1.text_.text = var_348_15
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301084", "story_v_out_318301.awb") ~= 0 then
					local var_348_18 = manager.audio:GetVoiceLength("story_v_out_318301", "318301084", "story_v_out_318301.awb") / 1000

					if var_348_18 + var_348_12 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_18 + var_348_12
					end

					if var_348_14.prefab_name ~= "" and arg_345_1.actors_[var_348_14.prefab_name] ~= nil then
						local var_348_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_14.prefab_name].transform, "story_v_out_318301", "318301084", "story_v_out_318301.awb")

						arg_345_1:RecordAudio("318301084", var_348_19)
						arg_345_1:RecordAudio("318301084", var_348_19)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_318301", "318301084", "story_v_out_318301.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_318301", "318301084", "story_v_out_318301.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_20 = math.max(var_348_13, arg_345_1.talkMaxDuration)

			if var_348_12 <= arg_345_1.time_ and arg_345_1.time_ < var_348_12 + var_348_20 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_12) / var_348_20

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_12 + var_348_20 and arg_345_1.time_ < var_348_12 + var_348_20 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play318301085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 318301085
		arg_349_1.duration_ = 5.93

		local var_349_0 = {
			zh = 4.233,
			ja = 5.933
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play318301086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1049ui_story = arg_349_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).z)
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles = arg_349_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_349_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1049ui_story"].transform.position).z)
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1049ui_story"].transform.localEulerAngles = arg_349_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1049ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1049ui_story == nil then
				arg_349_1.var_.characterEffect1049ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1049ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1049ui_story then
				arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = arg_349_1.actors_["10053ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10053ui_story = var_352_4.localPosition
			end

			local var_352_5 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_5 then
				var_352_4.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_5)
				var_352_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_4.position).x, (manager.ui.mainCamera.transform.position - var_352_4.position).y, (manager.ui.mainCamera.transform.position - var_352_4.position).z)
				var_352_4.localEulerAngles.z = 0
				var_352_4.localEulerAngles.x = 0
				var_352_4.localEulerAngles = var_352_4.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_5 and arg_349_1.time_ < 0 + var_352_5 + arg_352_0 then
				var_352_4.localPosition = Vector3.New(0, 100, 0)
				var_352_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_4.position).x, (manager.ui.mainCamera.transform.position - var_352_4.position).y, (manager.ui.mainCamera.transform.position - var_352_4.position).z)
				var_352_4.localEulerAngles.z = 0
				var_352_4.localEulerAngles.x = 0
				var_352_4.localEulerAngles = var_352_4.localEulerAngles
			end

			local var_352_6 = arg_349_1.actors_["10053ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_6) and arg_349_1.var_.characterEffect10053ui_story == nil then
				arg_349_1.var_.characterEffect10053ui_story = var_352_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_7 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 and not isNil(var_352_6) then
				if arg_349_1.var_.characterEffect10053ui_story and not isNil(var_352_6) then
					arg_349_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_7)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 and not isNil(var_352_6) and arg_349_1.var_.characterEffect10053ui_story then
				arg_349_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_352_8 = 0
			local var_352_9 = 0.5

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(318301085)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_13 = 20 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 20)

				if (20 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 20)) > 0 and var_352_9 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301085", "story_v_out_318301.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301085", "story_v_out_318301.awb") / 1000

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end

					if var_352_10.prefab_name ~= "" and arg_349_1.actors_[var_352_10.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_10.prefab_name].transform, "story_v_out_318301", "318301085", "story_v_out_318301.awb")

						arg_349_1:RecordAudio("318301085", var_352_15)
						arg_349_1:RecordAudio("318301085", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_318301", "318301085", "story_v_out_318301.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_318301", "318301085", "story_v_out_318301.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_16 and arg_349_1.time_ < var_352_8 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play318301086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 318301086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play318301087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1049ui_story = arg_353_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).z)
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles = arg_353_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1049ui_story"].transform.position).z)
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1049ui_story"].transform.localEulerAngles = arg_353_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1049ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1049ui_story == nil then
				arg_353_1.var_.characterEffect1049ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1049ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_2)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1049ui_story then
				arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_356_3 = 0
			local var_356_4 = 1.75

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_3 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_5 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(318301086).content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 70 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_5) / 70)

				if (70 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_5) / 70)) > 0 and var_356_4 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_3 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_3
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_4, arg_353_1.talkMaxDuration)

			if var_356_3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_3 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_3) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_3 + var_356_8 and arg_353_1.time_ < var_356_3 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play318301087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 318301087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play318301088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.825

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(318301087).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 33 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 33)

				if (33 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 33)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play318301088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 318301088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play318301089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.775

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(318301088).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 31 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 31)

				if (31 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 31)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play318301089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 318301089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play318301090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.725

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(318301089).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 29 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 29)

				if (29 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 29)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play318301090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 318301090
		arg_369_1.duration_ = 3.4

		local var_369_0 = {
			zh = 3.4,
			ja = 2.5
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play318301091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10053ui_story = arg_369_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).z)
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles = arg_369_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_369_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["10053ui_story"].transform.position).z)
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["10053ui_story"].transform.localEulerAngles = arg_369_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["10053ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect10053ui_story == nil then
				arg_369_1.var_.characterEffect10053ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect10053ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect10053ui_story then
				arg_369_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_4 = 0
			local var_372_5 = 0.275

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:GetWordFromCfg(318301090)
				local var_372_7 = arg_369_1:FormatText(var_372_6.content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 11 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 11)

				if (11 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 11)) > 0 and var_372_5 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301090", "story_v_out_318301.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301090", "story_v_out_318301.awb") / 1000

					if var_372_10 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_4
					end

					if var_372_6.prefab_name ~= "" and arg_369_1.actors_[var_372_6.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_6.prefab_name].transform, "story_v_out_318301", "318301090", "story_v_out_318301.awb")

						arg_369_1:RecordAudio("318301090", var_372_11)
						arg_369_1:RecordAudio("318301090", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_318301", "318301090", "story_v_out_318301.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_318301", "318301090", "story_v_out_318301.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_12 and arg_369_1.time_ < var_372_4 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play318301091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 318301091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play318301092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10053ui_story = arg_373_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).z)
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles = arg_373_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10053ui_story"].transform.position).z)
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10053ui_story"].transform.localEulerAngles = arg_373_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10053ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10053ui_story == nil then
				arg_373_1.var_.characterEffect10053ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10053ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_2)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10053ui_story then
				arg_373_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_376_3 = 0
			local var_376_4 = 0.875

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_5 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(318301091).content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 35 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 35)

				if (35 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 35)) > 0 and var_376_4 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_3 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_3
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_4, arg_373_1.talkMaxDuration)

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_3) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_3 + var_376_8 and arg_373_1.time_ < var_376_3 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play318301092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 318301092
		arg_377_1.duration_ = 10.07

		local var_377_0 = {
			zh = 5.2,
			ja = 10.066
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play318301093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1049ui_story = arg_377_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).z)
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles = arg_377_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_377_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1049ui_story"].transform.position).z)
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1049ui_story"].transform.localEulerAngles = arg_377_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1049ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1049ui_story == nil then
				arg_377_1.var_.characterEffect1049ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1049ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1049ui_story then
				arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.45

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(318301092)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 18 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 18)

				if (18 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 18)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301092", "story_v_out_318301.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301092", "story_v_out_318301.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_out_318301", "318301092", "story_v_out_318301.awb")

						arg_377_1:RecordAudio("318301092", var_380_11)
						arg_377_1:RecordAudio("318301092", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_318301", "318301092", "story_v_out_318301.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_318301", "318301092", "story_v_out_318301.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play318301093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 318301093
		arg_381_1.duration_ = 5.4

		local var_381_0 = {
			zh = 5.4,
			ja = 4.266
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play318301094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.475

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:GetWordFromCfg(318301093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 19 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 19)

				if (19 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 19)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301093", "story_v_out_318301.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301093", "story_v_out_318301.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_318301", "318301093", "story_v_out_318301.awb")

						arg_381_1:RecordAudio("318301093", var_384_6)
						arg_381_1:RecordAudio("318301093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_318301", "318301093", "story_v_out_318301.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_318301", "318301093", "story_v_out_318301.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play318301094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 318301094
		arg_385_1.duration_ = 9

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play318301095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if arg_385_1.bgs_.K02f == nil then
				local var_388_0 = Object.Instantiate(arg_385_1.paintGo_)

				var_388_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K02f")
				var_388_0.name = "K02f"
				var_388_0.transform.parent = arg_385_1.stage_.transform
				var_388_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.bgs_.K02f = var_388_0
			end

			if 2 < arg_385_1.time_ and arg_385_1.time_ <= 2 + arg_388_0 then
				local var_388_1 = arg_385_1.bgs_.K02f

				arg_385_1.bgs_.K02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_388_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_388_2 = var_388_1:GetComponent("SpriteRenderer")

				if var_388_2 and var_388_2.sprite then
					local var_388_3 = 2 * (var_388_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_388_1.transform.localScale = Vector3.New(var_388_3 / var_388_2.sprite.bounds.size.y < var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x and var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x or var_388_3 / var_388_2.sprite.bounds.size.y, var_388_3 / var_388_2.sprite.bounds.size.y < var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x and var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x or var_388_3 / var_388_2.sprite.bounds.size.y, 0)
				end

				for iter_388_0, iter_388_1 in pairs(arg_385_1.bgs_) do
					if iter_388_0 ~= "K02f" then
						iter_388_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_388_4 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_5 = 2

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_5 then
				local var_388_6 = Color.New(0, 0, 0)

				var_388_6.a = Mathf.Lerp(0, 1, (arg_385_1.time_ - var_388_4) / var_388_5)
				arg_385_1.mask_.color = var_388_6
			end

			if arg_385_1.time_ >= var_388_4 + var_388_5 and arg_385_1.time_ < var_388_4 + var_388_5 + arg_388_0 then
				local var_388_7 = Color.New(0, 0, 0)

				var_388_7.a = 1
				arg_385_1.mask_.color = var_388_7
			end

			local var_388_8 = 2

			if 2 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_9 = 2

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 then
				local var_388_10 = Color.New(0, 0, 0)

				var_388_10.a = Mathf.Lerp(1, 0, (arg_385_1.time_ - var_388_8) / var_388_9)
				arg_385_1.mask_.color = var_388_10
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 then
				local var_388_11 = Color.New(0, 0, 0)

				arg_385_1.mask_.enabled = false
				var_388_11.a = 0
				arg_385_1.mask_.color = var_388_11
			end

			local var_388_12 = arg_385_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_385_1.time_ and arg_385_1.time_ <= 1.96599999815226 + arg_388_0 then
				arg_385_1.var_.moveOldPos1049ui_story = var_388_12.localPosition
			end

			local var_388_13 = 0.001

			if 1.96599999815226 <= arg_385_1.time_ and arg_385_1.time_ < 1.96599999815226 + var_388_13 then
				var_388_12.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 1.96599999815226) / var_388_13)
				var_388_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_12.position).x, (manager.ui.mainCamera.transform.position - var_388_12.position).y, (manager.ui.mainCamera.transform.position - var_388_12.position).z)
				var_388_12.localEulerAngles.z = 0
				var_388_12.localEulerAngles.x = 0
				var_388_12.localEulerAngles = var_388_12.localEulerAngles
			end

			if arg_385_1.time_ >= 1.96599999815226 + var_388_13 and arg_385_1.time_ < 1.96599999815226 + var_388_13 + arg_388_0 then
				var_388_12.localPosition = Vector3.New(0, 100, 0)
				var_388_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_12.position).x, (manager.ui.mainCamera.transform.position - var_388_12.position).y, (manager.ui.mainCamera.transform.position - var_388_12.position).z)
				var_388_12.localEulerAngles.z = 0
				var_388_12.localEulerAngles.x = 0
				var_388_12.localEulerAngles = var_388_12.localEulerAngles
			end

			local var_388_14 = arg_385_1.actors_["1049ui_story"]

			if 1.96599999815226 < arg_385_1.time_ and arg_385_1.time_ <= 1.96599999815226 + arg_388_0 and not isNil(var_388_14) and arg_385_1.var_.characterEffect1049ui_story == nil then
				arg_385_1.var_.characterEffect1049ui_story = var_388_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_15 = 0.0166666666666667

			if 1.96599999815226 <= arg_385_1.time_ and arg_385_1.time_ < 1.96599999815226 + var_388_15 and not isNil(var_388_14) then
				if arg_385_1.var_.characterEffect1049ui_story and not isNil(var_388_14) then
					arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 1.96599999815226) / var_388_15)
				end
			end

			if arg_385_1.time_ >= 1.96599999815226 + var_388_15 and arg_385_1.time_ < 1.96599999815226 + var_388_15 + arg_388_0 and not isNil(var_388_14) and arg_385_1.var_.characterEffect1049ui_story then
				arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_16 = 4
			local var_388_17 = 0.5

			if 4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_16 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_18 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_18:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_385_1.dialogCg_.alpha = arg_389_0
				end))
				var_388_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_19 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(318301094).content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_21 = 20 <= 0 and var_388_17 or var_388_17 * (utf8.len(var_388_19) / 20)

				if (20 <= 0 and var_388_17 or var_388_17 * (utf8.len(var_388_19) / 20)) > 0 and var_388_17 < var_388_21 then
					arg_385_1.talkMaxDuration = var_388_21
					var_388_16 = var_388_16 + 0.3

					if var_388_21 + var_388_16 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_21 + var_388_16
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_22 = var_388_16 + 0.3
			local var_388_23 = math.max(var_388_17, arg_385_1.talkMaxDuration)

			if var_388_16 + 0.3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_22 + var_388_23 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_22) / var_388_23

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_22 + var_388_23 and arg_385_1.time_ < var_388_22 + var_388_23 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play318301095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 318301095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play318301096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.35

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(318301095).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 14 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 14)

				if (14 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 14)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play318301096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 318301096
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play318301097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.825

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(318301096).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 33 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 33)

				if (33 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 33)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play318301097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 318301097
		arg_399_1.duration_ = 2.53

		local var_399_0 = {
			zh = 2.5,
			ja = 2.533
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play318301098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if arg_399_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_402_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_399_1.stage_.transform)

				var_402_0.name = "1058ui_story"
				var_402_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.actors_["1058ui_story"] = var_402_0

				local var_402_1 = var_402_0:GetComponentInChildren(typeof(CharacterEffect))

				var_402_1.enabled = true

				local var_402_2 = GameObjectTools.GetOrAddComponent(var_402_0, typeof(DynamicBoneHelper))

				if var_402_2 then
					var_402_2:EnableDynamicBone(false)
				end

				arg_399_1:ShowWeapon(var_402_1.transform, false)

				arg_399_1.var_["1058ui_story" .. "Animator"] = var_402_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_399_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_399_1.var_["1058ui_story" .. "LipSync"] = var_402_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_402_3 = arg_399_1.actors_["1058ui_story"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1058ui_story = var_402_3.localPosition
			end

			local var_402_4 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				var_402_3.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_399_1.time_ - 0) / var_402_4)
				var_402_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_3.position).x, (manager.ui.mainCamera.transform.position - var_402_3.position).y, (manager.ui.mainCamera.transform.position - var_402_3.position).z)
				var_402_3.localEulerAngles.z = 0
				var_402_3.localEulerAngles.x = 0
				var_402_3.localEulerAngles = var_402_3.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				var_402_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_402_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_3.position).x, (manager.ui.mainCamera.transform.position - var_402_3.position).y, (manager.ui.mainCamera.transform.position - var_402_3.position).z)
				var_402_3.localEulerAngles.z = 0
				var_402_3.localEulerAngles.x = 0
				var_402_3.localEulerAngles = var_402_3.localEulerAngles
			end

			local var_402_5 = arg_399_1.actors_["1058ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.characterEffect1058ui_story == nil then
				arg_399_1.var_.characterEffect1058ui_story = var_402_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_6 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_6 and not isNil(var_402_5) then
				if arg_399_1.var_.characterEffect1058ui_story and not isNil(var_402_5) then
					arg_399_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_6 and arg_399_1.time_ < 0 + var_402_6 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.characterEffect1058ui_story then
				arg_399_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_8 = 0
			local var_402_9 = 0.225

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_8 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_10 = arg_399_1:GetWordFromCfg(318301097)
				local var_402_11 = arg_399_1:FormatText(var_402_10.content)

				arg_399_1.text_.text = var_402_11

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_13 = 9 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 9)

				if (9 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 9)) > 0 and var_402_9 < var_402_13 then
					arg_399_1.talkMaxDuration = var_402_13

					if var_402_13 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_13 + var_402_8
					end
				end

				arg_399_1.text_.text = var_402_11
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301097", "story_v_out_318301.awb") ~= 0 then
					local var_402_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301097", "story_v_out_318301.awb") / 1000

					if var_402_14 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_8
					end

					if var_402_10.prefab_name ~= "" and arg_399_1.actors_[var_402_10.prefab_name] ~= nil then
						local var_402_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_10.prefab_name].transform, "story_v_out_318301", "318301097", "story_v_out_318301.awb")

						arg_399_1:RecordAudio("318301097", var_402_15)
						arg_399_1:RecordAudio("318301097", var_402_15)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_318301", "318301097", "story_v_out_318301.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_318301", "318301097", "story_v_out_318301.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_9, arg_399_1.talkMaxDuration)

			if var_402_8 <= arg_399_1.time_ and arg_399_1.time_ < var_402_8 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_8) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_8 + var_402_16 and arg_399_1.time_ < var_402_8 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play318301098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 318301098
		arg_403_1.duration_ = 6.5

		local var_403_0 = {
			zh = 4.8,
			ja = 6.5
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play318301099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1058ui_story = arg_403_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).z)
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles = arg_403_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_403_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1058ui_story"].transform.position).z)
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1058ui_story"].transform.localEulerAngles = arg_403_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1058ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1058ui_story == nil then
				arg_403_1.var_.characterEffect1058ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1058ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1058ui_story then
				arg_403_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.5

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(318301098)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 20 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 20)

				if (20 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 20)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301098", "story_v_out_318301.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301098", "story_v_out_318301.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_out_318301", "318301098", "story_v_out_318301.awb")

						arg_403_1:RecordAudio("318301098", var_406_11)
						arg_403_1:RecordAudio("318301098", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_318301", "318301098", "story_v_out_318301.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_318301", "318301098", "story_v_out_318301.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play318301099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 318301099
		arg_407_1.duration_ = 3.7

		local var_407_0 = {
			zh = 3.6,
			ja = 3.7
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play318301100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_0 = 0
			local var_410_1 = 0.4

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(318301099)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 16 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 16)

				if (16 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 16)) > 0 and var_410_1 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301099", "story_v_out_318301.awb") ~= 0 then
					local var_410_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301099", "story_v_out_318301.awb") / 1000

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end

					if var_410_2.prefab_name ~= "" and arg_407_1.actors_[var_410_2.prefab_name] ~= nil then
						local var_410_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_2.prefab_name].transform, "story_v_out_318301", "318301099", "story_v_out_318301.awb")

						arg_407_1:RecordAudio("318301099", var_410_7)
						arg_407_1:RecordAudio("318301099", var_410_7)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_318301", "318301099", "story_v_out_318301.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_318301", "318301099", "story_v_out_318301.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_8 and arg_407_1.time_ < var_410_0 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play318301100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 318301100
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play318301101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1058ui_story = arg_411_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).z)
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles = arg_411_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_411_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1058ui_story"].transform.position).z)
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1058ui_story"].transform.localEulerAngles = arg_411_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1058ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1058ui_story == nil then
				arg_411_1.var_.characterEffect1058ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1058ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_2)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1058ui_story then
				arg_411_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_414_3 = 0
			local var_414_4 = 0.875

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_3 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_5 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(318301100).content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_7 = 35 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 35)

				if (35 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 35)) > 0 and var_414_4 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_3 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_3
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_4, arg_411_1.talkMaxDuration)

			if var_414_3 <= arg_411_1.time_ and arg_411_1.time_ < var_414_3 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_3) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_3 + var_414_8 and arg_411_1.time_ < var_414_3 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play318301101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 318301101
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play318301102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.875

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(318301101).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 35 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 35)

				if (35 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 35)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play318301102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 318301102
		arg_419_1.duration_ = 2

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play318301103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1058ui_story = arg_419_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).z)
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles = arg_419_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_419_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1058ui_story"].transform.position).z)
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1058ui_story"].transform.localEulerAngles = arg_419_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1058ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1058ui_story == nil then
				arg_419_1.var_.characterEffect1058ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1058ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1058ui_story then
				arg_419_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_422_4 = 0
			local var_422_5 = 0.125

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(318301102)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 5 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 5)

				if (5 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 5)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301102", "story_v_out_318301.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301102", "story_v_out_318301.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_out_318301", "318301102", "story_v_out_318301.awb")

						arg_419_1:RecordAudio("318301102", var_422_11)
						arg_419_1:RecordAudio("318301102", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_318301", "318301102", "story_v_out_318301.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_318301", "318301102", "story_v_out_318301.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play318301103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 318301103
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play318301104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1058ui_story = arg_423_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).z)
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles = arg_423_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1058ui_story"].transform.position).z)
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1058ui_story"].transform.localEulerAngles = arg_423_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1058ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1058ui_story == nil then
				arg_423_1.var_.characterEffect1058ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1058ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_2)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1058ui_story then
				arg_423_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_426_3 = 0
			local var_426_4 = 0.575

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_5 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(318301103).content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 23 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 23)

				if (23 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 23)) > 0 and var_426_4 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_3 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_3
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_4, arg_423_1.talkMaxDuration)

			if var_426_3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_3 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_3) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_3 + var_426_8 and arg_423_1.time_ < var_426_3 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play318301104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 318301104
		arg_427_1.duration_ = 2.7

		local var_427_0 = {
			zh = 2.6,
			ja = 2.7
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play318301105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1058ui_story = arg_427_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).z)
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles = arg_427_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_427_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1058ui_story"].transform.position).z)
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1058ui_story"].transform.localEulerAngles = arg_427_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1058ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1058ui_story == nil then
				arg_427_1.var_.characterEffect1058ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1058ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1058ui_story then
				arg_427_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_4 = 0
			local var_430_5 = 0.175

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(318301104)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 7 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 7)

				if (7 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 7)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301104", "story_v_out_318301.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301104", "story_v_out_318301.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_out_318301", "318301104", "story_v_out_318301.awb")

						arg_427_1:RecordAudio("318301104", var_430_11)
						arg_427_1:RecordAudio("318301104", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_318301", "318301104", "story_v_out_318301.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_318301", "318301104", "story_v_out_318301.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play318301105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 318301105
		arg_431_1.duration_ = 9

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play318301106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if arg_431_1.bgs_.K06g == nil then
				local var_434_0 = Object.Instantiate(arg_431_1.paintGo_)

				var_434_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06g")
				var_434_0.name = "K06g"
				var_434_0.transform.parent = arg_431_1.stage_.transform
				var_434_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.bgs_.K06g = var_434_0
			end

			if 2 < arg_431_1.time_ and arg_431_1.time_ <= 2 + arg_434_0 then
				local var_434_1 = arg_431_1.bgs_.K06g

				arg_431_1.bgs_.K06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_434_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_434_2 = var_434_1:GetComponent("SpriteRenderer")

				if var_434_2 and var_434_2.sprite then
					local var_434_3 = 2 * (var_434_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_434_1.transform.localScale = Vector3.New(var_434_3 / var_434_2.sprite.bounds.size.y < var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x and var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x or var_434_3 / var_434_2.sprite.bounds.size.y, var_434_3 / var_434_2.sprite.bounds.size.y < var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x and var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x or var_434_3 / var_434_2.sprite.bounds.size.y, 0)
				end

				for iter_434_0, iter_434_1 in pairs(arg_431_1.bgs_) do
					if iter_434_0 ~= "K06g" then
						iter_434_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_434_4 = 0

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_5 = 2

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_5 then
				local var_434_6 = Color.New(0, 0, 0)

				var_434_6.a = Mathf.Lerp(0, 1, (arg_431_1.time_ - var_434_4) / var_434_5)
				arg_431_1.mask_.color = var_434_6
			end

			if arg_431_1.time_ >= var_434_4 + var_434_5 and arg_431_1.time_ < var_434_4 + var_434_5 + arg_434_0 then
				local var_434_7 = Color.New(0, 0, 0)

				var_434_7.a = 1
				arg_431_1.mask_.color = var_434_7
			end

			local var_434_8 = 2

			if 2 < arg_431_1.time_ and arg_431_1.time_ <= var_434_8 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_9 = 2

			if var_434_8 <= arg_431_1.time_ and arg_431_1.time_ < var_434_8 + var_434_9 then
				local var_434_10 = Color.New(0, 0, 0)

				var_434_10.a = Mathf.Lerp(1, 0, (arg_431_1.time_ - var_434_8) / var_434_9)
				arg_431_1.mask_.color = var_434_10
			end

			if arg_431_1.time_ >= var_434_8 + var_434_9 and arg_431_1.time_ < var_434_8 + var_434_9 + arg_434_0 then
				local var_434_11 = Color.New(0, 0, 0)

				arg_431_1.mask_.enabled = false
				var_434_11.a = 0
				arg_431_1.mask_.color = var_434_11
			end

			local var_434_12 = arg_431_1.actors_["1058ui_story"].transform

			if 1.96599999815226 < arg_431_1.time_ and arg_431_1.time_ <= 1.96599999815226 + arg_434_0 then
				arg_431_1.var_.moveOldPos1058ui_story = var_434_12.localPosition
			end

			local var_434_13 = 0.001

			if 1.96599999815226 <= arg_431_1.time_ and arg_431_1.time_ < 1.96599999815226 + var_434_13 then
				var_434_12.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 1.96599999815226) / var_434_13)
				var_434_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_12.position).x, (manager.ui.mainCamera.transform.position - var_434_12.position).y, (manager.ui.mainCamera.transform.position - var_434_12.position).z)
				var_434_12.localEulerAngles.z = 0
				var_434_12.localEulerAngles.x = 0
				var_434_12.localEulerAngles = var_434_12.localEulerAngles
			end

			if arg_431_1.time_ >= 1.96599999815226 + var_434_13 and arg_431_1.time_ < 1.96599999815226 + var_434_13 + arg_434_0 then
				var_434_12.localPosition = Vector3.New(0, 100, 0)
				var_434_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_12.position).x, (manager.ui.mainCamera.transform.position - var_434_12.position).y, (manager.ui.mainCamera.transform.position - var_434_12.position).z)
				var_434_12.localEulerAngles.z = 0
				var_434_12.localEulerAngles.x = 0
				var_434_12.localEulerAngles = var_434_12.localEulerAngles
			end

			local var_434_14 = arg_431_1.actors_["1058ui_story"]

			if 1.96599999815226 < arg_431_1.time_ and arg_431_1.time_ <= 1.96599999815226 + arg_434_0 and not isNil(var_434_14) and arg_431_1.var_.characterEffect1058ui_story == nil then
				arg_431_1.var_.characterEffect1058ui_story = var_434_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_15 = 0.034000001847744

			if 1.96599999815226 <= arg_431_1.time_ and arg_431_1.time_ < 1.96599999815226 + var_434_15 and not isNil(var_434_14) then
				if arg_431_1.var_.characterEffect1058ui_story and not isNil(var_434_14) then
					arg_431_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 1.96599999815226) / var_434_15)
				end
			end

			if arg_431_1.time_ >= 1.96599999815226 + var_434_15 and arg_431_1.time_ < 1.96599999815226 + var_434_15 + arg_434_0 and not isNil(var_434_14) and arg_431_1.var_.characterEffect1058ui_story then
				arg_431_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			if 3.23333333333333 < arg_431_1.time_ and arg_431_1.time_ <= 3.23333333333333 + arg_434_0 then
				arg_431_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_17 = 4
			local var_434_18 = 1.35

			if 4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_17 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_19 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_19:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_20 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(318301105).content)

				arg_431_1.text_.text = var_434_20

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_22 = 54 <= 0 and var_434_18 or var_434_18 * (utf8.len(var_434_20) / 54)

				if (54 <= 0 and var_434_18 or var_434_18 * (utf8.len(var_434_20) / 54)) > 0 and var_434_18 < var_434_22 then
					arg_431_1.talkMaxDuration = var_434_22
					var_434_17 = var_434_17 + 0.3

					if var_434_22 + var_434_17 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_22 + var_434_17
					end
				end

				arg_431_1.text_.text = var_434_20
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_23 = var_434_17 + 0.3
			local var_434_24 = math.max(var_434_18, arg_431_1.talkMaxDuration)

			if var_434_17 + 0.3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_23 + var_434_24 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_23) / var_434_24

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_23 + var_434_24 and arg_431_1.time_ < var_434_23 + var_434_24 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play318301106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 318301106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play318301107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_firework", "")
			end

			local var_440_1 = 0
			local var_440_2 = 0.775

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(318301106).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 31 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 31)

				if (31 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 31)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play318301107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 318301107
		arg_441_1.duration_ = 4.7

		local var_441_0 = {
			zh = 3.2,
			ja = 4.7
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play318301108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1055ui_story = arg_441_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).z)
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles = arg_441_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_441_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1055ui_story"].transform.position).z)
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1055ui_story"].transform.localEulerAngles = arg_441_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1055ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1055ui_story == nil then
				arg_441_1.var_.characterEffect1055ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1055ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1055ui_story then
				arg_441_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_444_4 = 0
			local var_444_5 = 0.4

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(318301107)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 16 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 16)

				if (16 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 16)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301107", "story_v_out_318301.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301107", "story_v_out_318301.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_out_318301", "318301107", "story_v_out_318301.awb")

						arg_441_1:RecordAudio("318301107", var_444_11)
						arg_441_1:RecordAudio("318301107", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_318301", "318301107", "story_v_out_318301.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_318301", "318301107", "story_v_out_318301.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play318301108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 318301108
		arg_445_1.duration_ = 5.47

		local var_445_0 = {
			zh = 5.466,
			ja = 2.9
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play318301109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_448_0 = 0
			local var_448_1 = 0.45

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_2 = arg_445_1:GetWordFromCfg(318301108)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 18 <= 0 and var_448_1 or var_448_1 * (utf8.len(var_448_3) / 18)

				if (18 <= 0 and var_448_1 or var_448_1 * (utf8.len(var_448_3) / 18)) > 0 and var_448_1 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301108", "story_v_out_318301.awb") ~= 0 then
					local var_448_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301108", "story_v_out_318301.awb") / 1000

					if var_448_6 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_0
					end

					if var_448_2.prefab_name ~= "" and arg_445_1.actors_[var_448_2.prefab_name] ~= nil then
						local var_448_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_2.prefab_name].transform, "story_v_out_318301", "318301108", "story_v_out_318301.awb")

						arg_445_1:RecordAudio("318301108", var_448_7)
						arg_445_1:RecordAudio("318301108", var_448_7)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_318301", "318301108", "story_v_out_318301.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_318301", "318301108", "story_v_out_318301.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play318301109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 318301109
		arg_449_1.duration_ = 2.93

		local var_449_0 = {
			zh = 2.933,
			ja = 2.366
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play318301110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1049ui_story = arg_449_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).z)
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles = arg_449_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_449_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1049ui_story"].transform.position).z)
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1049ui_story"].transform.localEulerAngles = arg_449_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1049ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1049ui_story == nil then
				arg_449_1.var_.characterEffect1049ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1049ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1049ui_story then
				arg_449_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_4 = arg_449_1.actors_["1055ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1055ui_story = var_452_4.localPosition
			end

			local var_452_5 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_5 then
				var_452_4.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_449_1.time_ - 0) / var_452_5)
				var_452_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_4.position).x, (manager.ui.mainCamera.transform.position - var_452_4.position).y, (manager.ui.mainCamera.transform.position - var_452_4.position).z)
				var_452_4.localEulerAngles.z = 0
				var_452_4.localEulerAngles.x = 0
				var_452_4.localEulerAngles = var_452_4.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_5 and arg_449_1.time_ < 0 + var_452_5 + arg_452_0 then
				var_452_4.localPosition = Vector3.New(0, 100, 0)
				var_452_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_4.position).x, (manager.ui.mainCamera.transform.position - var_452_4.position).y, (manager.ui.mainCamera.transform.position - var_452_4.position).z)
				var_452_4.localEulerAngles.z = 0
				var_452_4.localEulerAngles.x = 0
				var_452_4.localEulerAngles = var_452_4.localEulerAngles
			end

			local var_452_6 = arg_449_1.actors_["1055ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_6) and arg_449_1.var_.characterEffect1055ui_story == nil then
				arg_449_1.var_.characterEffect1055ui_story = var_452_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_7 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 and not isNil(var_452_6) then
				if arg_449_1.var_.characterEffect1055ui_story and not isNil(var_452_6) then
					arg_449_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_7)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 and not isNil(var_452_6) and arg_449_1.var_.characterEffect1055ui_story then
				arg_449_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_452_8 = 0
			local var_452_9 = 0.175

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_8 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_10 = arg_449_1:GetWordFromCfg(318301109)
				local var_452_11 = arg_449_1:FormatText(var_452_10.content)

				arg_449_1.text_.text = var_452_11

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_13 = 7 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 7)

				if (7 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 7)) > 0 and var_452_9 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_8
					end
				end

				arg_449_1.text_.text = var_452_11
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301109", "story_v_out_318301.awb") ~= 0 then
					local var_452_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301109", "story_v_out_318301.awb") / 1000

					if var_452_14 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_14 + var_452_8
					end

					if var_452_10.prefab_name ~= "" and arg_449_1.actors_[var_452_10.prefab_name] ~= nil then
						local var_452_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_10.prefab_name].transform, "story_v_out_318301", "318301109", "story_v_out_318301.awb")

						arg_449_1:RecordAudio("318301109", var_452_15)
						arg_449_1:RecordAudio("318301109", var_452_15)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_318301", "318301109", "story_v_out_318301.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_318301", "318301109", "story_v_out_318301.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_16 = math.max(var_452_9, arg_449_1.talkMaxDuration)

			if var_452_8 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_16 and arg_449_1.time_ < var_452_8 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play318301110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 318301110
		arg_453_1.duration_ = 3.9

		local var_453_0 = {
			zh = 3.433,
			ja = 3.9
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play318301111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_456_0 = 0
			local var_456_1 = 0.325

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(318301110)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 13 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 13)

				if (13 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 13)) > 0 and var_456_1 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301110", "story_v_out_318301.awb") ~= 0 then
					local var_456_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301110", "story_v_out_318301.awb") / 1000

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end

					if var_456_2.prefab_name ~= "" and arg_453_1.actors_[var_456_2.prefab_name] ~= nil then
						local var_456_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_2.prefab_name].transform, "story_v_out_318301", "318301110", "story_v_out_318301.awb")

						arg_453_1:RecordAudio("318301110", var_456_7)
						arg_453_1:RecordAudio("318301110", var_456_7)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_318301", "318301110", "story_v_out_318301.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_318301", "318301110", "story_v_out_318301.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play318301111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 318301111
		arg_457_1.duration_ = 6.8

		local var_457_0 = {
			zh = 6.8,
			ja = 3.3
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play318301112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_460_0 = 0
			local var_460_1 = 0.475

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(318301111)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 19 <= 0 and var_460_1 or var_460_1 * (utf8.len(var_460_3) / 19)

				if (19 <= 0 and var_460_1 or var_460_1 * (utf8.len(var_460_3) / 19)) > 0 and var_460_1 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301111", "story_v_out_318301.awb") ~= 0 then
					local var_460_6 = manager.audio:GetVoiceLength("story_v_out_318301", "318301111", "story_v_out_318301.awb") / 1000

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end

					if var_460_2.prefab_name ~= "" and arg_457_1.actors_[var_460_2.prefab_name] ~= nil then
						local var_460_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_2.prefab_name].transform, "story_v_out_318301", "318301111", "story_v_out_318301.awb")

						arg_457_1:RecordAudio("318301111", var_460_7)
						arg_457_1:RecordAudio("318301111", var_460_7)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_318301", "318301111", "story_v_out_318301.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_318301", "318301111", "story_v_out_318301.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play318301112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 318301112
		arg_461_1.duration_ = 1

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"

			SetActive(arg_461_1.choicesGo_, true)

			for iter_462_0, iter_462_1 in ipairs(arg_461_1.choices_) do
				SetActive(iter_462_1.go, iter_462_0 <= 2)
			end

			arg_461_1.choices_[1].txt.text = arg_461_1:FormatText(StoryChoiceCfg[690].name)
			arg_461_1.choices_[2].txt.text = arg_461_1:FormatText(StoryChoiceCfg[691].name)
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play318301113(arg_461_1)
			end

			if arg_463_0 == 2 then
				arg_461_0:Play318301113(arg_461_1)
			end

			arg_461_1:RecordChoiceLog(318301112, 690, 691)
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1049ui_story = arg_461_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).z)
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles = arg_461_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_461_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).z)
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles = arg_461_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["1049ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1049ui_story == nil then
				arg_461_1.var_.characterEffect1049ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1049ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_2)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1049ui_story then
				arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_464_3 = 0

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_3 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			if arg_461_1.time_ >= var_464_3 + 0.5 and arg_461_1.time_ < var_464_3 + 0.5 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play318301113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 318301113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play318301114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.925

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(318301113).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 37 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 37)

				if (37 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 37)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play318301114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 318301114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play318301115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.375

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(318301114).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 15 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 15)

				if (15 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 15)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play318301115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 318301115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play318301116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.475

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(318301115).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 19 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 19)

				if (19 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 19)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play318301116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 318301116
		arg_477_1.duration_ = 5.7

		local var_477_0 = {
			zh = 2.3,
			ja = 5.7
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play318301117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1055ui_story = arg_477_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).z)
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles = arg_477_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_477_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1055ui_story"].transform.position).z)
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1055ui_story"].transform.localEulerAngles = arg_477_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1055ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1055ui_story == nil then
				arg_477_1.var_.characterEffect1055ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1055ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1055ui_story then
				arg_477_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_4 = arg_477_1.actors_["1049ui_story"].transform

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1049ui_story = var_480_4.localPosition
			end

			local var_480_5 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_5 then
				var_480_4.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 0) / var_480_5)
				var_480_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_4.position).x, (manager.ui.mainCamera.transform.position - var_480_4.position).y, (manager.ui.mainCamera.transform.position - var_480_4.position).z)
				var_480_4.localEulerAngles.z = 0
				var_480_4.localEulerAngles.x = 0
				var_480_4.localEulerAngles = var_480_4.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_5 and arg_477_1.time_ < 0 + var_480_5 + arg_480_0 then
				var_480_4.localPosition = Vector3.New(0, 100, 0)
				var_480_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_4.position).x, (manager.ui.mainCamera.transform.position - var_480_4.position).y, (manager.ui.mainCamera.transform.position - var_480_4.position).z)
				var_480_4.localEulerAngles.z = 0
				var_480_4.localEulerAngles.x = 0
				var_480_4.localEulerAngles = var_480_4.localEulerAngles
			end

			local var_480_6 = 0
			local var_480_7 = 0.275

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_8 = arg_477_1:GetWordFromCfg(318301116)
				local var_480_9 = arg_477_1:FormatText(var_480_8.content)

				arg_477_1.text_.text = var_480_9

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 11 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_9) / 11)

				if (11 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_9) / 11)) > 0 and var_480_7 < var_480_11 then
					arg_477_1.talkMaxDuration = var_480_11

					if var_480_11 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_11 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_9
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301116", "story_v_out_318301.awb") ~= 0 then
					local var_480_12 = manager.audio:GetVoiceLength("story_v_out_318301", "318301116", "story_v_out_318301.awb") / 1000

					if var_480_12 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_12 + var_480_6
					end

					if var_480_8.prefab_name ~= "" and arg_477_1.actors_[var_480_8.prefab_name] ~= nil then
						local var_480_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_8.prefab_name].transform, "story_v_out_318301", "318301116", "story_v_out_318301.awb")

						arg_477_1:RecordAudio("318301116", var_480_13)
						arg_477_1:RecordAudio("318301116", var_480_13)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_318301", "318301116", "story_v_out_318301.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_318301", "318301116", "story_v_out_318301.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play318301117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 318301117
		arg_481_1.duration_ = 10.9

		local var_481_0 = {
			zh = 7.866,
			ja = 10.9
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play318301118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if arg_481_1.bgs_.K07g == nil then
				local var_484_0 = Object.Instantiate(arg_481_1.paintGo_)

				var_484_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K07g")
				var_484_0.name = "K07g"
				var_484_0.transform.parent = arg_481_1.stage_.transform
				var_484_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.bgs_.K07g = var_484_0
			end

			if 2 < arg_481_1.time_ and arg_481_1.time_ <= 2 + arg_484_0 then
				local var_484_1 = arg_481_1.bgs_.K07g

				arg_481_1.bgs_.K07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_484_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_484_2 = var_484_1:GetComponent("SpriteRenderer")

				if var_484_2 and var_484_2.sprite then
					local var_484_3 = 2 * (var_484_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_484_1.transform.localScale = Vector3.New(var_484_3 / var_484_2.sprite.bounds.size.y < var_484_3 * manager.ui.mainCameraCom_.aspect / var_484_2.sprite.bounds.size.x and var_484_3 * manager.ui.mainCameraCom_.aspect / var_484_2.sprite.bounds.size.x or var_484_3 / var_484_2.sprite.bounds.size.y, var_484_3 / var_484_2.sprite.bounds.size.y < var_484_3 * manager.ui.mainCameraCom_.aspect / var_484_2.sprite.bounds.size.x and var_484_3 * manager.ui.mainCameraCom_.aspect / var_484_2.sprite.bounds.size.x or var_484_3 / var_484_2.sprite.bounds.size.y, 0)
				end

				for iter_484_0, iter_484_1 in pairs(arg_481_1.bgs_) do
					if iter_484_0 ~= "K07g" then
						iter_484_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_484_4 = 0

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_5 = 2

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_5 then
				local var_484_6 = Color.New(0, 0, 0)

				var_484_6.a = Mathf.Lerp(0, 1, (arg_481_1.time_ - var_484_4) / var_484_5)
				arg_481_1.mask_.color = var_484_6
			end

			if arg_481_1.time_ >= var_484_4 + var_484_5 and arg_481_1.time_ < var_484_4 + var_484_5 + arg_484_0 then
				local var_484_7 = Color.New(0, 0, 0)

				var_484_7.a = 1
				arg_481_1.mask_.color = var_484_7
			end

			local var_484_8 = 2

			if 2 < arg_481_1.time_ and arg_481_1.time_ <= var_484_8 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_9 = 2

			if var_484_8 <= arg_481_1.time_ and arg_481_1.time_ < var_484_8 + var_484_9 then
				local var_484_10 = Color.New(0, 0, 0)

				var_484_10.a = Mathf.Lerp(1, 0, (arg_481_1.time_ - var_484_8) / var_484_9)
				arg_481_1.mask_.color = var_484_10
			end

			if arg_481_1.time_ >= var_484_8 + var_484_9 and arg_481_1.time_ < var_484_8 + var_484_9 + arg_484_0 then
				local var_484_11 = Color.New(0, 0, 0)

				arg_481_1.mask_.enabled = false
				var_484_11.a = 0
				arg_481_1.mask_.color = var_484_11
			end

			local var_484_12 = arg_481_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_481_1.time_ and arg_481_1.time_ <= 1.96599999815226 + arg_484_0 then
				arg_481_1.var_.moveOldPos1015ui_story = var_484_12.localPosition
			end

			local var_484_13 = 0.001

			if 1.96599999815226 <= arg_481_1.time_ and arg_481_1.time_ < 1.96599999815226 + var_484_13 then
				var_484_12.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_481_1.time_ - 1.96599999815226) / var_484_13)
				var_484_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_12.position).x, (manager.ui.mainCamera.transform.position - var_484_12.position).y, (manager.ui.mainCamera.transform.position - var_484_12.position).z)
				var_484_12.localEulerAngles.z = 0
				var_484_12.localEulerAngles.x = 0
				var_484_12.localEulerAngles = var_484_12.localEulerAngles
			end

			if arg_481_1.time_ >= 1.96599999815226 + var_484_13 and arg_481_1.time_ < 1.96599999815226 + var_484_13 + arg_484_0 then
				var_484_12.localPosition = Vector3.New(0, -1.15, -6.2)
				var_484_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_12.position).x, (manager.ui.mainCamera.transform.position - var_484_12.position).y, (manager.ui.mainCamera.transform.position - var_484_12.position).z)
				var_484_12.localEulerAngles.z = 0
				var_484_12.localEulerAngles.x = 0
				var_484_12.localEulerAngles = var_484_12.localEulerAngles
			end

			local var_484_14 = arg_481_1.actors_["1015ui_story"]

			if 3.9 < arg_481_1.time_ and arg_481_1.time_ <= 3.9 + arg_484_0 and not isNil(var_484_14) and arg_481_1.var_.characterEffect1015ui_story == nil then
				arg_481_1.var_.characterEffect1015ui_story = var_484_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_15 = 0.200000002980232

			if 3.9 <= arg_481_1.time_ and arg_481_1.time_ < 3.9 + var_484_15 and not isNil(var_484_14) then
				if arg_481_1.var_.characterEffect1015ui_story and not isNil(var_484_14) then
					arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 3.9 + var_484_15 and arg_481_1.time_ < 3.9 + var_484_15 + arg_484_0 and not isNil(var_484_14) and arg_481_1.var_.characterEffect1015ui_story then
				arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 3.9 < arg_481_1.time_ and arg_481_1.time_ <= 3.9 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 3.9 < arg_481_1.time_ and arg_481_1.time_ <= 3.9 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_17 = arg_481_1.actors_["1055ui_story"].transform

			if 1.96599999815226 < arg_481_1.time_ and arg_481_1.time_ <= 1.96599999815226 + arg_484_0 then
				arg_481_1.var_.moveOldPos1055ui_story = var_484_17.localPosition
			end

			local var_484_18 = 0.001

			if 1.96599999815226 <= arg_481_1.time_ and arg_481_1.time_ < 1.96599999815226 + var_484_18 then
				var_484_17.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 1.96599999815226) / var_484_18)
				var_484_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_17.position).x, (manager.ui.mainCamera.transform.position - var_484_17.position).y, (manager.ui.mainCamera.transform.position - var_484_17.position).z)
				var_484_17.localEulerAngles.z = 0
				var_484_17.localEulerAngles.x = 0
				var_484_17.localEulerAngles = var_484_17.localEulerAngles
			end

			if arg_481_1.time_ >= 1.96599999815226 + var_484_18 and arg_481_1.time_ < 1.96599999815226 + var_484_18 + arg_484_0 then
				var_484_17.localPosition = Vector3.New(0, 100, 0)
				var_484_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_17.position).x, (manager.ui.mainCamera.transform.position - var_484_17.position).y, (manager.ui.mainCamera.transform.position - var_484_17.position).z)
				var_484_17.localEulerAngles.z = 0
				var_484_17.localEulerAngles.x = 0
				var_484_17.localEulerAngles = var_484_17.localEulerAngles
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:AudioAction("stop", "effect", "se_story_221_00", "se_story_221_00_firework_loop", "")
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_20 = 4
			local var_484_21 = 0.45

			if 4 < arg_481_1.time_ and arg_481_1.time_ <= var_484_20 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_22 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_22:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_23 = arg_481_1:GetWordFromCfg(318301117)
				local var_484_24 = arg_481_1:FormatText(var_484_23.content)

				arg_481_1.text_.text = var_484_24

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_26 = 18 <= 0 and var_484_21 or var_484_21 * (utf8.len(var_484_24) / 18)

				if (18 <= 0 and var_484_21 or var_484_21 * (utf8.len(var_484_24) / 18)) > 0 and var_484_21 < var_484_26 then
					arg_481_1.talkMaxDuration = var_484_26
					var_484_20 = var_484_20 + 0.3

					if var_484_26 + var_484_20 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_26 + var_484_20
					end
				end

				arg_481_1.text_.text = var_484_24
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301117", "story_v_out_318301.awb") ~= 0 then
					local var_484_27 = manager.audio:GetVoiceLength("story_v_out_318301", "318301117", "story_v_out_318301.awb") / 1000

					if var_484_27 + var_484_20 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_27 + var_484_20
					end

					if var_484_23.prefab_name ~= "" and arg_481_1.actors_[var_484_23.prefab_name] ~= nil then
						local var_484_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_23.prefab_name].transform, "story_v_out_318301", "318301117", "story_v_out_318301.awb")

						arg_481_1:RecordAudio("318301117", var_484_28)
						arg_481_1:RecordAudio("318301117", var_484_28)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_318301", "318301117", "story_v_out_318301.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_318301", "318301117", "story_v_out_318301.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_29 = var_484_20 + 0.3
			local var_484_30 = math.max(var_484_21, arg_481_1.talkMaxDuration)

			if var_484_20 + 0.3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_29 + var_484_30 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_29) / var_484_30

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_29 + var_484_30 and arg_481_1.time_ < var_484_29 + var_484_30 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play318301118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 318301118
		arg_487_1.duration_ = 7.87

		local var_487_0 = {
			zh = 6.433,
			ja = 7.866
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play318301119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if arg_487_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_490_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_487_1.stage_.transform)

				var_490_0.name = "10014ui_story"
				var_490_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_487_1.actors_["10014ui_story"] = var_490_0

				local var_490_1 = var_490_0:GetComponentInChildren(typeof(CharacterEffect))

				var_490_1.enabled = true

				local var_490_2 = GameObjectTools.GetOrAddComponent(var_490_0, typeof(DynamicBoneHelper))

				if var_490_2 then
					var_490_2:EnableDynamicBone(false)
				end

				arg_487_1:ShowWeapon(var_490_1.transform, false)

				arg_487_1.var_["10014ui_story" .. "Animator"] = var_490_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_487_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_487_1.var_["10014ui_story" .. "LipSync"] = var_490_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_490_3 = arg_487_1.actors_["10014ui_story"].transform

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos10014ui_story = var_490_3.localPosition
			end

			local var_490_4 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				var_490_3.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_487_1.time_ - 0) / var_490_4)
				var_490_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_3.position).x, (manager.ui.mainCamera.transform.position - var_490_3.position).y, (manager.ui.mainCamera.transform.position - var_490_3.position).z)
				var_490_3.localEulerAngles.z = 0
				var_490_3.localEulerAngles.x = 0
				var_490_3.localEulerAngles = var_490_3.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				var_490_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_490_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_3.position).x, (manager.ui.mainCamera.transform.position - var_490_3.position).y, (manager.ui.mainCamera.transform.position - var_490_3.position).z)
				var_490_3.localEulerAngles.z = 0
				var_490_3.localEulerAngles.x = 0
				var_490_3.localEulerAngles = var_490_3.localEulerAngles
			end

			local var_490_5 = arg_487_1.actors_["10014ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_5) and arg_487_1.var_.characterEffect10014ui_story == nil then
				arg_487_1.var_.characterEffect10014ui_story = var_490_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_6 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_6 and not isNil(var_490_5) then
				if arg_487_1.var_.characterEffect10014ui_story and not isNil(var_490_5) then
					arg_487_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_6 and arg_487_1.time_ < 0 + var_490_6 + arg_490_0 and not isNil(var_490_5) and arg_487_1.var_.characterEffect10014ui_story then
				arg_487_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_490_8 = arg_487_1.actors_["1015ui_story"].transform

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1015ui_story = var_490_8.localPosition
			end

			local var_490_9 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_9 then
				var_490_8.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_487_1.time_ - 0) / var_490_9)
				var_490_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_8.position).x, (manager.ui.mainCamera.transform.position - var_490_8.position).y, (manager.ui.mainCamera.transform.position - var_490_8.position).z)
				var_490_8.localEulerAngles.z = 0
				var_490_8.localEulerAngles.x = 0
				var_490_8.localEulerAngles = var_490_8.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_9 and arg_487_1.time_ < 0 + var_490_9 + arg_490_0 then
				var_490_8.localPosition = Vector3.New(0, 100, 0)
				var_490_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_8.position).x, (manager.ui.mainCamera.transform.position - var_490_8.position).y, (manager.ui.mainCamera.transform.position - var_490_8.position).z)
				var_490_8.localEulerAngles.z = 0
				var_490_8.localEulerAngles.x = 0
				var_490_8.localEulerAngles = var_490_8.localEulerAngles
			end

			local var_490_10 = arg_487_1.actors_["1015ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_10) and arg_487_1.var_.characterEffect1015ui_story == nil then
				arg_487_1.var_.characterEffect1015ui_story = var_490_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_11 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_11 and not isNil(var_490_10) then
				if arg_487_1.var_.characterEffect1015ui_story and not isNil(var_490_10) then
					arg_487_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_11)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_11 and arg_487_1.time_ < 0 + var_490_11 + arg_490_0 and not isNil(var_490_10) and arg_487_1.var_.characterEffect1015ui_story then
				arg_487_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				if arg_487_1.var_.characterEffect10014ui_story == nil then
					arg_487_1.var_.characterEffect10014ui_story = arg_487_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_490_12 = arg_487_1.var_.characterEffect10014ui_story

				arg_487_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_490_12.interferenceEffect.enabled = true
				var_490_12.interferenceEffect.noise = 0.01
				var_490_12.interferenceEffect.simTimeScale = 1
				var_490_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				if arg_487_1.var_.characterEffect10014ui_story == nil then
					arg_487_1.var_.characterEffect10014ui_story = arg_487_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_487_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_490_14 = 0
			local var_490_15 = 0.8

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_16 = arg_487_1:GetWordFromCfg(318301118)
				local var_490_17 = arg_487_1:FormatText(var_490_16.content)

				arg_487_1.text_.text = var_490_17

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_19 = 32 <= 0 and var_490_15 or var_490_15 * (utf8.len(var_490_17) / 32)

				if (32 <= 0 and var_490_15 or var_490_15 * (utf8.len(var_490_17) / 32)) > 0 and var_490_15 < var_490_19 then
					arg_487_1.talkMaxDuration = var_490_19

					if var_490_19 + var_490_14 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_19 + var_490_14
					end
				end

				arg_487_1.text_.text = var_490_17
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301118", "story_v_out_318301.awb") ~= 0 then
					local var_490_20 = manager.audio:GetVoiceLength("story_v_out_318301", "318301118", "story_v_out_318301.awb") / 1000

					if var_490_20 + var_490_14 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_20 + var_490_14
					end

					if var_490_16.prefab_name ~= "" and arg_487_1.actors_[var_490_16.prefab_name] ~= nil then
						local var_490_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_16.prefab_name].transform, "story_v_out_318301", "318301118", "story_v_out_318301.awb")

						arg_487_1:RecordAudio("318301118", var_490_21)
						arg_487_1:RecordAudio("318301118", var_490_21)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_318301", "318301118", "story_v_out_318301.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_318301", "318301118", "story_v_out_318301.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_22 = math.max(var_490_15, arg_487_1.talkMaxDuration)

			if var_490_14 <= arg_487_1.time_ and arg_487_1.time_ < var_490_14 + var_490_22 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_14) / var_490_22

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_14 + var_490_22 and arg_487_1.time_ < var_490_14 + var_490_22 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play318301119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 318301119
		arg_491_1.duration_ = 6.9

		local var_491_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play318301120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1015ui_story = arg_491_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).z)
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles = arg_491_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_491_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1015ui_story"].transform.position).z)
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1015ui_story"].transform.localEulerAngles = arg_491_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1015ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1015ui_story == nil then
				arg_491_1.var_.characterEffect1015ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect1015ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1015ui_story then
				arg_491_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_494_4 = arg_491_1.actors_["10014ui_story"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10014ui_story = var_494_4.localPosition
			end

			local var_494_5 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_5 then
				var_494_4.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_491_1.time_ - 0) / var_494_5)
				var_494_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_4.position).x, (manager.ui.mainCamera.transform.position - var_494_4.position).y, (manager.ui.mainCamera.transform.position - var_494_4.position).z)
				var_494_4.localEulerAngles.z = 0
				var_494_4.localEulerAngles.x = 0
				var_494_4.localEulerAngles = var_494_4.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_5 and arg_491_1.time_ < 0 + var_494_5 + arg_494_0 then
				var_494_4.localPosition = Vector3.New(0, 100, 0)
				var_494_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_4.position).x, (manager.ui.mainCamera.transform.position - var_494_4.position).y, (manager.ui.mainCamera.transform.position - var_494_4.position).z)
				var_494_4.localEulerAngles.z = 0
				var_494_4.localEulerAngles.x = 0
				var_494_4.localEulerAngles = var_494_4.localEulerAngles
			end

			local var_494_6 = arg_491_1.actors_["10014ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_6) and arg_491_1.var_.characterEffect10014ui_story == nil then
				arg_491_1.var_.characterEffect10014ui_story = var_494_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_7 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 and not isNil(var_494_6) then
				if arg_491_1.var_.characterEffect10014ui_story and not isNil(var_494_6) then
					arg_491_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_491_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_491_1.time_ - 0) / var_494_7)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 and not isNil(var_494_6) and arg_491_1.var_.characterEffect10014ui_story then
				arg_491_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_491_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_494_8 = 0
			local var_494_9 = 0.475

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_10 = arg_491_1:GetWordFromCfg(318301119)
				local var_494_11 = arg_491_1:FormatText(var_494_10.content)

				arg_491_1.text_.text = var_494_11

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_13 = 19 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 19)

				if (19 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 19)) > 0 and var_494_9 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_8
					end
				end

				arg_491_1.text_.text = var_494_11
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301119", "story_v_out_318301.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301119", "story_v_out_318301.awb") / 1000

					if var_494_14 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_8
					end

					if var_494_10.prefab_name ~= "" and arg_491_1.actors_[var_494_10.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_10.prefab_name].transform, "story_v_out_318301", "318301119", "story_v_out_318301.awb")

						arg_491_1:RecordAudio("318301119", var_494_15)
						arg_491_1:RecordAudio("318301119", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_318301", "318301119", "story_v_out_318301.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_318301", "318301119", "story_v_out_318301.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_9, arg_491_1.talkMaxDuration)

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_8) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_8 + var_494_16 and arg_491_1.time_ < var_494_8 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play318301120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 318301120
		arg_495_1.duration_ = 7.9

		local var_495_0 = {
			zh = 7.4,
			ja = 7.9
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play318301121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.85

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(318301120)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 34 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 34)

				if (34 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 34)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301120", "story_v_out_318301.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301120", "story_v_out_318301.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_318301", "318301120", "story_v_out_318301.awb")

						arg_495_1:RecordAudio("318301120", var_498_6)
						arg_495_1:RecordAudio("318301120", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_318301", "318301120", "story_v_out_318301.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_318301", "318301120", "story_v_out_318301.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play318301121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 318301121
		arg_499_1.duration_ = 7.8

		local var_499_0 = {
			zh = 4.633,
			ja = 7.8
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play318301122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10014ui_story = arg_499_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).z)
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles = arg_499_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_499_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["10014ui_story"].transform.position).z)
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["10014ui_story"].transform.localEulerAngles = arg_499_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["10014ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect10014ui_story == nil then
				arg_499_1.var_.characterEffect10014ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect10014ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect10014ui_story then
				arg_499_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_502_4 = arg_499_1.actors_["1015ui_story"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1015ui_story = var_502_4.localPosition
			end

			local var_502_5 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_5 then
				var_502_4.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_5)
				var_502_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_4.position).x, (manager.ui.mainCamera.transform.position - var_502_4.position).y, (manager.ui.mainCamera.transform.position - var_502_4.position).z)
				var_502_4.localEulerAngles.z = 0
				var_502_4.localEulerAngles.x = 0
				var_502_4.localEulerAngles = var_502_4.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_5 and arg_499_1.time_ < 0 + var_502_5 + arg_502_0 then
				var_502_4.localPosition = Vector3.New(0, 100, 0)
				var_502_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_4.position).x, (manager.ui.mainCamera.transform.position - var_502_4.position).y, (manager.ui.mainCamera.transform.position - var_502_4.position).z)
				var_502_4.localEulerAngles.z = 0
				var_502_4.localEulerAngles.x = 0
				var_502_4.localEulerAngles = var_502_4.localEulerAngles
			end

			local var_502_6 = arg_499_1.actors_["1015ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_6) and arg_499_1.var_.characterEffect1015ui_story == nil then
				arg_499_1.var_.characterEffect1015ui_story = var_502_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_7 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 and not isNil(var_502_6) then
				if arg_499_1.var_.characterEffect1015ui_story and not isNil(var_502_6) then
					arg_499_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_7)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 and not isNil(var_502_6) and arg_499_1.var_.characterEffect1015ui_story then
				arg_499_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_502_8 = 0
			local var_502_9 = 0.375

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_8 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_10 = arg_499_1:GetWordFromCfg(318301121)
				local var_502_11 = arg_499_1:FormatText(var_502_10.content)

				arg_499_1.text_.text = var_502_11

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_13 = 15 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 15)

				if (15 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 15)) > 0 and var_502_9 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_8
					end
				end

				arg_499_1.text_.text = var_502_11
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301121", "story_v_out_318301.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301121", "story_v_out_318301.awb") / 1000

					if var_502_14 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_8
					end

					if var_502_10.prefab_name ~= "" and arg_499_1.actors_[var_502_10.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_10.prefab_name].transform, "story_v_out_318301", "318301121", "story_v_out_318301.awb")

						arg_499_1:RecordAudio("318301121", var_502_15)
						arg_499_1:RecordAudio("318301121", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_318301", "318301121", "story_v_out_318301.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_318301", "318301121", "story_v_out_318301.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_9, arg_499_1.talkMaxDuration)

			if var_502_8 <= arg_499_1.time_ and arg_499_1.time_ < var_502_8 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_8) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_8 + var_502_16 and arg_499_1.time_ < var_502_8 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play318301122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 318301122
		arg_503_1.duration_ = 9.5

		local var_503_0 = {
			zh = 6.4,
			ja = 9.5
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play318301123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.775

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:GetWordFromCfg(318301122)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 31 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 31)

				if (31 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 31)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301122", "story_v_out_318301.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301122", "story_v_out_318301.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_out_318301", "318301122", "story_v_out_318301.awb")

						arg_503_1:RecordAudio("318301122", var_506_6)
						arg_503_1:RecordAudio("318301122", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_318301", "318301122", "story_v_out_318301.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_318301", "318301122", "story_v_out_318301.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play318301123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 318301123
		arg_507_1.duration_ = 8.07

		local var_507_0 = {
			zh = 4.533,
			ja = 8.066
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play318301124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1015ui_story = arg_507_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).z)
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles = arg_507_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_507_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1015ui_story"].transform.position).z)
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1015ui_story"].transform.localEulerAngles = arg_507_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1015ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1015ui_story == nil then
				arg_507_1.var_.characterEffect1015ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1015ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1015ui_story then
				arg_507_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_510_4 = arg_507_1.actors_["10014ui_story"].transform

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10014ui_story = var_510_4.localPosition
			end

			local var_510_5 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_5 then
				var_510_4.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_507_1.time_ - 0) / var_510_5)
				var_510_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_510_4.position).x, (manager.ui.mainCamera.transform.position - var_510_4.position).y, (manager.ui.mainCamera.transform.position - var_510_4.position).z)
				var_510_4.localEulerAngles.z = 0
				var_510_4.localEulerAngles.x = 0
				var_510_4.localEulerAngles = var_510_4.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_5 and arg_507_1.time_ < 0 + var_510_5 + arg_510_0 then
				var_510_4.localPosition = Vector3.New(0, 100, 0)
				var_510_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_510_4.position).x, (manager.ui.mainCamera.transform.position - var_510_4.position).y, (manager.ui.mainCamera.transform.position - var_510_4.position).z)
				var_510_4.localEulerAngles.z = 0
				var_510_4.localEulerAngles.x = 0
				var_510_4.localEulerAngles = var_510_4.localEulerAngles
			end

			local var_510_6 = arg_507_1.actors_["10014ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_6) and arg_507_1.var_.characterEffect10014ui_story == nil then
				arg_507_1.var_.characterEffect10014ui_story = var_510_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_7 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 and not isNil(var_510_6) then
				if arg_507_1.var_.characterEffect10014ui_story and not isNil(var_510_6) then
					arg_507_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_507_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_7)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 and not isNil(var_510_6) and arg_507_1.var_.characterEffect10014ui_story then
				arg_507_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_507_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_510_8 = 0
			local var_510_9 = 0.45

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_10 = arg_507_1:GetWordFromCfg(318301123)
				local var_510_11 = arg_507_1:FormatText(var_510_10.content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_13 = 18 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 18)

				if (18 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 18)) > 0 and var_510_9 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_8
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301123", "story_v_out_318301.awb") ~= 0 then
					local var_510_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301123", "story_v_out_318301.awb") / 1000

					if var_510_14 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_8
					end

					if var_510_10.prefab_name ~= "" and arg_507_1.actors_[var_510_10.prefab_name] ~= nil then
						local var_510_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_10.prefab_name].transform, "story_v_out_318301", "318301123", "story_v_out_318301.awb")

						arg_507_1:RecordAudio("318301123", var_510_15)
						arg_507_1:RecordAudio("318301123", var_510_15)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_318301", "318301123", "story_v_out_318301.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_318301", "318301123", "story_v_out_318301.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_16 = math.max(var_510_9, arg_507_1.talkMaxDuration)

			if var_510_8 <= arg_507_1.time_ and arg_507_1.time_ < var_510_8 + var_510_16 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_8) / var_510_16

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_8 + var_510_16 and arg_507_1.time_ < var_510_8 + var_510_16 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play318301124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 318301124
		arg_511_1.duration_ = 4.1

		local var_511_0 = {
			zh = 3.366,
			ja = 4.1
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play318301125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10014ui_story = arg_511_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).z)
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles = arg_511_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_511_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["10014ui_story"].transform.position).z)
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["10014ui_story"].transform.localEulerAngles = arg_511_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["10014ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect10014ui_story == nil then
				arg_511_1.var_.characterEffect10014ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect10014ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect10014ui_story then
				arg_511_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_514_4 = arg_511_1.actors_["1015ui_story"].transform

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1015ui_story = var_514_4.localPosition
			end

			local var_514_5 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_5 then
				var_514_4.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_511_1.time_ - 0) / var_514_5)
				var_514_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_514_4.position).x, (manager.ui.mainCamera.transform.position - var_514_4.position).y, (manager.ui.mainCamera.transform.position - var_514_4.position).z)
				var_514_4.localEulerAngles.z = 0
				var_514_4.localEulerAngles.x = 0
				var_514_4.localEulerAngles = var_514_4.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_5 and arg_511_1.time_ < 0 + var_514_5 + arg_514_0 then
				var_514_4.localPosition = Vector3.New(0, 100, 0)
				var_514_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_514_4.position).x, (manager.ui.mainCamera.transform.position - var_514_4.position).y, (manager.ui.mainCamera.transform.position - var_514_4.position).z)
				var_514_4.localEulerAngles.z = 0
				var_514_4.localEulerAngles.x = 0
				var_514_4.localEulerAngles = var_514_4.localEulerAngles
			end

			local var_514_6 = arg_511_1.actors_["1015ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_6) and arg_511_1.var_.characterEffect1015ui_story == nil then
				arg_511_1.var_.characterEffect1015ui_story = var_514_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_7 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 and not isNil(var_514_6) then
				if arg_511_1.var_.characterEffect1015ui_story and not isNil(var_514_6) then
					arg_511_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_7)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 and not isNil(var_514_6) and arg_511_1.var_.characterEffect1015ui_story then
				arg_511_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_514_8 = 0
			local var_514_9 = 0.425

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_10 = arg_511_1:GetWordFromCfg(318301124)
				local var_514_11 = arg_511_1:FormatText(var_514_10.content)

				arg_511_1.text_.text = var_514_11

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_13 = 17 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 17)

				if (17 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 17)) > 0 and var_514_9 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_8
					end
				end

				arg_511_1.text_.text = var_514_11
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301124", "story_v_out_318301.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301124", "story_v_out_318301.awb") / 1000

					if var_514_14 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_8
					end

					if var_514_10.prefab_name ~= "" and arg_511_1.actors_[var_514_10.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_10.prefab_name].transform, "story_v_out_318301", "318301124", "story_v_out_318301.awb")

						arg_511_1:RecordAudio("318301124", var_514_15)
						arg_511_1:RecordAudio("318301124", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_318301", "318301124", "story_v_out_318301.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_318301", "318301124", "story_v_out_318301.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_9, arg_511_1.talkMaxDuration)

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_8) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_8 + var_514_16 and arg_511_1.time_ < var_514_8 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play318301125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 318301125
		arg_515_1.duration_ = 3.57

		local var_515_0 = {
			zh = 2.633,
			ja = 3.566
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play318301126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.325

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_1 = arg_515_1:GetWordFromCfg(318301125)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 13 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 13)

				if (13 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 13)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301125", "story_v_out_318301.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301125", "story_v_out_318301.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_318301", "318301125", "story_v_out_318301.awb")

						arg_515_1:RecordAudio("318301125", var_518_6)
						arg_515_1:RecordAudio("318301125", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_318301", "318301125", "story_v_out_318301.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_318301", "318301125", "story_v_out_318301.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play318301126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 318301126
		arg_519_1.duration_ = 1.57

		local var_519_0 = {
			zh = 1.533,
			ja = 1.566
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play318301127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1015ui_story = arg_519_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).z)
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles = arg_519_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_519_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1015ui_story"].transform.position).z)
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1015ui_story"].transform.localEulerAngles = arg_519_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1015ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1015ui_story == nil then
				arg_519_1.var_.characterEffect1015ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1015ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1015ui_story then
				arg_519_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_4 = arg_519_1.actors_["10014ui_story"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10014ui_story = var_522_4.localPosition
			end

			local var_522_5 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_5 then
				var_522_4.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_519_1.time_ - 0) / var_522_5)
				var_522_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_522_4.position).x, (manager.ui.mainCamera.transform.position - var_522_4.position).y, (manager.ui.mainCamera.transform.position - var_522_4.position).z)
				var_522_4.localEulerAngles.z = 0
				var_522_4.localEulerAngles.x = 0
				var_522_4.localEulerAngles = var_522_4.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_5 and arg_519_1.time_ < 0 + var_522_5 + arg_522_0 then
				var_522_4.localPosition = Vector3.New(0, 100, 0)
				var_522_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_522_4.position).x, (manager.ui.mainCamera.transform.position - var_522_4.position).y, (manager.ui.mainCamera.transform.position - var_522_4.position).z)
				var_522_4.localEulerAngles.z = 0
				var_522_4.localEulerAngles.x = 0
				var_522_4.localEulerAngles = var_522_4.localEulerAngles
			end

			local var_522_6 = arg_519_1.actors_["10014ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect10014ui_story == nil then
				arg_519_1.var_.characterEffect10014ui_story = var_522_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_7 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 and not isNil(var_522_6) then
				if arg_519_1.var_.characterEffect10014ui_story and not isNil(var_522_6) then
					arg_519_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_519_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_7)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect10014ui_story then
				arg_519_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_519_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_522_8 = 0
			local var_522_9 = 0.1

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_8 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_10 = arg_519_1:GetWordFromCfg(318301126)
				local var_522_11 = arg_519_1:FormatText(var_522_10.content)

				arg_519_1.text_.text = var_522_11

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_13 = 4 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 4)

				if (4 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 4)) > 0 and var_522_9 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_8
					end
				end

				arg_519_1.text_.text = var_522_11
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301126", "story_v_out_318301.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_out_318301", "318301126", "story_v_out_318301.awb") / 1000

					if var_522_14 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_8
					end

					if var_522_10.prefab_name ~= "" and arg_519_1.actors_[var_522_10.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_10.prefab_name].transform, "story_v_out_318301", "318301126", "story_v_out_318301.awb")

						arg_519_1:RecordAudio("318301126", var_522_15)
						arg_519_1:RecordAudio("318301126", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_318301", "318301126", "story_v_out_318301.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_318301", "318301126", "story_v_out_318301.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_9, arg_519_1.talkMaxDuration)

			if var_522_8 <= arg_519_1.time_ and arg_519_1.time_ < var_522_8 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_8) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_8 + var_522_16 and arg_519_1.time_ < var_522_8 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play318301127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 318301127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play318301128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1015ui_story = arg_523_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_526_0 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 then
				arg_523_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 0) / var_526_0)
				arg_523_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).z)
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles = arg_523_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 then
				arg_523_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_523_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_523_1.actors_["1015ui_story"].transform.position).z)
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_523_1.actors_["1015ui_story"].transform.localEulerAngles = arg_523_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_526_1 = arg_523_1.actors_["1015ui_story"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_1) and arg_523_1.var_.characterEffect1015ui_story == nil then
				arg_523_1.var_.characterEffect1015ui_story = var_526_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_2 and not isNil(var_526_1) then
				if arg_523_1.var_.characterEffect1015ui_story and not isNil(var_526_1) then
					arg_523_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_2)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_2 and arg_523_1.time_ < 0 + var_526_2 + arg_526_0 and not isNil(var_526_1) and arg_523_1.var_.characterEffect1015ui_story then
				arg_523_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_526_3 = 0
			local var_526_4 = 0.725

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_3 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_5 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(318301127).content)

				arg_523_1.text_.text = var_526_5

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_7 = 29 <= 0 and var_526_4 or var_526_4 * (utf8.len(var_526_5) / 29)

				if (29 <= 0 and var_526_4 or var_526_4 * (utf8.len(var_526_5) / 29)) > 0 and var_526_4 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_3 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_3
					end
				end

				arg_523_1.text_.text = var_526_5
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_4, arg_523_1.talkMaxDuration)

			if var_526_3 <= arg_523_1.time_ and arg_523_1.time_ < var_526_3 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_3) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_3 + var_526_8 and arg_523_1.time_ < var_526_3 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play318301128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 318301128
		arg_527_1.duration_ = 6.17

		local var_527_0 = {
			zh = 4.1,
			ja = 6.166
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play318301129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1015ui_story = arg_527_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_530_0 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				arg_527_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_527_1.time_ - 0) / var_530_0)
				arg_527_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).z)
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles = arg_527_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				arg_527_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_527_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1015ui_story"].transform.position).z)
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1015ui_story"].transform.localEulerAngles = arg_527_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_530_1 = arg_527_1.actors_["1015ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1015ui_story == nil then
				arg_527_1.var_.characterEffect1015ui_story = var_530_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_2 and not isNil(var_530_1) then
				if arg_527_1.var_.characterEffect1015ui_story and not isNil(var_530_1) then
					arg_527_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_2 and arg_527_1.time_ < 0 + var_530_2 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1015ui_story then
				arg_527_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_4 = 0
			local var_530_5 = 0.275

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_6 = arg_527_1:GetWordFromCfg(318301128)
				local var_530_7 = arg_527_1:FormatText(var_530_6.content)

				arg_527_1.text_.text = var_530_7

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_9 = 11 <= 0 and var_530_5 or var_530_5 * (utf8.len(var_530_7) / 11)

				if (11 <= 0 and var_530_5 or var_530_5 * (utf8.len(var_530_7) / 11)) > 0 and var_530_5 < var_530_9 then
					arg_527_1.talkMaxDuration = var_530_9

					if var_530_9 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_9 + var_530_4
					end
				end

				arg_527_1.text_.text = var_530_7
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301128", "story_v_out_318301.awb") ~= 0 then
					local var_530_10 = manager.audio:GetVoiceLength("story_v_out_318301", "318301128", "story_v_out_318301.awb") / 1000

					if var_530_10 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_10 + var_530_4
					end

					if var_530_6.prefab_name ~= "" and arg_527_1.actors_[var_530_6.prefab_name] ~= nil then
						local var_530_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_6.prefab_name].transform, "story_v_out_318301", "318301128", "story_v_out_318301.awb")

						arg_527_1:RecordAudio("318301128", var_530_11)
						arg_527_1:RecordAudio("318301128", var_530_11)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_318301", "318301128", "story_v_out_318301.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_318301", "318301128", "story_v_out_318301.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_12 = math.max(var_530_5, arg_527_1.talkMaxDuration)

			if var_530_4 <= arg_527_1.time_ and arg_527_1.time_ < var_530_4 + var_530_12 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_4) / var_530_12

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_4 + var_530_12 and arg_527_1.time_ < var_530_4 + var_530_12 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play318301129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 318301129
		arg_531_1.duration_ = 9

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play318301130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if arg_531_1.bgs_.K05g == nil then
				local var_534_0 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05g")
				var_534_0.name = "K05g"
				var_534_0.transform.parent = arg_531_1.stage_.transform
				var_534_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_.K05g = var_534_0
			end

			if 2 < arg_531_1.time_ and arg_531_1.time_ <= 2 + arg_534_0 then
				local var_534_1 = arg_531_1.bgs_.K05g

				arg_531_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_534_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_2 = var_534_1:GetComponent("SpriteRenderer")

				if var_534_2 and var_534_2.sprite then
					local var_534_3 = 2 * (var_534_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_534_1.transform.localScale = Vector3.New(var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "K05g" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_4 = 0

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_5 = 2

			if var_534_4 <= arg_531_1.time_ and arg_531_1.time_ < var_534_4 + var_534_5 then
				local var_534_6 = Color.New(0, 0, 0)

				var_534_6.a = Mathf.Lerp(0, 1, (arg_531_1.time_ - var_534_4) / var_534_5)
				arg_531_1.mask_.color = var_534_6
			end

			if arg_531_1.time_ >= var_534_4 + var_534_5 and arg_531_1.time_ < var_534_4 + var_534_5 + arg_534_0 then
				local var_534_7 = Color.New(0, 0, 0)

				var_534_7.a = 1
				arg_531_1.mask_.color = var_534_7
			end

			local var_534_8 = 2

			if 2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_8 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_9 = 2

			if var_534_8 <= arg_531_1.time_ and arg_531_1.time_ < var_534_8 + var_534_9 then
				local var_534_10 = Color.New(0, 0, 0)

				var_534_10.a = Mathf.Lerp(1, 0, (arg_531_1.time_ - var_534_8) / var_534_9)
				arg_531_1.mask_.color = var_534_10
			end

			if arg_531_1.time_ >= var_534_8 + var_534_9 and arg_531_1.time_ < var_534_8 + var_534_9 + arg_534_0 then
				local var_534_11 = Color.New(0, 0, 0)

				arg_531_1.mask_.enabled = false
				var_534_11.a = 0
				arg_531_1.mask_.color = var_534_11
			end

			local var_534_12 = arg_531_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_531_1.time_ and arg_531_1.time_ <= 1.96599999815226 + arg_534_0 then
				arg_531_1.var_.moveOldPos1015ui_story = var_534_12.localPosition
			end

			local var_534_13 = 0.001

			if 1.96599999815226 <= arg_531_1.time_ and arg_531_1.time_ < 1.96599999815226 + var_534_13 then
				var_534_12.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_531_1.time_ - 1.96599999815226) / var_534_13)
				var_534_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_12.position).x, (manager.ui.mainCamera.transform.position - var_534_12.position).y, (manager.ui.mainCamera.transform.position - var_534_12.position).z)
				var_534_12.localEulerAngles.z = 0
				var_534_12.localEulerAngles.x = 0
				var_534_12.localEulerAngles = var_534_12.localEulerAngles
			end

			if arg_531_1.time_ >= 1.96599999815226 + var_534_13 and arg_531_1.time_ < 1.96599999815226 + var_534_13 + arg_534_0 then
				var_534_12.localPosition = Vector3.New(0, 100, 0)
				var_534_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_12.position).x, (manager.ui.mainCamera.transform.position - var_534_12.position).y, (manager.ui.mainCamera.transform.position - var_534_12.position).z)
				var_534_12.localEulerAngles.z = 0
				var_534_12.localEulerAngles.x = 0
				var_534_12.localEulerAngles = var_534_12.localEulerAngles
			end

			local var_534_14 = arg_531_1.actors_["1015ui_story"]

			if 1.96599999815226 < arg_531_1.time_ and arg_531_1.time_ <= 1.96599999815226 + arg_534_0 and not isNil(var_534_14) and arg_531_1.var_.characterEffect1015ui_story == nil then
				arg_531_1.var_.characterEffect1015ui_story = var_534_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_15 = 0.034000001847744

			if 1.96599999815226 <= arg_531_1.time_ and arg_531_1.time_ < 1.96599999815226 + var_534_15 and not isNil(var_534_14) then
				if arg_531_1.var_.characterEffect1015ui_story and not isNil(var_534_14) then
					arg_531_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 1.96599999815226) / var_534_15)
				end
			end

			if arg_531_1.time_ >= 1.96599999815226 + var_534_15 and arg_531_1.time_ < 1.96599999815226 + var_534_15 + arg_534_0 and not isNil(var_534_14) and arg_531_1.var_.characterEffect1015ui_story then
				arg_531_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_16 = 4
			local var_534_17 = 1.1

			if 4 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_18 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_18:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_19 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(318301129).content)

				arg_531_1.text_.text = var_534_19

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_21 = 44 <= 0 and var_534_17 or var_534_17 * (utf8.len(var_534_19) / 44)

				if (44 <= 0 and var_534_17 or var_534_17 * (utf8.len(var_534_19) / 44)) > 0 and var_534_17 < var_534_21 then
					arg_531_1.talkMaxDuration = var_534_21
					var_534_16 = var_534_16 + 0.3

					if var_534_21 + var_534_16 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_21 + var_534_16
					end
				end

				arg_531_1.text_.text = var_534_19
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_22 = var_534_16 + 0.3
			local var_534_23 = math.max(var_534_17, arg_531_1.talkMaxDuration)

			if var_534_16 + 0.3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_22 + var_534_23 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_22) / var_534_23

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_22 + var_534_23 and arg_531_1.time_ < var_534_22 + var_534_23 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play318301130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 318301130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play318301131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.225

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(318301130).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 9 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 9)

				if (9 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 9)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play318301131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 318301131
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play318301132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_544_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_541_1.bgmTxt_.text ~= var_544_3 and arg_541_1.bgmTxt_.text ~= "" then
						if arg_541_1.bgmTxt2_.text ~= "" then
							arg_541_1.bgmTxt_.text = arg_541_1.bgmTxt2_.text
						end

						arg_541_1.bgmTxt2_.text = var_544_3

						arg_541_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_541_1.bgmTxt_.text = var_544_3
						arg_541_1.bgmTxt2_.text = var_544_3
					end

					if arg_541_1.bgmTimer then
						arg_541_1.bgmTimer:Stop()

						arg_541_1.bgmTimer = nil
					end

					if arg_541_1.settingData.show_music_name == 1 then
						arg_541_1.musicController:SetSelectedState("show")
						arg_541_1.musicAnimator_:Play("open", 0, 0)

						if arg_541_1.settingData.music_time ~= 0 then
							arg_541_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_541_1.settingData.music_time), function()
								if arg_541_1 == nil or isNil(arg_541_1.bgmTxt_) then
									return
								end

								arg_541_1.musicController:SetSelectedState("hide")
								arg_541_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_544_4 = 0
			local var_544_5 = 0.3

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_6 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(318301131).content)

				arg_541_1.text_.text = var_544_6

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_8 = 12 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_6) / 12)

				if (12 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_6) / 12)) > 0 and var_544_5 < var_544_8 then
					arg_541_1.talkMaxDuration = var_544_8

					if var_544_8 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_4
					end
				end

				arg_541_1.text_.text = var_544_6
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_9 = math.max(var_544_5, arg_541_1.talkMaxDuration)

			if var_544_4 <= arg_541_1.time_ and arg_541_1.time_ < var_544_4 + var_544_9 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_4) / var_544_9

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_4 + var_544_9 and arg_541_1.time_ < var_544_4 + var_544_9 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play318301132 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 318301132
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play318301133(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.1

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_1 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(318301132).content)

				arg_546_1.text_.text = var_549_1

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_3 = 4 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 4)

				if (4 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_1) / 4)) > 0 and var_549_0 < var_549_3 then
					arg_546_1.talkMaxDuration = var_549_3

					if var_549_3 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_3 + 0
					end
				end

				arg_546_1.text_.text = var_549_1
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_4 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_4 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_4

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_4 and arg_546_1.time_ < 0 + var_549_4 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play318301133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 318301133
		arg_550_1.duration_ = 2.93

		local var_550_0 = {
			zh = 2.633,
			ja = 2.933
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play318301134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.325

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_1 = arg_550_1:GetWordFromCfg(318301133)
				local var_553_2 = arg_550_1:FormatText(var_553_1.content)

				arg_550_1.text_.text = var_553_2

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 13 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 13)

				if (13 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 13)) > 0 and var_553_0 < var_553_4 then
					arg_550_1.talkMaxDuration = var_553_4

					if var_553_4 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_4 + 0
					end
				end

				arg_550_1.text_.text = var_553_2
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301133", "story_v_out_318301.awb") ~= 0 then
					local var_553_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301133", "story_v_out_318301.awb") / 1000

					if var_553_5 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + 0
					end

					if var_553_1.prefab_name ~= "" and arg_550_1.actors_[var_553_1.prefab_name] ~= nil then
						local var_553_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_1.prefab_name].transform, "story_v_out_318301", "318301133", "story_v_out_318301.awb")

						arg_550_1:RecordAudio("318301133", var_553_6)
						arg_550_1:RecordAudio("318301133", var_553_6)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_318301", "318301133", "story_v_out_318301.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_318301", "318301133", "story_v_out_318301.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_7 and arg_550_1.time_ < 0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play318301134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 318301134
		arg_554_1.duration_ = 3.17

		local var_554_0 = {
			zh = 1.4,
			ja = 3.166
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play318301135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0.2

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_1 = arg_554_1:GetWordFromCfg(318301134)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 8 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 8)

				if (8 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 8)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318301", "318301134", "story_v_out_318301.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_out_318301", "318301134", "story_v_out_318301.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_out_318301", "318301134", "story_v_out_318301.awb")

						arg_554_1:RecordAudio("318301134", var_557_6)
						arg_554_1:RecordAudio("318301134", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_318301", "318301134", "story_v_out_318301.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_318301", "318301134", "story_v_out_318301.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play318301135 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 318301135
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play318301136(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if arg_558_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_561_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_558_1.stage_.transform)

				var_561_0.name = "1019ui_story"
				var_561_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_558_1.actors_["1019ui_story"] = var_561_0

				local var_561_1 = var_561_0:GetComponentInChildren(typeof(CharacterEffect))

				var_561_1.enabled = true

				local var_561_2 = GameObjectTools.GetOrAddComponent(var_561_0, typeof(DynamicBoneHelper))

				if var_561_2 then
					var_561_2:EnableDynamicBone(false)
				end

				arg_558_1:ShowWeapon(var_561_1.transform, false)

				arg_558_1.var_["1019ui_story" .. "Animator"] = var_561_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_558_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_558_1.var_["1019ui_story" .. "LipSync"] = var_561_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_561_3 = arg_558_1.actors_["1019ui_story"].transform

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos1019ui_story = var_561_3.localPosition
			end

			local var_561_4 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				var_561_3.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_558_1.time_ - 0) / var_561_4)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				var_561_3.localPosition = Vector3.New(0, 100, 0)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			local var_561_5 = arg_558_1.actors_["1019ui_story"]

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect1019ui_story == nil then
				arg_558_1.var_.characterEffect1019ui_story = var_561_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_6 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_6 and not isNil(var_561_5) then
				if arg_558_1.var_.characterEffect1019ui_story and not isNil(var_561_5) then
					arg_558_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_6)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_6 and arg_558_1.time_ < 0 + var_561_6 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect1019ui_story then
				arg_558_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_561_7 = 0
			local var_561_8 = 0.9

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_7 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, false)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_9 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(318301135).content)

				arg_558_1.text_.text = var_561_9

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_11 = 36 <= 0 and var_561_8 or var_561_8 * (utf8.len(var_561_9) / 36)

				if (36 <= 0 and var_561_8 or var_561_8 * (utf8.len(var_561_9) / 36)) > 0 and var_561_8 < var_561_11 then
					arg_558_1.talkMaxDuration = var_561_11

					if var_561_11 + var_561_7 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_11 + var_561_7
					end
				end

				arg_558_1.text_.text = var_561_9
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_12 = math.max(var_561_8, arg_558_1.talkMaxDuration)

			if var_561_7 <= arg_558_1.time_ and arg_558_1.time_ < var_561_7 + var_561_12 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_7) / var_561_12

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_7 + var_561_12 and arg_558_1.time_ < var_561_7 + var_561_12 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play318301136 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 318301136
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
			arg_562_1.auto_ = false
		end

		function arg_562_1.playNext_(arg_564_0)
			arg_562_1.onStoryFinished_()
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0.875

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_1 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(318301136).content)

				arg_562_1.text_.text = var_565_1

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_3 = 35 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 35)

				if (35 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_1) / 35)) > 0 and var_565_0 < var_565_3 then
					arg_562_1.talkMaxDuration = var_565_3

					if var_565_3 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_3 + 0
					end
				end

				arg_562_1.text_.text = var_565_1
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_4 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_4 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_4

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_4 and arg_562_1.time_ < 0 + var_565_4 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/K13f",
		"TextureConfig/Background/K13g",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/K02f",
		"TextureConfig/Background/K06g",
		"TextureConfig/Background/K07g",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_318301.awb"
	}
}
