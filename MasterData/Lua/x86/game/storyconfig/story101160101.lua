return {
	Play116011001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116011001
		arg_1_1.duration_ = 122.97

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play116011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_4_0.name = "I05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I05f = var_4_0
			end

			if 110.9667 < arg_1_1.time_ and arg_1_1.time_ <= 110.9667 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I05f

				arg_1_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 110.9667

			if 110.9667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 110.966666666667 < arg_1_1.time_ and arg_1_1.time_ <= 110.966666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/101160101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_14 + 110.95666666689

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					arg_1_1.state_ = arg_8_0 and "pause" or "playing"
				end, 101160101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_15 = 110.966666666667

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_16 = 110.9667

			if 110.9667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_17 = 0.133334000000005

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				-- block empty
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 112.966699999999
			local var_4_19 = 0.65

			if 112.966699999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_21 = arg_1_1:GetWordFromCfg(116011001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 26 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 26)

				if (26 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 26)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011001", "story_v_out_116011.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_116011", "116011001", "story_v_out_116011.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_116011", "116011001", "story_v_out_116011.awb")

						arg_1_1:RecordAudio("116011001", var_4_26)
						arg_1_1:RecordAudio("116011001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116011", "116011001", "story_v_out_116011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116011", "116011001", "story_v_out_116011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116011002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116011002
		arg_11_1.duration_ = 2

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116011003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "2078ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["2078ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["2078ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["2078ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["2078ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos2078ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_14_5 = "2079ui_story"

			if arg_11_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_14_6 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_11_1.stage_.transform)

				var_14_6.name = var_14_5
				var_14_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_5] = var_14_6

				local var_14_7 = var_14_6:GetComponentInChildren(typeof(CharacterEffect))

				var_14_7.enabled = true

				local var_14_8 = GameObjectTools.GetOrAddComponent(var_14_6, typeof(DynamicBoneHelper))

				if var_14_8 then
					var_14_8:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_7.transform, false)

				arg_11_1.var_[var_14_5 .. "Animator"] = var_14_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_5 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_5 .. "LipSync"] = var_14_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_9 = arg_11_1.actors_["2079ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos2079ui_story = var_14_9.localPosition
			end

			local var_14_10 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_10 then
				var_14_9.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_11_1.time_ - 0) / var_14_10)
				var_14_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_9.position).x, (manager.ui.mainCamera.transform.position - var_14_9.position).y, (manager.ui.mainCamera.transform.position - var_14_9.position).z)
				var_14_9.localEulerAngles.z = 0
				var_14_9.localEulerAngles.x = 0
				var_14_9.localEulerAngles = var_14_9.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_10 and arg_11_1.time_ < 0 + var_14_10 + arg_14_0 then
				var_14_9.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_14_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_9.position).x, (manager.ui.mainCamera.transform.position - var_14_9.position).y, (manager.ui.mainCamera.transform.position - var_14_9.position).z)
				var_14_9.localEulerAngles.z = 0
				var_14_9.localEulerAngles.x = 0
				var_14_9.localEulerAngles = var_14_9.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_14_11 = arg_11_1.actors_["2078ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_11) and arg_11_1.var_.characterEffect2078ui_story == nil then
				arg_11_1.var_.characterEffect2078ui_story = var_14_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_12 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_12 and not isNil(var_14_11) then
				if arg_11_1.var_.characterEffect2078ui_story and not isNil(var_14_11) then
					arg_11_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_12 and arg_11_1.time_ < 0 + var_14_12 + arg_14_0 and not isNil(var_14_11) and arg_11_1.var_.characterEffect2078ui_story then
				arg_11_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_14_14 = arg_11_1.actors_["2079ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect2079ui_story == nil then
				arg_11_1.var_.characterEffect2079ui_story = var_14_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_15 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_15 and not isNil(var_14_14) then
				if arg_11_1.var_.characterEffect2079ui_story and not isNil(var_14_14) then
					arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_15 and arg_11_1.time_ < 0 + var_14_15 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect2079ui_story then
				arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_14_17 = 0
			local var_14_18 = 0.075

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_17 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[325].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_19 = arg_11_1:GetWordFromCfg(116011002)
				local var_14_20 = arg_11_1:FormatText(var_14_19.content)

				arg_11_1.text_.text = var_14_20

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_22 = 3 <= 0 and var_14_18 or var_14_18 * (utf8.len(var_14_20) / 3)

				if (3 <= 0 and var_14_18 or var_14_18 * (utf8.len(var_14_20) / 3)) > 0 and var_14_18 < var_14_22 then
					arg_11_1.talkMaxDuration = var_14_22

					if var_14_22 + var_14_17 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_22 + var_14_17
					end
				end

				arg_11_1.text_.text = var_14_20
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011002", "story_v_out_116011.awb") ~= 0 then
					local var_14_23 = manager.audio:GetVoiceLength("story_v_out_116011", "116011002", "story_v_out_116011.awb") / 1000

					if var_14_23 + var_14_17 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_23 + var_14_17
					end

					if var_14_19.prefab_name ~= "" and arg_11_1.actors_[var_14_19.prefab_name] ~= nil then
						local var_14_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_19.prefab_name].transform, "story_v_out_116011", "116011002", "story_v_out_116011.awb")

						arg_11_1:RecordAudio("116011002", var_14_24)
						arg_11_1:RecordAudio("116011002", var_14_24)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_116011", "116011002", "story_v_out_116011.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_116011", "116011002", "story_v_out_116011.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_25 = math.max(var_14_18, arg_11_1.talkMaxDuration)

			if var_14_17 <= arg_11_1.time_ and arg_11_1.time_ < var_14_17 + var_14_25 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_17) / var_14_25

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_17 + var_14_25 and arg_11_1.time_ < var_14_17 + var_14_25 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play116011003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116011003
		arg_15_1.duration_ = 12.83

		local var_15_0 = {
			zh = 6.866,
			ja = 12.833
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
				arg_15_0:Play116011004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["2078ui_story"]) and arg_15_1.var_.characterEffect2078ui_story == nil then
				arg_15_1.var_.characterEffect2078ui_story = arg_15_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["2078ui_story"]) then
				if arg_15_1.var_.characterEffect2078ui_story and not isNil(arg_15_1.actors_["2078ui_story"]) then
					arg_15_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_15_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["2078ui_story"]) and arg_15_1.var_.characterEffect2078ui_story then
				arg_15_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_15_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_18_1 = arg_15_1.actors_["2079ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect2079ui_story == nil then
				arg_15_1.var_.characterEffect2079ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect2079ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_15_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_2)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect2079ui_story then
				arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_15_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_18_3 = 0
			local var_18_4 = 0.925

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_3 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_5 = arg_15_1:GetWordFromCfg(116011003)
				local var_18_6 = arg_15_1:FormatText(var_18_5.content)

				arg_15_1.text_.text = var_18_6

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_8 = 37 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_6) / 37)

				if (37 <= 0 and var_18_4 or var_18_4 * (utf8.len(var_18_6) / 37)) > 0 and var_18_4 < var_18_8 then
					arg_15_1.talkMaxDuration = var_18_8

					if var_18_8 + var_18_3 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_3
					end
				end

				arg_15_1.text_.text = var_18_6
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011003", "story_v_out_116011.awb") ~= 0 then
					local var_18_9 = manager.audio:GetVoiceLength("story_v_out_116011", "116011003", "story_v_out_116011.awb") / 1000

					if var_18_9 + var_18_3 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_9 + var_18_3
					end

					if var_18_5.prefab_name ~= "" and arg_15_1.actors_[var_18_5.prefab_name] ~= nil then
						local var_18_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_5.prefab_name].transform, "story_v_out_116011", "116011003", "story_v_out_116011.awb")

						arg_15_1:RecordAudio("116011003", var_18_10)
						arg_15_1:RecordAudio("116011003", var_18_10)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116011", "116011003", "story_v_out_116011.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116011", "116011003", "story_v_out_116011.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_11 = math.max(var_18_4, arg_15_1.talkMaxDuration)

			if var_18_3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_3 + var_18_11 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_3) / var_18_11

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_3 + var_18_11 and arg_15_1.time_ < var_18_3 + var_18_11 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.4

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(116011004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)

				if (16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116011005
		arg_23_1.duration_ = 4.13

		local var_23_0 = {
			zh = 2.833,
			ja = 4.133
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play116011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["2078ui_story"]) and arg_23_1.var_.characterEffect2078ui_story == nil then
				arg_23_1.var_.characterEffect2078ui_story = arg_23_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["2078ui_story"]) then
				if arg_23_1.var_.characterEffect2078ui_story and not isNil(arg_23_1.actors_["2078ui_story"]) then
					arg_23_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["2078ui_story"]) and arg_23_1.var_.characterEffect2078ui_story then
				arg_23_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_26_2 = 0
			local var_26_3 = 0.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:GetWordFromCfg(116011005)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 18 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 18)

				if (18 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 18)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011005", "story_v_out_116011.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011005", "story_v_out_116011.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_out_116011", "116011005", "story_v_out_116011.awb")

						arg_23_1:RecordAudio("116011005", var_26_9)
						arg_23_1:RecordAudio("116011005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_116011", "116011005", "story_v_out_116011.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_116011", "116011005", "story_v_out_116011.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116011006
		arg_27_1.duration_ = 2.5

		local var_27_0 = {
			zh = 1.6,
			ja = 2.5
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
				arg_27_0:Play116011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["2078ui_story"]) and arg_27_1.var_.characterEffect2078ui_story == nil then
				arg_27_1.var_.characterEffect2078ui_story = arg_27_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["2078ui_story"]) then
				if arg_27_1.var_.characterEffect2078ui_story and not isNil(arg_27_1.actors_["2078ui_story"]) then
					arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_27_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["2078ui_story"]) and arg_27_1.var_.characterEffect2078ui_story then
				arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_27_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_30_1 = arg_27_1.actors_["2079ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect2079ui_story == nil then
				arg_27_1.var_.characterEffect2079ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect2079ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect2079ui_story then
				arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_30_4 = 0
			local var_30_5 = 0.175

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(116011006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 7 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 7)

				if (7 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 7)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011006", "story_v_out_116011.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011006", "story_v_out_116011.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_out_116011", "116011006", "story_v_out_116011.awb")

						arg_27_1:RecordAudio("116011006", var_30_11)
						arg_27_1:RecordAudio("116011006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116011", "116011006", "story_v_out_116011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116011", "116011006", "story_v_out_116011.awb")
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

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play116011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116011007
		arg_31_1.duration_ = 5.83

		local var_31_0 = {
			zh = 5.833,
			ja = 5.133
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["2078ui_story"]) and arg_31_1.var_.characterEffect2078ui_story == nil then
				arg_31_1.var_.characterEffect2078ui_story = arg_31_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["2078ui_story"]) then
				if arg_31_1.var_.characterEffect2078ui_story and not isNil(arg_31_1.actors_["2078ui_story"]) then
					arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["2078ui_story"]) and arg_31_1.var_.characterEffect2078ui_story then
				arg_31_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_34_2 = arg_31_1.actors_["2079ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect2079ui_story == nil then
				arg_31_1.var_.characterEffect2079ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.characterEffect2079ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_31_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect2079ui_story then
				arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_31_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_34_4 = 0
			local var_34_5 = 0.975

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(116011007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 39 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 39)

				if (39 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 39)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011007", "story_v_out_116011.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011007", "story_v_out_116011.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_116011", "116011007", "story_v_out_116011.awb")

						arg_31_1:RecordAudio("116011007", var_34_11)
						arg_31_1:RecordAudio("116011007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116011", "116011007", "story_v_out_116011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116011", "116011007", "story_v_out_116011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116011008
		arg_35_1.duration_ = 5.8

		local var_35_0 = {
			zh = 3.533,
			ja = 5.8
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) and arg_35_1.var_.characterEffect2078ui_story == nil then
				arg_35_1.var_.characterEffect2078ui_story = arg_35_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) then
				if arg_35_1.var_.characterEffect2078ui_story and not isNil(arg_35_1.actors_["2078ui_story"]) then
					arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_35_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["2078ui_story"]) and arg_35_1.var_.characterEffect2078ui_story then
				arg_35_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_35_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_38_1 = arg_35_1.actors_["2079ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect2079ui_story == nil then
				arg_35_1.var_.characterEffect2079ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect2079ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect2079ui_story then
				arg_35_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_38_4 = 0
			local var_38_5 = 0.325

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(116011008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 13 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 13)

				if (13 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 13)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011008", "story_v_out_116011.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011008", "story_v_out_116011.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_116011", "116011008", "story_v_out_116011.awb")

						arg_35_1:RecordAudio("116011008", var_38_11)
						arg_35_1:RecordAudio("116011008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116011", "116011008", "story_v_out_116011.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116011", "116011008", "story_v_out_116011.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116011009
		arg_39_1.duration_ = 8.77

		local var_39_0 = {
			zh = 5.6,
			ja = 8.766
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(116011009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 26 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 26)

				if (26 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 26)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011009", "story_v_out_116011.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011009", "story_v_out_116011.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_116011", "116011009", "story_v_out_116011.awb")

						arg_39_1:RecordAudio("116011009", var_42_6)
						arg_39_1:RecordAudio("116011009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116011", "116011009", "story_v_out_116011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116011", "116011009", "story_v_out_116011.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116011010
		arg_43_1.duration_ = 11.23

		local var_43_0 = {
			zh = 7.166,
			ja = 11.233
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
				arg_43_0:Play116011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) and arg_43_1.var_.characterEffect2079ui_story == nil then
				arg_43_1.var_.characterEffect2079ui_story = arg_43_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) then
				if arg_43_1.var_.characterEffect2079ui_story and not isNil(arg_43_1.actors_["2079ui_story"]) then
					arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_43_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) and arg_43_1.var_.characterEffect2079ui_story then
				arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_43_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.95

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(116011010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 38 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 38)

				if (38 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 38)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011010", "story_v_out_116011.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_out_116011", "116011010", "story_v_out_116011.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_116011", "116011010", "story_v_out_116011.awb")

						arg_43_1:RecordAudio("116011010", var_46_8)
						arg_43_1:RecordAudio("116011010", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116011", "116011010", "story_v_out_116011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116011", "116011010", "story_v_out_116011.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116011011
		arg_47_1.duration_ = 7.13

		local var_47_0 = {
			zh = 7.133,
			ja = 6.6
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
				arg_47_0:Play116011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) and arg_47_1.var_.characterEffect2078ui_story == nil then
				arg_47_1.var_.characterEffect2078ui_story = arg_47_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) then
				if arg_47_1.var_.characterEffect2078ui_story and not isNil(arg_47_1.actors_["2078ui_story"]) then
					arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["2078ui_story"]) and arg_47_1.var_.characterEffect2078ui_story then
				arg_47_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_50_2 = 0
			local var_50_3 = 1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:GetWordFromCfg(116011011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 40 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 40)

				if (40 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 40)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011011", "story_v_out_116011.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011011", "story_v_out_116011.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_116011", "116011011", "story_v_out_116011.awb")

						arg_47_1:RecordAudio("116011011", var_50_9)
						arg_47_1:RecordAudio("116011011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_116011", "116011011", "story_v_out_116011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_116011", "116011011", "story_v_out_116011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play116011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116011012
		arg_51_1.duration_ = 5.83

		local var_51_0 = {
			zh = 4.566,
			ja = 5.833
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["2078ui_story"]) and arg_51_1.var_.characterEffect2078ui_story == nil then
				arg_51_1.var_.characterEffect2078ui_story = arg_51_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["2078ui_story"]) then
				if arg_51_1.var_.characterEffect2078ui_story and not isNil(arg_51_1.actors_["2078ui_story"]) then
					arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_51_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["2078ui_story"]) and arg_51_1.var_.characterEffect2078ui_story then
				arg_51_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_51_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.625

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(116011012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 25 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 25)

				if (25 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 25)) > 0 and var_54_2 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011012", "story_v_out_116011.awb") ~= 0 then
					local var_54_7 = manager.audio:GetVoiceLength("story_v_out_116011", "116011012", "story_v_out_116011.awb") / 1000

					if var_54_7 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_1
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_116011", "116011012", "story_v_out_116011.awb")

						arg_51_1:RecordAudio("116011012", var_54_8)
						arg_51_1:RecordAudio("116011012", var_54_8)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_116011", "116011012", "story_v_out_116011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_116011", "116011012", "story_v_out_116011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_9 and arg_51_1.time_ < var_54_1 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116011013
		arg_55_1.duration_ = 7.27

		local var_55_0 = {
			zh = 4.366,
			ja = 7.266
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
				arg_55_0:Play116011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.625

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(116011013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)

				if (25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011013", "story_v_out_116011.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011013", "story_v_out_116011.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_116011", "116011013", "story_v_out_116011.awb")

						arg_55_1:RecordAudio("116011013", var_58_6)
						arg_55_1:RecordAudio("116011013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_116011", "116011013", "story_v_out_116011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_116011", "116011013", "story_v_out_116011.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116011014
		arg_59_1.duration_ = 7

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play116011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_0 = arg_59_1.bgs_.I05f:GetComponent("SpriteRenderer")

				if var_62_0 then
					arg_59_1.var_.alphaOldValueI05f = var_62_0.color.a
					arg_59_1.var_.alphaMatValueI05f = var_62_0
				end

				arg_59_1.var_.alphaOldValueI05f = 1
			end

			local var_62_1 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				if arg_59_1.var_.alphaMatValueI05f then
					arg_59_1.var_.alphaMatValueI05f.color.a = Mathf.Lerp(arg_59_1.var_.alphaOldValueI05f, 0, (arg_59_1.time_ - 0) / var_62_1)
					arg_59_1.var_.alphaMatValueI05f.color = arg_59_1.var_.alphaMatValueI05f.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 and arg_59_1.var_.alphaMatValueI05f then
				arg_59_1.var_.alphaMatValueI05f.color.a = 0
				arg_59_1.var_.alphaMatValueI05f.color = arg_59_1.var_.alphaMatValueI05f.color
			end

			local var_62_2 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			if arg_59_1.time_ >= var_62_2 + 2 and arg_59_1.time_ < var_62_2 + 2 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_62_4 = arg_59_1.actors_["2078ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos2078ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_5)
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

			local var_62_6 = arg_59_1.actors_["2079ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos2079ui_story = var_62_6.localPosition
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_6.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_7)
				var_62_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_6.position).x, (manager.ui.mainCamera.transform.position - var_62_6.position).y, (manager.ui.mainCamera.transform.position - var_62_6.position).z)
				var_62_6.localEulerAngles.z = 0
				var_62_6.localEulerAngles.x = 0
				var_62_6.localEulerAngles = var_62_6.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_6.localPosition = Vector3.New(0, 100, 0)
				var_62_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_6.position).x, (manager.ui.mainCamera.transform.position - var_62_6.position).y, (manager.ui.mainCamera.transform.position - var_62_6.position).z)
				var_62_6.localEulerAngles.z = 0
				var_62_6.localEulerAngles.x = 0
				var_62_6.localEulerAngles = var_62_6.localEulerAngles
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_8 = 2
			local var_62_9 = 0.05

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_10 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_10:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_11 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(116011014).content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 2 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 2)

				if (2 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 2)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13
					var_62_8 = var_62_8 + 0.3

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = var_62_8 + 0.3
			local var_62_15 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_14 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_14) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_14 + var_62_15 and arg_59_1.time_ < var_62_14 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116011015
		arg_65_1.duration_ = 4.63

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = arg_65_1.bgs_.I05f:GetComponent("SpriteRenderer")

				if var_68_0 then
					arg_65_1.var_.alphaOldValueI05f = var_68_0.color.a
					arg_65_1.var_.alphaMatValueI05f = var_68_0
				end

				arg_65_1.var_.alphaOldValueI05f = 0
			end

			local var_68_1 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				if arg_65_1.var_.alphaMatValueI05f then
					arg_65_1.var_.alphaMatValueI05f.color.a = Mathf.Lerp(arg_65_1.var_.alphaOldValueI05f, 1, (arg_65_1.time_ - 0) / var_68_1)
					arg_65_1.var_.alphaMatValueI05f.color = arg_65_1.var_.alphaMatValueI05f.color
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and arg_65_1.var_.alphaMatValueI05f then
				arg_65_1.var_.alphaMatValueI05f.color.a = 1
				arg_65_1.var_.alphaMatValueI05f.color = arg_65_1.var_.alphaMatValueI05f.color
			end

			local var_68_2 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_2 + 2 and arg_65_1.time_ < var_68_2 + 2 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_3 = arg_65_1.actors_["2078ui_story"].transform

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 then
				arg_65_1.var_.moveOldPos2078ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 1.8 <= arg_65_1.time_ and arg_65_1.time_ < 1.8 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_65_1.time_ - 1.8) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 1.8 + var_68_4 and arg_65_1.time_ < 1.8 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 then
				arg_65_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_68_5 = arg_65_1.actors_["2079ui_story"].transform

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 then
				arg_65_1.var_.moveOldPos2079ui_story = var_68_5.localPosition
			end

			local var_68_6 = 0.001

			if 1.8 <= arg_65_1.time_ and arg_65_1.time_ < 1.8 + var_68_6 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_65_1.time_ - 1.8) / var_68_6)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			if arg_65_1.time_ >= 1.8 + var_68_6 and arg_65_1.time_ < 1.8 + var_68_6 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 then
				arg_65_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_68_7 = arg_65_1.actors_["2078ui_story"]

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect2078ui_story == nil then
				arg_65_1.var_.characterEffect2078ui_story = var_68_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if 1.8 <= arg_65_1.time_ and arg_65_1.time_ < 1.8 + var_68_8 and not isNil(var_68_7) then
				if arg_65_1.var_.characterEffect2078ui_story and not isNil(var_68_7) then
					arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 1.8) / var_68_8)
				end
			end

			if arg_65_1.time_ >= 1.8 + var_68_8 and arg_65_1.time_ < 1.8 + var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect2078ui_story then
				arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_68_9 = arg_65_1.actors_["2079ui_story"]

			if 1.8 < arg_65_1.time_ and arg_65_1.time_ <= 1.8 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect2079ui_story == nil then
				arg_65_1.var_.characterEffect2079ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_10 = 0.2

			if 1.8 <= arg_65_1.time_ and arg_65_1.time_ < 1.8 + var_68_10 and not isNil(var_68_9) then
				if arg_65_1.var_.characterEffect2079ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 1.8 + var_68_10 and arg_65_1.time_ < 1.8 + var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect2079ui_story then
				arg_65_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_12 = 2
			local var_68_13 = 0.15

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_14 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_14:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(116011015)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 6 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_16) / 6)

				if (6 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_16) / 6)) > 0 and var_68_13 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18
					var_68_12 = var_68_12 + 0.3

					if var_68_18 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011015", "story_v_out_116011.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011015", "story_v_out_116011.awb") / 1000

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_116011", "116011015", "story_v_out_116011.awb")

						arg_65_1:RecordAudio("116011015", var_68_20)
						arg_65_1:RecordAudio("116011015", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116011", "116011015", "story_v_out_116011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116011", "116011015", "story_v_out_116011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = var_68_12 + 0.3
			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_21) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play116011016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116011016
		arg_71_1.duration_ = 5.47

		local var_71_0 = {
			zh = 3.766,
			ja = 5.466
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116011017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story == nil then
				arg_71_1.var_.characterEffect2079ui_story = arg_71_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) then
				if arg_71_1.var_.characterEffect2079ui_story and not isNil(arg_71_1.actors_["2079ui_story"]) then
					arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_71_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story then
				arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_71_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_74_1 = arg_71_1.actors_["2078ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect2078ui_story == nil then
				arg_71_1.var_.characterEffect2078ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect2078ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect2078ui_story then
				arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_74_4 = 0
			local var_74_5 = 0.475

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(116011016)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)

				if (19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011016", "story_v_out_116011.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011016", "story_v_out_116011.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_116011", "116011016", "story_v_out_116011.awb")

						arg_71_1:RecordAudio("116011016", var_74_11)
						arg_71_1:RecordAudio("116011016", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116011", "116011016", "story_v_out_116011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116011", "116011016", "story_v_out_116011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116011017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116011017
		arg_75_1.duration_ = 9.03

		local var_75_0 = {
			zh = 7.633,
			ja = 9.033
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116011018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 2.9 < arg_75_1.time_ and arg_75_1.time_ <= 2.9 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_78_0 = 0.6

			if 2.9 <= arg_75_1.time_ and arg_75_1.time_ < 2.9 + var_78_0 then
				local var_78_1, var_78_2 = math.modf((arg_75_1.time_ - 2.9) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_78_2 * 0.13, var_78_2 * 0.13, var_78_2 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= 2.9 + var_78_0 and arg_75_1.time_ < 2.9 + var_78_0 + arg_78_0 then
				manager.ui.mainCamera.transform.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_3 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_3 + 3.6 and arg_75_1.time_ < var_78_3 + 3.6 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_4 = arg_75_1.actors_["2078ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos2078ui_story = var_78_4.localPosition
			end

			local var_78_5 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_5)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, 100, 0)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			local var_78_6 = arg_75_1.actors_["2079ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos2079ui_story = var_78_6.localPosition
			end

			local var_78_7 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				var_78_6.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_7)
				var_78_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_6.position).x, (manager.ui.mainCamera.transform.position - var_78_6.position).y, (manager.ui.mainCamera.transform.position - var_78_6.position).z)
				var_78_6.localEulerAngles.z = 0
				var_78_6.localEulerAngles.x = 0
				var_78_6.localEulerAngles = var_78_6.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				var_78_6.localPosition = Vector3.New(0, 100, 0)
				var_78_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_6.position).x, (manager.ui.mainCamera.transform.position - var_78_6.position).y, (manager.ui.mainCamera.transform.position - var_78_6.position).z)
				var_78_6.localEulerAngles.z = 0
				var_78_6.localEulerAngles.x = 0
				var_78_6.localEulerAngles = var_78_6.localEulerAngles
			end

			local var_78_8 = 0
			local var_78_9 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_10 = arg_75_1:GetWordFromCfg(116011017)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)

				if (19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011017", "story_v_out_116011.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011017", "story_v_out_116011.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_116011", "116011017", "story_v_out_116011.awb")

						arg_75_1:RecordAudio("116011017", var_78_15)
						arg_75_1:RecordAudio("116011017", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116011", "116011017", "story_v_out_116011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116011", "116011017", "story_v_out_116011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play116011018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116011018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116011019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_2 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_2:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(116011018).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 16 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 16)

				if (16 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 16)) > 0 and var_82_1 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5
					var_82_0 = var_82_0 + 0.3

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = var_82_0 + 0.3
			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_7 and arg_79_1.time_ < var_82_6 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116011019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116011019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116011020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(116011019).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 23 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 23)

				if (23 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 23)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116011020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116011020
		arg_89_1.duration_ = 9.2

		local var_89_0 = {
			zh = 5.166,
			ja = 9.2
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
				arg_89_0:Play116011021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos2079ui_story = arg_89_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).z)
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles = arg_89_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_89_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).z)
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles = arg_89_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_92_1 = arg_89_1.actors_["2079ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect2079ui_story == nil then
				arg_89_1.var_.characterEffect2079ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect2079ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect2079ui_story then
				arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(116011020)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 24 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 24)

				if (24 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 24)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011020", "story_v_out_116011.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011020", "story_v_out_116011.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_116011", "116011020", "story_v_out_116011.awb")

						arg_89_1:RecordAudio("116011020", var_92_11)
						arg_89_1:RecordAudio("116011020", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116011", "116011020", "story_v_out_116011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116011", "116011020", "story_v_out_116011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play116011021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116011021
		arg_93_1.duration_ = 2.53

		local var_93_0 = {
			zh = 2.133,
			ja = 2.533
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
				arg_93_0:Play116011022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) and arg_93_1.var_.characterEffect2079ui_story == nil then
				arg_93_1.var_.characterEffect2079ui_story = arg_93_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) then
				if arg_93_1.var_.characterEffect2079ui_story and not isNil(arg_93_1.actors_["2079ui_story"]) then
					arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_93_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) and arg_93_1.var_.characterEffect2079ui_story then
				arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_93_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(116011021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 12 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 12)

				if (12 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 12)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011021", "story_v_out_116011.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_out_116011", "116011021", "story_v_out_116011.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_116011", "116011021", "story_v_out_116011.awb")

						arg_93_1:RecordAudio("116011021", var_96_8)
						arg_93_1:RecordAudio("116011021", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116011", "116011021", "story_v_out_116011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116011", "116011021", "story_v_out_116011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play116011022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116011022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play116011023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos2079ui_story = arg_97_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).z)
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles = arg_97_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2079ui_story"].transform.position).z)
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["2079ui_story"].transform.localEulerAngles = arg_97_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_100_1 = 0
			local var_100_2 = 1.025

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(116011022).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 41 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 41)

				if (41 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 41)) > 0 and var_100_2 < var_100_5 then
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

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play116011023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116011023
		arg_101_1.duration_ = 6.4

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play116011024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 1.4 < arg_101_1.time_ and arg_101_1.time_ <= 1.4 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_104_0 = 0.6

			if 1.4 <= arg_101_1.time_ and arg_101_1.time_ < 1.4 + var_104_0 then
				local var_104_1, var_104_2 = math.modf((arg_101_1.time_ - 1.4) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_104_2 * 0.13, var_104_2 * 0.13, var_104_2 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= 1.4 + var_104_0 and arg_101_1.time_ < 1.4 + var_104_0 + arg_104_0 then
				manager.ui.mainCamera.transform.localPosition = arg_101_1.var_.shakeOldPos
			end

			local var_104_3 = 1.4

			if 1.4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_3 + 0.6 and arg_101_1.time_ < var_104_3 + 0.6 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_4 = arg_101_1.bgs_.I05f:GetComponent("SpriteRenderer")

				if var_104_4 then
					arg_101_1.var_.alphaOldValueI05f = var_104_4.color.a
					arg_101_1.var_.alphaMatValueI05f = var_104_4
				end

				arg_101_1.var_.alphaOldValueI05f = 1
			end

			local var_104_5 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				if arg_101_1.var_.alphaMatValueI05f then
					arg_101_1.var_.alphaMatValueI05f.color.a = Mathf.Lerp(arg_101_1.var_.alphaOldValueI05f, 0, (arg_101_1.time_ - 0) / var_104_5)
					arg_101_1.var_.alphaMatValueI05f.color = arg_101_1.var_.alphaMatValueI05f.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and arg_101_1.var_.alphaMatValueI05f then
				arg_101_1.var_.alphaMatValueI05f.color.a = 0
				arg_101_1.var_.alphaMatValueI05f.color = arg_101_1.var_.alphaMatValueI05f.color
			end

			if 1.4 < arg_101_1.time_ and arg_101_1.time_ <= 1.4 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_104_7 = 1.4
			local var_104_8 = 0.1

			if 1.4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[324].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(116011023).content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 4 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 4)

				if (4 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 4)) > 0 and var_104_8 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_12 and arg_101_1.time_ < var_104_7 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116011024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116011024
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116011025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun_highpass", "")
			end

			if 0.275 < arg_105_1.time_ and arg_105_1.time_ <= 0.275 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun_highpass", "")
			end

			if 0.433333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 0.433333333333333 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun_highpass", "")
			end

			local var_108_3 = 0
			local var_108_4 = 0.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[324].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(116011024).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 11 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 11)

				if (11 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 11)) > 0 and var_108_4 < var_108_7 then
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

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116011025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116011025
		arg_109_1.duration_ = 7

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116011026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.bgs_.ST02 == nil then
				local var_112_0 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_112_0.name = "ST02"
				var_112_0.transform.parent = arg_109_1.stage_.transform
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_.ST02 = var_112_0
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				local var_112_1 = arg_109_1.bgs_.ST02

				arg_109_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_2 = var_112_1:GetComponent("SpriteRenderer")

				if var_112_2 and var_112_2.sprite then
					local var_112_3 = 2 * (var_112_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_1.transform.localScale = Vector3.New(var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST02" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 2

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_7.a = 0
				arg_109_1.mask_.color = var_112_7
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_112_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_10 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_10

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_10
						arg_109_1.bgmTxt2_.text = var_112_10
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.9 < arg_109_1.time_ and arg_109_1.time_ <= 1.9 + arg_112_0 then
				arg_109_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_112_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_13 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_13

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_13
						arg_109_1.bgmTxt2_.text = var_112_13
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_14 = 2
			local var_112_15 = 0.775

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_16 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_16:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_109_1.dialogCg_.alpha = arg_115_0
				end))
				var_112_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_17 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(116011025).content)

				arg_109_1.text_.text = var_112_17

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 31 <= 0 and var_112_15 or var_112_15 * (utf8.len(var_112_17) / 31)

				if (31 <= 0 and var_112_15 or var_112_15 * (utf8.len(var_112_17) / 31)) > 0 and var_112_15 < var_112_19 then
					arg_109_1.talkMaxDuration = var_112_19
					var_112_14 = var_112_14 + 0.3

					if var_112_19 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_14
					end
				end

				arg_109_1.text_.text = var_112_17
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = var_112_14 + 0.3
			local var_112_21 = math.max(var_112_15, arg_109_1.talkMaxDuration)

			if var_112_14 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_20 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_20) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_20 + var_112_21 and arg_109_1.time_ < var_112_20 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116011026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116011026
		arg_117_1.duration_ = 9.17

		local var_117_0 = {
			zh = 7.266,
			ja = 9.166
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
				arg_117_0:Play116011027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_120_0 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_117_1.stage_.transform)

				var_120_0.name = "1048ui_story"
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1048ui_story"] = var_120_0

				local var_120_1 = var_120_0:GetComponentInChildren(typeof(CharacterEffect))

				var_120_1.enabled = true

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end

				arg_117_1:ShowWeapon(var_120_1.transform, false)

				arg_117_1.var_["1048ui_story" .. "Animator"] = var_120_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_117_1.var_["1048ui_story" .. "Animator"].applyRootMotion = true
				arg_117_1.var_["1048ui_story" .. "LipSync"] = var_120_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_120_3 = arg_117_1.actors_["1048ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1048ui_story == nil then
				arg_117_1.var_.characterEffect1048ui_story = var_120_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_3) then
				if arg_117_1.var_.characterEffect1048ui_story and not isNil(var_120_3) then
					arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1048ui_story then
				arg_117_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_120_6 = arg_117_1.actors_["1048ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1048ui_story = var_120_6.localPosition
			end

			local var_120_7 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				var_120_6.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_117_1.time_ - 0) / var_120_7)
				var_120_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_6.position).x, (manager.ui.mainCamera.transform.position - var_120_6.position).y, (manager.ui.mainCamera.transform.position - var_120_6.position).z)
				var_120_6.localEulerAngles.z = 0
				var_120_6.localEulerAngles.x = 0
				var_120_6.localEulerAngles = var_120_6.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				var_120_6.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_120_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_6.position).x, (manager.ui.mainCamera.transform.position - var_120_6.position).y, (manager.ui.mainCamera.transform.position - var_120_6.position).z)
				var_120_6.localEulerAngles.z = 0
				var_120_6.localEulerAngles.x = 0
				var_120_6.localEulerAngles = var_120_6.localEulerAngles
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_120_8 = 0
			local var_120_9 = 0.55

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(116011026)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 22 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 22)

				if (22 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 22)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011026", "story_v_out_116011.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011026", "story_v_out_116011.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_116011", "116011026", "story_v_out_116011.awb")

						arg_117_1:RecordAudio("116011026", var_120_15)
						arg_117_1:RecordAudio("116011026", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116011", "116011026", "story_v_out_116011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116011", "116011026", "story_v_out_116011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play116011027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116011027
		arg_121_1.duration_ = 9.2

		local var_121_0 = {
			zh = 6.266,
			ja = 9.2
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
				arg_121_0:Play116011028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_0 = 0
			local var_124_1 = 0.75

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(116011027)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 30 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 30)

				if (30 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 30)) > 0 and var_124_1 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011027", "story_v_out_116011.awb") ~= 0 then
					local var_124_6 = manager.audio:GetVoiceLength("story_v_out_116011", "116011027", "story_v_out_116011.awb") / 1000

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end

					if var_124_2.prefab_name ~= "" and arg_121_1.actors_[var_124_2.prefab_name] ~= nil then
						local var_124_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_2.prefab_name].transform, "story_v_out_116011", "116011027", "story_v_out_116011.awb")

						arg_121_1:RecordAudio("116011027", var_124_7)
						arg_121_1:RecordAudio("116011027", var_124_7)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116011", "116011027", "story_v_out_116011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116011", "116011027", "story_v_out_116011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116011028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116011028
		arg_125_1.duration_ = 6.27

		local var_125_0 = {
			zh = 6.266,
			ja = 5.133
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
				arg_125_0:Play116011029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_128_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_125_1.stage_.transform)

				var_128_0.name = "1039ui_story"
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1039ui_story"] = var_128_0

				local var_128_1 = var_128_0:GetComponentInChildren(typeof(CharacterEffect))

				var_128_1.enabled = true

				local var_128_2 = GameObjectTools.GetOrAddComponent(var_128_0, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_1.transform, false)

				arg_125_1.var_["1039ui_story" .. "Animator"] = var_128_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_125_1.var_["1039ui_story" .. "LipSync"] = var_128_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_3 = arg_125_1.actors_["1039ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1039ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1039ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1039ui_story == nil then
				arg_125_1.var_.characterEffect1039ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1039ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1039ui_story then
				arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_128_8 = arg_125_1.actors_["1048ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect1048ui_story == nil then
				arg_125_1.var_.characterEffect1048ui_story = var_128_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_9 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.characterEffect1048ui_story and not isNil(var_128_8) then
					arg_125_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_9)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect1048ui_story then
				arg_125_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_128_10 = arg_125_1.actors_["1039ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_10) and arg_125_1.var_.characterEffect1039ui_story == nil then
				arg_125_1.var_.characterEffect1039ui_story = var_128_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_11 and not isNil(var_128_10) then
				if arg_125_1.var_.characterEffect1039ui_story and not isNil(var_128_10) then
					arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_11 and arg_125_1.time_ < 0 + var_128_11 + arg_128_0 and not isNil(var_128_10) and arg_125_1.var_.characterEffect1039ui_story then
				arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_128_13 = 0
			local var_128_14 = 0.625

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(116011028)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_18 = 25 <= 0 and var_128_14 or var_128_14 * (utf8.len(var_128_16) / 25)

				if (25 <= 0 and var_128_14 or var_128_14 * (utf8.len(var_128_16) / 25)) > 0 and var_128_14 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_13 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_13
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011028", "story_v_out_116011.awb") ~= 0 then
					local var_128_19 = manager.audio:GetVoiceLength("story_v_out_116011", "116011028", "story_v_out_116011.awb") / 1000

					if var_128_19 + var_128_13 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_13
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_116011", "116011028", "story_v_out_116011.awb")

						arg_125_1:RecordAudio("116011028", var_128_20)
						arg_125_1:RecordAudio("116011028", var_128_20)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_116011", "116011028", "story_v_out_116011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_116011", "116011028", "story_v_out_116011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = math.max(var_128_14, arg_125_1.talkMaxDuration)

			if var_128_13 <= arg_125_1.time_ and arg_125_1.time_ < var_128_13 + var_128_21 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_13) / var_128_21

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_13 + var_128_21 and arg_125_1.time_ < var_128_13 + var_128_21 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play116011029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116011029
		arg_129_1.duration_ = 9.1

		local var_129_0 = {
			zh = 9.1,
			ja = 8.7
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
				arg_129_0:Play116011030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1048ui_story"]) and arg_129_1.var_.characterEffect1048ui_story == nil then
				arg_129_1.var_.characterEffect1048ui_story = arg_129_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.0166666666666667

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1048ui_story"]) then
				if arg_129_1.var_.characterEffect1048ui_story and not isNil(arg_129_1.actors_["1048ui_story"]) then
					arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1048ui_story"]) and arg_129_1.var_.characterEffect1048ui_story then
				arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			local var_132_2 = arg_129_1.actors_["1048ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1048ui_story == nil then
				arg_129_1.var_.characterEffect1048ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1048ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1048ui_story then
				arg_129_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_5 = arg_129_1.actors_["1039ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1039ui_story == nil then
				arg_129_1.var_.characterEffect1039ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.characterEffect1039ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_6)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1039ui_story then
				arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_132_7 = 0
			local var_132_8 = 1.2

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(116011029)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 48 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 48)

				if (48 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 48)) > 0 and var_132_8 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011029", "story_v_out_116011.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_116011", "116011029", "story_v_out_116011.awb") / 1000

					if var_132_13 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_7
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_116011", "116011029", "story_v_out_116011.awb")

						arg_129_1:RecordAudio("116011029", var_132_14)
						arg_129_1:RecordAudio("116011029", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_116011", "116011029", "story_v_out_116011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_116011", "116011029", "story_v_out_116011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_15 and arg_129_1.time_ < var_132_7 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play116011030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116011030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116011031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_136_0 = arg_133_1.actors_["1048ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1048ui_story == nil then
				arg_133_1.var_.characterEffect1048ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_1 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 and not isNil(var_136_0) then
				if arg_133_1.var_.characterEffect1048ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_1)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1048ui_story then
				arg_133_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_136_2 = 0
			local var_136_3 = 0.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(116011030).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 19 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 19)

				if (19 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 19)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116011031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116011031
		arg_137_1.duration_ = 13.1

		local var_137_0 = {
			zh = 7.833,
			ja = 13.1
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116011032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1039ui_story"]) and arg_137_1.var_.characterEffect1039ui_story == nil then
				arg_137_1.var_.characterEffect1039ui_story = arg_137_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1039ui_story"]) then
				if arg_137_1.var_.characterEffect1039ui_story and not isNil(arg_137_1.actors_["1039ui_story"]) then
					arg_137_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1039ui_story"]) and arg_137_1.var_.characterEffect1039ui_story then
				arg_137_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_140_2 = 0
			local var_140_3 = 1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(116011031)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 40 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 40)

				if (40 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 40)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011031", "story_v_out_116011.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_116011", "116011031", "story_v_out_116011.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_116011", "116011031", "story_v_out_116011.awb")

						arg_137_1:RecordAudio("116011031", var_140_9)
						arg_137_1:RecordAudio("116011031", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_116011", "116011031", "story_v_out_116011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_116011", "116011031", "story_v_out_116011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116011032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116011032
		arg_141_1.duration_ = 3.97

		local var_141_0 = {
			zh = 3.966,
			ja = 2.866
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
				arg_141_0:Play116011033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) and arg_141_1.var_.characterEffect1039ui_story == nil then
				arg_141_1.var_.characterEffect1039ui_story = arg_141_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) then
				if arg_141_1.var_.characterEffect1039ui_story and not isNil(arg_141_1.actors_["1039ui_story"]) then
					arg_141_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1039ui_story"]) and arg_141_1.var_.characterEffect1039ui_story then
				arg_141_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_144_1 = arg_141_1.actors_["1048ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1048ui_story == nil then
				arg_141_1.var_.characterEffect1048ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1048ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1048ui_story then
				arg_141_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action442")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.325

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(116011032)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 13 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 13)

				if (13 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 13)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011032", "story_v_out_116011.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011032", "story_v_out_116011.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_116011", "116011032", "story_v_out_116011.awb")

						arg_141_1:RecordAudio("116011032", var_144_11)
						arg_141_1:RecordAudio("116011032", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_116011", "116011032", "story_v_out_116011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_116011", "116011032", "story_v_out_116011.awb")
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

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116011033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116011033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116011034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_148_0 = arg_145_1.actors_["1048ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1048ui_story == nil then
				arg_145_1.var_.characterEffect1048ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_1 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 and not isNil(var_148_0) then
				if arg_145_1.var_.characterEffect1048ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_1)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1048ui_story then
				arg_145_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_148_2 = 0
			local var_148_3 = 0.75

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(116011033).content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 30 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_4) / 30)

				if (30 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_4) / 30)) > 0 and var_148_3 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_7 and arg_145_1.time_ < var_148_2 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116011034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116011034
		arg_149_1.duration_ = 12.7

		local var_149_0 = {
			zh = 6.8,
			ja = 12.7
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
				arg_149_0:Play116011035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1039ui_story"]) and arg_149_1.var_.characterEffect1039ui_story == nil then
				arg_149_1.var_.characterEffect1039ui_story = arg_149_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1039ui_story"]) then
				if arg_149_1.var_.characterEffect1039ui_story and not isNil(arg_149_1.actors_["1039ui_story"]) then
					arg_149_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1039ui_story"]) and arg_149_1.var_.characterEffect1039ui_story then
				arg_149_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1048ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1048ui_story == nil then
				arg_149_1.var_.characterEffect1048ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1048ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1048ui_story then
				arg_149_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(116011034)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 33 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 33)

				if (33 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 33)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011034", "story_v_out_116011.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011034", "story_v_out_116011.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_116011", "116011034", "story_v_out_116011.awb")

						arg_149_1:RecordAudio("116011034", var_152_11)
						arg_149_1:RecordAudio("116011034", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_116011", "116011034", "story_v_out_116011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_116011", "116011034", "story_v_out_116011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116011035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116011035
		arg_153_1.duration_ = 8.7

		local var_153_0 = {
			zh = 1.999999999999,
			ja = 8.7
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116011036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1039ui_story"]) and arg_153_1.var_.characterEffect1039ui_story == nil then
				arg_153_1.var_.characterEffect1039ui_story = arg_153_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1039ui_story"]) then
				if arg_153_1.var_.characterEffect1039ui_story and not isNil(arg_153_1.actors_["1039ui_story"]) then
					arg_153_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1039ui_story"]) and arg_153_1.var_.characterEffect1039ui_story then
				arg_153_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_156_1 = arg_153_1.actors_["1048ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1048ui_story == nil then
				arg_153_1.var_.characterEffect1048ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1048ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1048ui_story then
				arg_153_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.175

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(116011035)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 7 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 7)

				if (7 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 7)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011035", "story_v_out_116011.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011035", "story_v_out_116011.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_116011", "116011035", "story_v_out_116011.awb")

						arg_153_1:RecordAudio("116011035", var_156_11)
						arg_153_1:RecordAudio("116011035", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_116011", "116011035", "story_v_out_116011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_116011", "116011035", "story_v_out_116011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116011036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116011036
		arg_157_1.duration_ = 7.1

		local var_157_0 = {
			zh = 7.033,
			ja = 7.1
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
				arg_157_0:Play116011037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story == nil then
				arg_157_1.var_.characterEffect1039ui_story = arg_157_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) then
				if arg_157_1.var_.characterEffect1039ui_story and not isNil(arg_157_1.actors_["1039ui_story"]) then
					arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story then
				arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_160_2 = arg_157_1.actors_["1048ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1048ui_story == nil then
				arg_157_1.var_.characterEffect1048ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect1048ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1048ui_story then
				arg_157_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.85

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(116011036)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 34 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 34)

				if (34 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 34)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011036", "story_v_out_116011.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011036", "story_v_out_116011.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_116011", "116011036", "story_v_out_116011.awb")

						arg_157_1:RecordAudio("116011036", var_160_11)
						arg_157_1:RecordAudio("116011036", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_116011", "116011036", "story_v_out_116011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_116011", "116011036", "story_v_out_116011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116011037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116011037
		arg_161_1.duration_ = 14.43

		local var_161_0 = {
			zh = 7.366,
			ja = 14.433
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
				arg_161_0:Play116011038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1039ui_story"]) and arg_161_1.var_.characterEffect1039ui_story == nil then
				arg_161_1.var_.characterEffect1039ui_story = arg_161_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1039ui_story"]) then
				if arg_161_1.var_.characterEffect1039ui_story and not isNil(arg_161_1.actors_["1039ui_story"]) then
					arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1039ui_story"]) and arg_161_1.var_.characterEffect1039ui_story then
				arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_164_1 = arg_161_1.actors_["1048ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1048ui_story == nil then
				arg_161_1.var_.characterEffect1048ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1048ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1048ui_story then
				arg_161_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(116011037)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 39 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 39)

				if (39 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 39)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011037", "story_v_out_116011.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011037", "story_v_out_116011.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_116011", "116011037", "story_v_out_116011.awb")

						arg_161_1:RecordAudio("116011037", var_164_11)
						arg_161_1:RecordAudio("116011037", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_116011", "116011037", "story_v_out_116011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_116011", "116011037", "story_v_out_116011.awb")
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

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116011038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116011038
		arg_165_1.duration_ = 4.73

		local var_165_0 = {
			zh = 2.333,
			ja = 4.733
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116011039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1048ui_story"]) and arg_165_1.var_.characterEffect1048ui_story == nil then
				arg_165_1.var_.characterEffect1048ui_story = arg_165_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1048ui_story"]) then
				if arg_165_1.var_.characterEffect1048ui_story and not isNil(arg_165_1.actors_["1048ui_story"]) then
					arg_165_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1048ui_story"]) and arg_165_1.var_.characterEffect1048ui_story then
				arg_165_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1039ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1039ui_story == nil then
				arg_165_1.var_.characterEffect1039ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1039ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1039ui_story then
				arg_165_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(116011038)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 10 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 10)

				if (10 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 10)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011038", "story_v_out_116011.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011038", "story_v_out_116011.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_116011", "116011038", "story_v_out_116011.awb")

						arg_165_1:RecordAudio("116011038", var_168_11)
						arg_165_1:RecordAudio("116011038", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_116011", "116011038", "story_v_out_116011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_116011", "116011038", "story_v_out_116011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116011039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116011039
		arg_169_1.duration_ = 9.93

		local var_169_0 = {
			zh = 8.2,
			ja = 9.933
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
				arg_169_0:Play116011040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_172_0 = 0
			local var_172_1 = 0.95

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(116011039)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 38 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 38)

				if (38 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 38)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011039", "story_v_out_116011.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_116011", "116011039", "story_v_out_116011.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_116011", "116011039", "story_v_out_116011.awb")

						arg_169_1:RecordAudio("116011039", var_172_7)
						arg_169_1:RecordAudio("116011039", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116011", "116011039", "story_v_out_116011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116011", "116011039", "story_v_out_116011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116011040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116011040
		arg_173_1.duration_ = 7.27

		local var_173_0 = {
			zh = 7.266,
			ja = 6.2
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116011041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) and arg_173_1.var_.characterEffect1039ui_story == nil then
				arg_173_1.var_.characterEffect1039ui_story = arg_173_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.0638109967112541

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) then
				if arg_173_1.var_.characterEffect1039ui_story and not isNil(arg_173_1.actors_["1039ui_story"]) then
					arg_173_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) and arg_173_1.var_.characterEffect1039ui_story then
				arg_173_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["1048ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1048ui_story == nil then
				arg_173_1.var_.characterEffect1048ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.0638109967112541

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect1048ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1048ui_story then
				arg_173_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.75

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(116011040)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 30 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 30)

				if (30 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 30)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011040", "story_v_out_116011.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011040", "story_v_out_116011.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_116011", "116011040", "story_v_out_116011.awb")

						arg_173_1:RecordAudio("116011040", var_176_11)
						arg_173_1:RecordAudio("116011040", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_116011", "116011040", "story_v_out_116011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_116011", "116011040", "story_v_out_116011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116011041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116011041
		arg_177_1.duration_ = 14.3

		local var_177_0 = {
			zh = 10.2,
			ja = 14.3
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
				arg_177_0:Play116011042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1039ui_story"]) and arg_177_1.var_.characterEffect1039ui_story == nil then
				arg_177_1.var_.characterEffect1039ui_story = arg_177_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1039ui_story"]) then
				if arg_177_1.var_.characterEffect1039ui_story and not isNil(arg_177_1.actors_["1039ui_story"]) then
					arg_177_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1039ui_story"]) and arg_177_1.var_.characterEffect1039ui_story then
				arg_177_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_180_1 = arg_177_1.actors_["1048ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1048ui_story == nil then
				arg_177_1.var_.characterEffect1048ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1048ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1048ui_story then
				arg_177_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_180_4 = 0
			local var_180_5 = 1.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(116011041)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 59 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 59)

				if (59 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 59)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011041", "story_v_out_116011.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011041", "story_v_out_116011.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_116011", "116011041", "story_v_out_116011.awb")

						arg_177_1:RecordAudio("116011041", var_180_11)
						arg_177_1:RecordAudio("116011041", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116011", "116011041", "story_v_out_116011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116011", "116011041", "story_v_out_116011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116011042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116011042
		arg_181_1.duration_ = 4.3

		local var_181_0 = {
			zh = 4.3,
			ja = 3.933
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116011043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story == nil then
				arg_181_1.var_.characterEffect1039ui_story = arg_181_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) then
				if arg_181_1.var_.characterEffect1039ui_story and not isNil(arg_181_1.actors_["1039ui_story"]) then
					arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story then
				arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["1048ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1048ui_story == nil then
				arg_181_1.var_.characterEffect1048ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1048ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1048ui_story then
				arg_181_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_184_4 = 0
			local var_184_5 = 0.325

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(116011042)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 13 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 13)

				if (13 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 13)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011042", "story_v_out_116011.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011042", "story_v_out_116011.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_116011", "116011042", "story_v_out_116011.awb")

						arg_181_1:RecordAudio("116011042", var_184_11)
						arg_181_1:RecordAudio("116011042", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_116011", "116011042", "story_v_out_116011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_116011", "116011042", "story_v_out_116011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116011043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116011043
		arg_185_1.duration_ = 17.6

		local var_185_0 = {
			zh = 11.1,
			ja = 17.6
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
				arg_185_0:Play116011044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_188_0 = 0
			local var_188_1 = 1.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(116011043)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 60 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 60)

				if (60 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 60)) > 0 and var_188_1 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011043", "story_v_out_116011.awb") ~= 0 then
					local var_188_6 = manager.audio:GetVoiceLength("story_v_out_116011", "116011043", "story_v_out_116011.awb") / 1000

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end

					if var_188_2.prefab_name ~= "" and arg_185_1.actors_[var_188_2.prefab_name] ~= nil then
						local var_188_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_2.prefab_name].transform, "story_v_out_116011", "116011043", "story_v_out_116011.awb")

						arg_185_1:RecordAudio("116011043", var_188_7)
						arg_185_1:RecordAudio("116011043", var_188_7)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_116011", "116011043", "story_v_out_116011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_116011", "116011043", "story_v_out_116011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116011044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116011044
		arg_189_1.duration_ = 7.97

		local var_189_0 = {
			zh = 5.766,
			ja = 7.966
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
				arg_189_0:Play116011045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1048ui_story"]) and arg_189_1.var_.characterEffect1048ui_story == nil then
				arg_189_1.var_.characterEffect1048ui_story = arg_189_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1048ui_story"]) then
				if arg_189_1.var_.characterEffect1048ui_story and not isNil(arg_189_1.actors_["1048ui_story"]) then
					arg_189_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1048ui_story"]) and arg_189_1.var_.characterEffect1048ui_story then
				arg_189_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["1039ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1039ui_story == nil then
				arg_189_1.var_.characterEffect1039ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1039ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1039ui_story then
				arg_189_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action454")
			end

			local var_192_4 = 0
			local var_192_5 = 0.675

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(116011044)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 27 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 27)

				if (27 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 27)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011044", "story_v_out_116011.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011044", "story_v_out_116011.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_116011", "116011044", "story_v_out_116011.awb")

						arg_189_1:RecordAudio("116011044", var_192_11)
						arg_189_1:RecordAudio("116011044", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116011", "116011044", "story_v_out_116011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116011", "116011044", "story_v_out_116011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116011045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116011045
		arg_193_1.duration_ = 18.67

		local var_193_0 = {
			zh = 11.033,
			ja = 18.666
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
				arg_193_0:Play116011046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1048ui_story"]) and arg_193_1.var_.characterEffect1048ui_story == nil then
				arg_193_1.var_.characterEffect1048ui_story = arg_193_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1048ui_story"]) then
				if arg_193_1.var_.characterEffect1048ui_story and not isNil(arg_193_1.actors_["1048ui_story"]) then
					arg_193_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1048ui_story"]) and arg_193_1.var_.characterEffect1048ui_story then
				arg_193_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_196_1 = arg_193_1.actors_["1039ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1039ui_story == nil then
				arg_193_1.var_.characterEffect1039ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1039ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1039ui_story then
				arg_193_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_196_4 = 0
			local var_196_5 = 1.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(116011045)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 55 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 55)

				if (55 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 55)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011045", "story_v_out_116011.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011045", "story_v_out_116011.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_116011", "116011045", "story_v_out_116011.awb")

						arg_193_1:RecordAudio("116011045", var_196_11)
						arg_193_1:RecordAudio("116011045", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116011", "116011045", "story_v_out_116011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116011", "116011045", "story_v_out_116011.awb")
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

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116011046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116011046
		arg_197_1.duration_ = 10.07

		local var_197_0 = {
			zh = 9.6,
			ja = 10.066
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
				arg_197_0:Play116011047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1048ui_story"]) and arg_197_1.var_.characterEffect1048ui_story == nil then
				arg_197_1.var_.characterEffect1048ui_story = arg_197_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1048ui_story"]) then
				if arg_197_1.var_.characterEffect1048ui_story and not isNil(arg_197_1.actors_["1048ui_story"]) then
					arg_197_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1048ui_story"]) and arg_197_1.var_.characterEffect1048ui_story then
				arg_197_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["1039ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1039ui_story == nil then
				arg_197_1.var_.characterEffect1039ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect1039ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1039ui_story then
				arg_197_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action443")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_200_4 = 0
			local var_200_5 = 1.1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(116011046)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 44 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 44)

				if (44 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 44)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011046", "story_v_out_116011.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011046", "story_v_out_116011.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_116011", "116011046", "story_v_out_116011.awb")

						arg_197_1:RecordAudio("116011046", var_200_11)
						arg_197_1:RecordAudio("116011046", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116011", "116011046", "story_v_out_116011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116011", "116011046", "story_v_out_116011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116011047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116011047
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116011048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1039ui_story = arg_201_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).z)
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles = arg_201_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1039ui_story"].transform.position).z)
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1039ui_story"].transform.localEulerAngles = arg_201_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1048ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1048ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			local var_204_3 = 0
			local var_204_4 = 0.625

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

				local var_204_5 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(116011047).content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 25 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 25)

				if (25 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 25)) > 0 and var_204_4 < var_204_7 then
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play116011048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116011048
		arg_205_1.duration_ = 15.9

		local var_205_0 = {
			zh = 11.065999999999,
			ja = 15.899999999999
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
				arg_205_0:Play116011049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.bgs_.I05a == nil then
				local var_208_0 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_208_0.name = "I05a"
				var_208_0.transform.parent = arg_205_1.stage_.transform
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_.I05a = var_208_0
			end

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_1 = arg_205_1.bgs_.I05a

				arg_205_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_2 = var_208_1:GetComponent("SpriteRenderer")

				if var_208_2 and var_208_2.sprite then
					local var_208_3 = 2 * (var_208_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_1.transform.localScale = Vector3.New(var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "I05a" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_4 = arg_205_1.actors_["1039ui_story"]

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1039ui_story == nil then
				arg_205_1.var_.characterEffect1039ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_5 = 0.2

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_5 and not isNil(var_208_4) then
				if arg_205_1.var_.characterEffect1039ui_story and not isNil(var_208_4) then
					arg_205_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 3.8) / var_208_5)
				end
			end

			if arg_205_1.time_ >= 3.8 + var_208_5 and arg_205_1.time_ < 3.8 + var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1039ui_story then
				arg_205_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_208_6 = arg_205_1.actors_["1048ui_story"]

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1048ui_story == nil then
				arg_205_1.var_.characterEffect1048ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.2

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect1048ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 3.8 + var_208_7 and arg_205_1.time_ < 3.8 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1048ui_story then
				arg_205_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_208_9 = arg_205_1.actors_["1039ui_story"].transform

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1.var_.moveOldPos1039ui_story = var_208_9.localPosition
			end

			local var_208_10 = 0.001

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_10 then
				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_205_1.time_ - 3.8) / var_208_10)
				var_208_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_9.position).x, (manager.ui.mainCamera.transform.position - var_208_9.position).y, (manager.ui.mainCamera.transform.position - var_208_9.position).z)
				var_208_9.localEulerAngles.z = 0
				var_208_9.localEulerAngles.x = 0
				var_208_9.localEulerAngles = var_208_9.localEulerAngles
			end

			if arg_205_1.time_ >= 3.8 + var_208_10 and arg_205_1.time_ < 3.8 + var_208_10 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_208_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_9.position).x, (manager.ui.mainCamera.transform.position - var_208_9.position).y, (manager.ui.mainCamera.transform.position - var_208_9.position).z)
				var_208_9.localEulerAngles.z = 0
				var_208_9.localEulerAngles.x = 0
				var_208_9.localEulerAngles = var_208_9.localEulerAngles
			end

			local var_208_11 = arg_205_1.actors_["1048ui_story"].transform

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1.var_.moveOldPos1048ui_story = var_208_11.localPosition
			end

			local var_208_12 = 0.001

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_12 then
				var_208_11.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_205_1.time_ - 3.8) / var_208_12)
				var_208_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_11.position).x, (manager.ui.mainCamera.transform.position - var_208_11.position).y, (manager.ui.mainCamera.transform.position - var_208_11.position).z)
				var_208_11.localEulerAngles.z = 0
				var_208_11.localEulerAngles.x = 0
				var_208_11.localEulerAngles = var_208_11.localEulerAngles
			end

			if arg_205_1.time_ >= 3.8 + var_208_12 and arg_205_1.time_ < 3.8 + var_208_12 + arg_208_0 then
				var_208_11.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_208_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_11.position).x, (manager.ui.mainCamera.transform.position - var_208_11.position).y, (manager.ui.mainCamera.transform.position - var_208_11.position).z)
				var_208_11.localEulerAngles.z = 0
				var_208_11.localEulerAngles.x = 0
				var_208_11.localEulerAngles = var_208_11.localEulerAngles
			end

			local var_208_13 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_14 = 2

			if var_208_13 <= arg_205_1.time_ and arg_205_1.time_ < var_208_13 + var_208_14 then
				local var_208_15 = Color.New(0, 0, 0)

				var_208_15.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_13) / var_208_14)
				arg_205_1.mask_.color = var_208_15
			end

			if arg_205_1.time_ >= var_208_13 + var_208_14 and arg_205_1.time_ < var_208_13 + var_208_14 + arg_208_0 then
				local var_208_16 = Color.New(0, 0, 0)

				var_208_16.a = 1
				arg_205_1.mask_.color = var_208_16
			end

			local var_208_17 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_18 = 2

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_18 then
				local var_208_19 = Color.New(0, 0, 0)

				var_208_19.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_17) / var_208_18)
				arg_205_1.mask_.color = var_208_19
			end

			if arg_205_1.time_ >= var_208_17 + var_208_18 and arg_205_1.time_ < var_208_17 + var_208_18 + arg_208_0 then
				local var_208_20 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_20.a = 0
				arg_205_1.mask_.color = var_208_20
			end

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_21 = 3.999999999999
			local var_208_22 = 0.85

			if 3.999999999999 < arg_205_1.time_ and arg_205_1.time_ <= var_208_21 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_23 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_23:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_24 = arg_205_1:GetWordFromCfg(116011048)
				local var_208_25 = arg_205_1:FormatText(var_208_24.content)

				arg_205_1.text_.text = var_208_25

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_27 = 34 <= 0 and var_208_22 or var_208_22 * (utf8.len(var_208_25) / 34)

				if (34 <= 0 and var_208_22 or var_208_22 * (utf8.len(var_208_25) / 34)) > 0 and var_208_22 < var_208_27 then
					arg_205_1.talkMaxDuration = var_208_27
					var_208_21 = var_208_21 + 0.3

					if var_208_27 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_27 + var_208_21
					end
				end

				arg_205_1.text_.text = var_208_25
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011048", "story_v_out_116011.awb") ~= 0 then
					local var_208_28 = manager.audio:GetVoiceLength("story_v_out_116011", "116011048", "story_v_out_116011.awb") / 1000

					if var_208_28 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_28 + var_208_21
					end

					if var_208_24.prefab_name ~= "" and arg_205_1.actors_[var_208_24.prefab_name] ~= nil then
						local var_208_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_24.prefab_name].transform, "story_v_out_116011", "116011048", "story_v_out_116011.awb")

						arg_205_1:RecordAudio("116011048", var_208_29)
						arg_205_1:RecordAudio("116011048", var_208_29)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116011", "116011048", "story_v_out_116011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116011", "116011048", "story_v_out_116011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_30 = var_208_21 + 0.3
			local var_208_31 = math.max(var_208_22, arg_205_1.talkMaxDuration)

			if var_208_21 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_31 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_30) / var_208_31

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_30 + var_208_31 and arg_205_1.time_ < var_208_30 + var_208_31 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play116011049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116011049
		arg_211_1.duration_ = 17.03

		local var_211_0 = {
			zh = 9.633,
			ja = 17.033
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116011050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action447")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_214_0 = 0
			local var_214_1 = 0.975

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(116011049)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 39 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 39)

				if (39 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 39)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011049", "story_v_out_116011.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_116011", "116011049", "story_v_out_116011.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_116011", "116011049", "story_v_out_116011.awb")

						arg_211_1:RecordAudio("116011049", var_214_7)
						arg_211_1:RecordAudio("116011049", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_116011", "116011049", "story_v_out_116011.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_116011", "116011049", "story_v_out_116011.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play116011050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116011050
		arg_215_1.duration_ = 22.83

		local var_215_0 = {
			zh = 13.866,
			ja = 22.833
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116011051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1039ui_story"]) and arg_215_1.var_.characterEffect1039ui_story == nil then
				arg_215_1.var_.characterEffect1039ui_story = arg_215_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1039ui_story"]) then
				if arg_215_1.var_.characterEffect1039ui_story and not isNil(arg_215_1.actors_["1039ui_story"]) then
					arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1039ui_story"]) and arg_215_1.var_.characterEffect1039ui_story then
				arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_218_2 = arg_215_1.actors_["1048ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1048ui_story == nil then
				arg_215_1.var_.characterEffect1048ui_story = var_218_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_3 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.characterEffect1048ui_story and not isNil(var_218_2) then
					arg_215_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_3)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1048ui_story then
				arg_215_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_218_4 = 0
			local var_218_5 = 1.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(116011050)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 62 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 62)

				if (62 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 62)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011050", "story_v_out_116011.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011050", "story_v_out_116011.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_116011", "116011050", "story_v_out_116011.awb")

						arg_215_1:RecordAudio("116011050", var_218_11)
						arg_215_1:RecordAudio("116011050", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116011", "116011050", "story_v_out_116011.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116011", "116011050", "story_v_out_116011.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play116011051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116011051
		arg_219_1.duration_ = 4.8

		local var_219_0 = {
			zh = 2.466,
			ja = 4.8
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116011052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1048ui_story"]) and arg_219_1.var_.characterEffect1048ui_story == nil then
				arg_219_1.var_.characterEffect1048ui_story = arg_219_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1048ui_story"]) then
				if arg_219_1.var_.characterEffect1048ui_story and not isNil(arg_219_1.actors_["1048ui_story"]) then
					arg_219_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1048ui_story"]) and arg_219_1.var_.characterEffect1048ui_story then
				arg_219_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_222_2 = arg_219_1.actors_["1039ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1039ui_story == nil then
				arg_219_1.var_.characterEffect1039ui_story = var_222_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_3 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.characterEffect1039ui_story and not isNil(var_222_2) then
					arg_219_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_3)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1039ui_story then
				arg_219_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_222_4 = 0
			local var_222_5 = 0.275

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(116011051)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 11 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 11)

				if (11 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 11)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011051", "story_v_out_116011.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011051", "story_v_out_116011.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_116011", "116011051", "story_v_out_116011.awb")

						arg_219_1:RecordAudio("116011051", var_222_11)
						arg_219_1:RecordAudio("116011051", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_116011", "116011051", "story_v_out_116011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_116011", "116011051", "story_v_out_116011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play116011052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116011052
		arg_223_1.duration_ = 3.9

		local var_223_0 = {
			zh = 2.933,
			ja = 3.9
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play116011053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1048ui_story"]) and arg_223_1.var_.characterEffect1048ui_story == nil then
				arg_223_1.var_.characterEffect1048ui_story = arg_223_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1048ui_story"]) then
				if arg_223_1.var_.characterEffect1048ui_story and not isNil(arg_223_1.actors_["1048ui_story"]) then
					arg_223_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1048ui_story"]) and arg_223_1.var_.characterEffect1048ui_story then
				arg_223_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_226_1 = arg_223_1.actors_["1039ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1039ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1039ui_story then
				arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(116011052)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)

				if (8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011052", "story_v_out_116011.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011052", "story_v_out_116011.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_116011", "116011052", "story_v_out_116011.awb")

						arg_223_1:RecordAudio("116011052", var_226_11)
						arg_223_1:RecordAudio("116011052", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116011", "116011052", "story_v_out_116011.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116011", "116011052", "story_v_out_116011.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play116011053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116011053
		arg_227_1.duration_ = 14.13

		local var_227_0 = {
			zh = 11.8,
			ja = 14.133
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116011054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1048ui_story"]) and arg_227_1.var_.characterEffect1048ui_story == nil then
				arg_227_1.var_.characterEffect1048ui_story = arg_227_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1048ui_story"]) then
				if arg_227_1.var_.characterEffect1048ui_story and not isNil(arg_227_1.actors_["1048ui_story"]) then
					arg_227_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1048ui_story"]) and arg_227_1.var_.characterEffect1048ui_story then
				arg_227_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_230_2 = arg_227_1.actors_["1039ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.characterEffect1039ui_story == nil then
				arg_227_1.var_.characterEffect1039ui_story = var_230_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_3 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.characterEffect1039ui_story and not isNil(var_230_2) then
					arg_227_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_3)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.characterEffect1039ui_story then
				arg_227_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_230_4 = 0
			local var_230_5 = 1.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(116011053)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 45 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 45)

				if (45 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 45)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011053", "story_v_out_116011.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011053", "story_v_out_116011.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_116011", "116011053", "story_v_out_116011.awb")

						arg_227_1:RecordAudio("116011053", var_230_11)
						arg_227_1:RecordAudio("116011053", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_116011", "116011053", "story_v_out_116011.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_116011", "116011053", "story_v_out_116011.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116011054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116011054
		arg_231_1.duration_ = 5.87

		local var_231_0 = {
			zh = 2.466,
			ja = 5.866
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play116011055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) and arg_231_1.var_.characterEffect1039ui_story == nil then
				arg_231_1.var_.characterEffect1039ui_story = arg_231_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) then
				if arg_231_1.var_.characterEffect1039ui_story and not isNil(arg_231_1.actors_["1039ui_story"]) then
					arg_231_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1039ui_story"]) and arg_231_1.var_.characterEffect1039ui_story then
				arg_231_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_234_2 = arg_231_1.actors_["1048ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1048ui_story == nil then
				arg_231_1.var_.characterEffect1048ui_story = var_234_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.characterEffect1048ui_story and not isNil(var_234_2) then
					arg_231_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_3)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1048ui_story then
				arg_231_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_234_4 = 0
			local var_234_5 = 0.225

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(116011054)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 9 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 9)

				if (9 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 9)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011054", "story_v_out_116011.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011054", "story_v_out_116011.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_116011", "116011054", "story_v_out_116011.awb")

						arg_231_1:RecordAudio("116011054", var_234_11)
						arg_231_1:RecordAudio("116011054", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116011", "116011054", "story_v_out_116011.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116011", "116011054", "story_v_out_116011.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play116011055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116011055
		arg_235_1.duration_ = 12.77

		local var_235_0 = {
			zh = 5.4,
			ja = 12.766
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play116011056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1048ui_story"]) and arg_235_1.var_.characterEffect1048ui_story == nil then
				arg_235_1.var_.characterEffect1048ui_story = arg_235_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1048ui_story"]) then
				if arg_235_1.var_.characterEffect1048ui_story and not isNil(arg_235_1.actors_["1048ui_story"]) then
					arg_235_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1048ui_story"]) and arg_235_1.var_.characterEffect1048ui_story then
				arg_235_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_238_2 = arg_235_1.actors_["1039ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1039ui_story == nil then
				arg_235_1.var_.characterEffect1039ui_story = var_238_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.characterEffect1039ui_story and not isNil(var_238_2) then
					arg_235_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_3)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1039ui_story then
				arg_235_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action429")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_238_4 = 0
			local var_238_5 = 0.575

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(116011055)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 23 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 23)

				if (23 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 23)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011055", "story_v_out_116011.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011055", "story_v_out_116011.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_116011", "116011055", "story_v_out_116011.awb")

						arg_235_1:RecordAudio("116011055", var_238_11)
						arg_235_1:RecordAudio("116011055", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116011", "116011055", "story_v_out_116011.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116011", "116011055", "story_v_out_116011.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116011056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116011056
		arg_239_1.duration_ = 5.2

		local var_239_0 = {
			zh = 3.933,
			ja = 5.2
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play116011057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1048ui_story"]) and arg_239_1.var_.characterEffect1048ui_story == nil then
				arg_239_1.var_.characterEffect1048ui_story = arg_239_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1048ui_story"]) then
				if arg_239_1.var_.characterEffect1048ui_story and not isNil(arg_239_1.actors_["1048ui_story"]) then
					arg_239_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1048ui_story"]) and arg_239_1.var_.characterEffect1048ui_story then
				arg_239_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_242_1 = arg_239_1.actors_["1039ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1039ui_story == nil then
				arg_239_1.var_.characterEffect1039ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1039ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1039ui_story then
				arg_239_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			local var_242_4 = 0
			local var_242_5 = 0.45

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(116011056)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)

				if (18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011056", "story_v_out_116011.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011056", "story_v_out_116011.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_116011", "116011056", "story_v_out_116011.awb")

						arg_239_1:RecordAudio("116011056", var_242_11)
						arg_239_1:RecordAudio("116011056", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116011", "116011056", "story_v_out_116011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116011", "116011056", "story_v_out_116011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116011057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116011057
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116011058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 2 < arg_243_1.time_ and arg_243_1.time_ <= 2 + arg_246_0 then
				local var_246_0 = arg_243_1.bgs_.I05f

				arg_243_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_1 = var_246_0:GetComponent("SpriteRenderer")

				if var_246_1 and var_246_1.sprite then
					local var_246_2 = 2 * (var_246_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_0.transform.localScale = Vector3.New(var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "I05f" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_3 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_4 = 2

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_4 then
				local var_246_5 = Color.New(0, 0, 0)

				var_246_5.a = Mathf.Lerp(0, 1, (arg_243_1.time_ - var_246_3) / var_246_4)
				arg_243_1.mask_.color = var_246_5
			end

			if arg_243_1.time_ >= var_246_3 + var_246_4 and arg_243_1.time_ < var_246_3 + var_246_4 + arg_246_0 then
				local var_246_6 = Color.New(0, 0, 0)

				var_246_6.a = 1
				arg_243_1.mask_.color = var_246_6
			end

			local var_246_7 = 2

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_8 = 2

			if var_246_7 <= arg_243_1.time_ and arg_243_1.time_ < var_246_7 + var_246_8 then
				local var_246_9 = Color.New(0, 0, 0)

				var_246_9.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_7) / var_246_8)
				arg_243_1.mask_.color = var_246_9
			end

			if arg_243_1.time_ >= var_246_7 + var_246_8 and arg_243_1.time_ < var_246_7 + var_246_8 + arg_246_0 then
				local var_246_10 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_10.a = 0
				arg_243_1.mask_.color = var_246_10
			end

			local var_246_11 = arg_243_1.actors_["1048ui_story"].transform

			if 1.966 < arg_243_1.time_ and arg_243_1.time_ <= 1.966 + arg_246_0 then
				arg_243_1.var_.moveOldPos1048ui_story = var_246_11.localPosition
			end

			local var_246_12 = 0.001

			if 1.966 <= arg_243_1.time_ and arg_243_1.time_ < 1.966 + var_246_12 then
				var_246_11.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 1.966) / var_246_12)
				var_246_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_11.position).x, (manager.ui.mainCamera.transform.position - var_246_11.position).y, (manager.ui.mainCamera.transform.position - var_246_11.position).z)
				var_246_11.localEulerAngles.z = 0
				var_246_11.localEulerAngles.x = 0
				var_246_11.localEulerAngles = var_246_11.localEulerAngles
			end

			if arg_243_1.time_ >= 1.966 + var_246_12 and arg_243_1.time_ < 1.966 + var_246_12 + arg_246_0 then
				var_246_11.localPosition = Vector3.New(0, 100, 0)
				var_246_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_11.position).x, (manager.ui.mainCamera.transform.position - var_246_11.position).y, (manager.ui.mainCamera.transform.position - var_246_11.position).z)
				var_246_11.localEulerAngles.z = 0
				var_246_11.localEulerAngles.x = 0
				var_246_11.localEulerAngles = var_246_11.localEulerAngles
			end

			local var_246_13 = arg_243_1.actors_["1039ui_story"].transform

			if 1.966 < arg_243_1.time_ and arg_243_1.time_ <= 1.966 + arg_246_0 then
				arg_243_1.var_.moveOldPos1039ui_story = var_246_13.localPosition
			end

			local var_246_14 = 0.001

			if 1.966 <= arg_243_1.time_ and arg_243_1.time_ < 1.966 + var_246_14 then
				var_246_13.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 1.966) / var_246_14)
				var_246_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_13.position).x, (manager.ui.mainCamera.transform.position - var_246_13.position).y, (manager.ui.mainCamera.transform.position - var_246_13.position).z)
				var_246_13.localEulerAngles.z = 0
				var_246_13.localEulerAngles.x = 0
				var_246_13.localEulerAngles = var_246_13.localEulerAngles
			end

			if arg_243_1.time_ >= 1.966 + var_246_14 and arg_243_1.time_ < 1.966 + var_246_14 + arg_246_0 then
				var_246_13.localPosition = Vector3.New(0, 100, 0)
				var_246_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_13.position).x, (manager.ui.mainCamera.transform.position - var_246_13.position).y, (manager.ui.mainCamera.transform.position - var_246_13.position).z)
				var_246_13.localEulerAngles.z = 0
				var_246_13.localEulerAngles.x = 0
				var_246_13.localEulerAngles = var_246_13.localEulerAngles
			end

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= 2 + arg_246_0 then
				local var_246_15 = arg_243_1.bgs_.I05f:GetComponent("SpriteRenderer")

				if var_246_15 then
					arg_243_1.var_.alphaOldValueI05f = var_246_15.color.a
					arg_243_1.var_.alphaMatValueI05f = var_246_15
				end

				arg_243_1.var_.alphaOldValueI05f = 0
			end

			local var_246_16 = 0.0166666666666667

			if 2 <= arg_243_1.time_ and arg_243_1.time_ < 2 + var_246_16 then
				if arg_243_1.var_.alphaMatValueI05f then
					arg_243_1.var_.alphaMatValueI05f.color.a = Mathf.Lerp(arg_243_1.var_.alphaOldValueI05f, 1, (arg_243_1.time_ - 2) / var_246_16)
					arg_243_1.var_.alphaMatValueI05f.color = arg_243_1.var_.alphaMatValueI05f.color
				end
			end

			if arg_243_1.time_ >= 2 + var_246_16 and arg_243_1.time_ < 2 + var_246_16 + arg_246_0 and arg_243_1.var_.alphaMatValueI05f then
				arg_243_1.var_.alphaMatValueI05f.color.a = 1
				arg_243_1.var_.alphaMatValueI05f.color = arg_243_1.var_.alphaMatValueI05f.color
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_17 = 3.999999999999
			local var_246_18 = 0.55

			if 3.999999999999 < arg_243_1.time_ and arg_243_1.time_ <= var_246_17 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_19 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_19:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_20 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(116011057).content)

				arg_243_1.text_.text = var_246_20

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_22 = 22 <= 0 and var_246_18 or var_246_18 * (utf8.len(var_246_20) / 22)

				if (22 <= 0 and var_246_18 or var_246_18 * (utf8.len(var_246_20) / 22)) > 0 and var_246_18 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22
					var_246_17 = var_246_17 + 0.3

					if var_246_22 + var_246_17 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_17
					end
				end

				arg_243_1.text_.text = var_246_20
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_23 = var_246_17 + 0.3
			local var_246_24 = math.max(var_246_18, arg_243_1.talkMaxDuration)

			if var_246_17 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_23) / var_246_24

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play116011058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116011058
		arg_249_1.duration_ = 4.63

		local var_249_0 = {
			zh = 4.466,
			ja = 4.633
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
				arg_249_0:Play116011059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1048ui_story"]) and arg_249_1.var_.characterEffect1048ui_story == nil then
				arg_249_1.var_.characterEffect1048ui_story = arg_249_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.0166666666666667

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1048ui_story"]) then
				if arg_249_1.var_.characterEffect1048ui_story and not isNil(arg_249_1.actors_["1048ui_story"]) then
					arg_249_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1048ui_story"]) and arg_249_1.var_.characterEffect1048ui_story then
				arg_249_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_252_1 = arg_249_1.actors_["1039ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1039ui_story == nil then
				arg_249_1.var_.characterEffect1039ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.0166666666666667

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1039ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1039ui_story then
				arg_249_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["1039ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1039ui_story = var_252_4.localPosition
			end

			local var_252_5 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 then
				var_252_4.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_249_1.time_ - 0) / var_252_5)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 then
				var_252_4.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_252_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_4.position).x, (manager.ui.mainCamera.transform.position - var_252_4.position).y, (manager.ui.mainCamera.transform.position - var_252_4.position).z)
				var_252_4.localEulerAngles.z = 0
				var_252_4.localEulerAngles.x = 0
				var_252_4.localEulerAngles = var_252_4.localEulerAngles
			end

			local var_252_6 = arg_249_1.actors_["1048ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1048ui_story = var_252_6.localPosition
			end

			local var_252_7 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				var_252_6.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_249_1.time_ - 0) / var_252_7)
				var_252_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_6.position).x, (manager.ui.mainCamera.transform.position - var_252_6.position).y, (manager.ui.mainCamera.transform.position - var_252_6.position).z)
				var_252_6.localEulerAngles.z = 0
				var_252_6.localEulerAngles.x = 0
				var_252_6.localEulerAngles = var_252_6.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				var_252_6.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_252_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_6.position).x, (manager.ui.mainCamera.transform.position - var_252_6.position).y, (manager.ui.mainCamera.transform.position - var_252_6.position).z)
				var_252_6.localEulerAngles.z = 0
				var_252_6.localEulerAngles.x = 0
				var_252_6.localEulerAngles = var_252_6.localEulerAngles
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_252_8 = 0
			local var_252_9 = 0.6

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(116011058)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 24 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 24)

				if (24 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 24)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011058", "story_v_out_116011.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011058", "story_v_out_116011.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_116011", "116011058", "story_v_out_116011.awb")

						arg_249_1:RecordAudio("116011058", var_252_15)
						arg_249_1:RecordAudio("116011058", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116011", "116011058", "story_v_out_116011.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116011", "116011058", "story_v_out_116011.awb")
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play116011059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116011059
		arg_253_1.duration_ = 7.47

		local var_253_0 = {
			zh = 7.166,
			ja = 7.466
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
				arg_253_0:Play116011060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) and arg_253_1.var_.characterEffect1039ui_story == nil then
				arg_253_1.var_.characterEffect1039ui_story = arg_253_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) then
				if arg_253_1.var_.characterEffect1039ui_story and not isNil(arg_253_1.actors_["1039ui_story"]) then
					arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1039ui_story"]) and arg_253_1.var_.characterEffect1039ui_story then
				arg_253_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_256_1 = arg_253_1.actors_["1048ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1048ui_story == nil then
				arg_253_1.var_.characterEffect1048ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1048ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1048ui_story then
				arg_253_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action9_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.775

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(116011059)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 31 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 31)

				if (31 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 31)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011059", "story_v_out_116011.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011059", "story_v_out_116011.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_116011", "116011059", "story_v_out_116011.awb")

						arg_253_1:RecordAudio("116011059", var_256_11)
						arg_253_1:RecordAudio("116011059", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_116011", "116011059", "story_v_out_116011.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_116011", "116011059", "story_v_out_116011.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116011060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116011060
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play116011061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1039ui_story = arg_257_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).z)
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles = arg_257_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1039ui_story"].transform.position).z)
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1039ui_story"].transform.localEulerAngles = arg_257_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1048ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1048ui_story = var_260_1.localPosition
			end

			local var_260_2 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 then
				var_260_1.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_2)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 then
				var_260_1.localPosition = Vector3.New(0, 100, 0)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			local var_260_3 = 0
			local var_260_4 = 0.325

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(116011060).content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 13 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 13)

				if (13 <= 0 and var_260_4 or var_260_4 * (utf8.len(var_260_5) / 13)) > 0 and var_260_4 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_3 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_3
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_4, arg_257_1.talkMaxDuration)

			if var_260_3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_3 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_3) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_3 + var_260_8 and arg_257_1.time_ < var_260_3 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play116011061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116011061
		arg_261_1.duration_ = 6.4

		local var_261_0 = {
			zh = 4.866,
			ja = 6.4
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116011062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1039ui_story"]) and arg_261_1.var_.characterEffect1039ui_story == nil then
				arg_261_1.var_.characterEffect1039ui_story = arg_261_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1039ui_story"]) then
				if arg_261_1.var_.characterEffect1039ui_story and not isNil(arg_261_1.actors_["1039ui_story"]) then
					arg_261_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1039ui_story"]) and arg_261_1.var_.characterEffect1039ui_story then
				arg_261_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_264_2 = arg_261_1.actors_["1039ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1039ui_story = var_264_2.localPosition
			end

			local var_264_3 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 then
				var_264_2.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_261_1.time_ - 0) / var_264_3)
				var_264_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_2.position).x, (manager.ui.mainCamera.transform.position - var_264_2.position).y, (manager.ui.mainCamera.transform.position - var_264_2.position).z)
				var_264_2.localEulerAngles.z = 0
				var_264_2.localEulerAngles.x = 0
				var_264_2.localEulerAngles = var_264_2.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 then
				var_264_2.localPosition = Vector3.New(0, -1.01, -5.9)
				var_264_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_2.position).x, (manager.ui.mainCamera.transform.position - var_264_2.position).y, (manager.ui.mainCamera.transform.position - var_264_2.position).z)
				var_264_2.localEulerAngles.z = 0
				var_264_2.localEulerAngles.x = 0
				var_264_2.localEulerAngles = var_264_2.localEulerAngles
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_264_4 = 0
			local var_264_5 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(116011061)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)

				if (22 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 22)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011061", "story_v_out_116011.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011061", "story_v_out_116011.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_116011", "116011061", "story_v_out_116011.awb")

						arg_261_1:RecordAudio("116011061", var_264_11)
						arg_261_1:RecordAudio("116011061", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_116011", "116011061", "story_v_out_116011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_116011", "116011061", "story_v_out_116011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play116011062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116011062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116011063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1039ui_story = arg_265_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).z)
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles = arg_265_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1039ui_story"].transform.position).z)
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1039ui_story"].transform.localEulerAngles = arg_265_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_16", "se_story_16_leaves", "")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_268_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_4 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_4

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_4
						arg_265_1.bgmTxt2_.text = var_268_4
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_265_1.time_ and arg_265_1.time_ <= 0.2 + arg_268_0 then
				arg_265_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_268_7 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_7 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_7

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_7
						arg_265_1.bgmTxt2_.text = var_268_7
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_268_8 = 0
			local var_268_9 = 0.75

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116011062).content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_12 = 30 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_10) / 30)

				if (30 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_10) / 30)) > 0 and var_268_9 < var_268_12 then
					arg_265_1.talkMaxDuration = var_268_12

					if var_268_12 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_12 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_13 and arg_265_1.time_ < var_268_8 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play116011063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116011063
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play116011064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_274_0 = arg_271_1.actors_["1039ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1039ui_story = var_274_0.localPosition
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_271_1.time_ - 0) / var_274_1)
				var_274_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_0.position).x, (manager.ui.mainCamera.transform.position - var_274_0.position).y, (manager.ui.mainCamera.transform.position - var_274_0.position).z)
				var_274_0.localEulerAngles.z = 0
				var_274_0.localEulerAngles.x = 0
				var_274_0.localEulerAngles = var_274_0.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_274_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_0.position).x, (manager.ui.mainCamera.transform.position - var_274_0.position).y, (manager.ui.mainCamera.transform.position - var_274_0.position).z)
				var_274_0.localEulerAngles.z = 0
				var_274_0.localEulerAngles.x = 0
				var_274_0.localEulerAngles = var_274_0.localEulerAngles
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_274_2 = arg_271_1.actors_["1039ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect1039ui_story == nil then
				arg_271_1.var_.characterEffect1039ui_story = var_274_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_3 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.characterEffect1039ui_story and not isNil(var_274_2) then
					arg_271_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect1039ui_story then
				arg_271_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_274_5 = 0
			local var_274_6 = 0.1

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(116011063)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 4 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 4)

				if (4 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 4)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011063", "story_v_out_116011.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_116011", "116011063", "story_v_out_116011.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_116011", "116011063", "story_v_out_116011.awb")

						arg_271_1:RecordAudio("116011063", var_274_12)
						arg_271_1:RecordAudio("116011063", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116011", "116011063", "story_v_out_116011.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116011", "116011063", "story_v_out_116011.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play116011064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116011064
		arg_275_1.duration_ = 2

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116011065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1048ui_story"]) and arg_275_1.var_.characterEffect1048ui_story == nil then
				arg_275_1.var_.characterEffect1048ui_story = arg_275_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1048ui_story"]) then
				if arg_275_1.var_.characterEffect1048ui_story and not isNil(arg_275_1.actors_["1048ui_story"]) then
					arg_275_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1048ui_story"]) and arg_275_1.var_.characterEffect1048ui_story then
				arg_275_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_278_2 = arg_275_1.actors_["1039ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1039ui_story == nil then
				arg_275_1.var_.characterEffect1039ui_story = var_278_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.characterEffect1039ui_story and not isNil(var_278_2) then
					arg_275_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_3)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1039ui_story then
				arg_275_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_278_4 = arg_275_1.actors_["1048ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1048ui_story = var_278_4.localPosition
			end

			local var_278_5 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 then
				var_278_4.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_275_1.time_ - 0) / var_278_5)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 then
				var_278_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action1_1")
			end

			local var_278_6 = 0
			local var_278_7 = 0.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(116011064)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 4 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 4)

				if (4 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 4)) > 0 and var_278_7 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011064", "story_v_out_116011.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_out_116011", "116011064", "story_v_out_116011.awb") / 1000

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_out_116011", "116011064", "story_v_out_116011.awb")

						arg_275_1:RecordAudio("116011064", var_278_13)
						arg_275_1:RecordAudio("116011064", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_116011", "116011064", "story_v_out_116011.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_116011", "116011064", "story_v_out_116011.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play116011065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116011065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play116011066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1039ui_story = arg_279_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).z)
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles = arg_279_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1039ui_story"].transform.position).z)
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1039ui_story"].transform.localEulerAngles = arg_279_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1048ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1048ui_story = var_282_1.localPosition
			end

			local var_282_2 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 then
				var_282_1.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_2)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 then
				var_282_1.localPosition = Vector3.New(0, 100, 0)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			local var_282_3 = 0
			local var_282_4 = 1.625

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_5 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(116011065).content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 65 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 65)

				if (65 <= 0 and var_282_4 or var_282_4 * (utf8.len(var_282_5) / 65)) > 0 and var_282_4 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_3 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_3
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_4, arg_279_1.talkMaxDuration)

			if var_282_3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_3 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_3) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_3 + var_282_8 and arg_279_1.time_ < var_282_3 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play116011066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116011066
		arg_283_1.duration_ = 5.5

		local var_283_0 = {
			zh = 4.733,
			ja = 5.5
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
				arg_283_0:Play116011067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) and arg_283_1.var_.characterEffect1039ui_story == nil then
				arg_283_1.var_.characterEffect1039ui_story = arg_283_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) then
				if arg_283_1.var_.characterEffect1039ui_story and not isNil(arg_283_1.actors_["1039ui_story"]) then
					arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1039ui_story"]) and arg_283_1.var_.characterEffect1039ui_story then
				arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_286_2 = arg_283_1.actors_["1048ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1048ui_story == nil then
				arg_283_1.var_.characterEffect1048ui_story = var_286_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.characterEffect1048ui_story and not isNil(var_286_2) then
					arg_283_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_3)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1048ui_story then
				arg_283_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_286_4 = arg_283_1.actors_["1048ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1048ui_story = var_286_4.localPosition
			end

			local var_286_5 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 then
				var_286_4.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_283_1.time_ - 0) / var_286_5)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 then
				var_286_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			local var_286_6 = arg_283_1.actors_["1039ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1039ui_story = var_286_6.localPosition
			end

			local var_286_7 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				var_286_6.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_283_1.time_ - 0) / var_286_7)
				var_286_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_6.position).x, (manager.ui.mainCamera.transform.position - var_286_6.position).y, (manager.ui.mainCamera.transform.position - var_286_6.position).z)
				var_286_6.localEulerAngles.z = 0
				var_286_6.localEulerAngles.x = 0
				var_286_6.localEulerAngles = var_286_6.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				var_286_6.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_286_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_6.position).x, (manager.ui.mainCamera.transform.position - var_286_6.position).y, (manager.ui.mainCamera.transform.position - var_286_6.position).z)
				var_286_6.localEulerAngles.z = 0
				var_286_6.localEulerAngles.x = 0
				var_286_6.localEulerAngles = var_286_6.localEulerAngles
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_286_8 = 0
			local var_286_9 = 0.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(116011066)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 20 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 20)

				if (20 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 20)) > 0 and var_286_9 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011066", "story_v_out_116011.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_116011", "116011066", "story_v_out_116011.awb") / 1000

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_out_116011", "116011066", "story_v_out_116011.awb")

						arg_283_1:RecordAudio("116011066", var_286_15)
						arg_283_1:RecordAudio("116011066", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_116011", "116011066", "story_v_out_116011.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_116011", "116011066", "story_v_out_116011.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play116011067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116011067
		arg_287_1.duration_ = 6

		local var_287_0 = {
			zh = 2.5,
			ja = 6
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
				arg_287_0:Play116011068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1048ui_story"]) and arg_287_1.var_.characterEffect1048ui_story == nil then
				arg_287_1.var_.characterEffect1048ui_story = arg_287_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1048ui_story"]) then
				if arg_287_1.var_.characterEffect1048ui_story and not isNil(arg_287_1.actors_["1048ui_story"]) then
					arg_287_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1048ui_story"]) and arg_287_1.var_.characterEffect1048ui_story then
				arg_287_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_290_2 = arg_287_1.actors_["1039ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1039ui_story == nil then
				arg_287_1.var_.characterEffect1039ui_story = var_290_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_3 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.characterEffect1039ui_story and not isNil(var_290_2) then
					arg_287_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_3)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1039ui_story then
				arg_287_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.3

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(116011067)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 12 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 12)

				if (12 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 12)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011067", "story_v_out_116011.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011067", "story_v_out_116011.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_116011", "116011067", "story_v_out_116011.awb")

						arg_287_1:RecordAudio("116011067", var_290_11)
						arg_287_1:RecordAudio("116011067", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116011", "116011067", "story_v_out_116011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116011", "116011067", "story_v_out_116011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116011068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116011068
		arg_291_1.duration_ = 7

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play116011069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1039ui_story = arg_291_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).z)
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles = arg_291_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1039ui_story"].transform.position).z)
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1039ui_story"].transform.localEulerAngles = arg_291_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1048ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1048ui_story = var_294_1.localPosition
			end

			local var_294_2 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 then
				var_294_1.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_2)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 then
				var_294_1.localPosition = Vector3.New(0, 100, 0)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			local var_294_3 = manager.ui.mainCamera.transform

			if 1 < arg_291_1.time_ and arg_291_1.time_ <= 1 + arg_294_0 then
				arg_291_1.var_.shakeOldPos = var_294_3.localPosition
			end

			local var_294_4 = 1

			if 1 <= arg_291_1.time_ and arg_291_1.time_ < 1 + var_294_4 then
				local var_294_5, var_294_6 = math.modf((arg_291_1.time_ - 1) / 0.066)

				var_294_3.localPosition = Vector3.New(var_294_6 * 0.13, var_294_6 * 0.13, var_294_6 * 0.13) + arg_291_1.var_.shakeOldPos
			end

			if arg_291_1.time_ >= 1 + var_294_4 and arg_291_1.time_ < 1 + var_294_4 + arg_294_0 then
				var_294_3.localPosition = arg_291_1.var_.shakeOldPos
			end

			local var_294_7 = 1

			if 1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_7 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			if arg_291_1.time_ >= var_294_7 + 1 and arg_291_1.time_ < var_294_7 + 1 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			if 1 < arg_291_1.time_ and arg_291_1.time_ <= 1 + arg_294_0 then
				arg_291_1:AudioAction("play", "effect", "se_story_16", "se_story_16_loud", "")
			end

			local var_294_9 = 0.5

			if 0.5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_10 = 1

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 then
				local var_294_11 = Color.New(1, 1, 1)

				var_294_11.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_9) / var_294_10)
				arg_291_1.mask_.color = var_294_11
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 then
				local var_294_12 = Color.New(1, 1, 1)

				arg_291_1.mask_.enabled = false
				var_294_12.a = 0
				arg_291_1.mask_.color = var_294_12
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_13 = 2
			local var_294_14 = 0.575

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_13 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_15 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_15:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_16 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(116011068).content)

				arg_291_1.text_.text = var_294_16

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_18 = 23 <= 0 and var_294_14 or var_294_14 * (utf8.len(var_294_16) / 23)

				if (23 <= 0 and var_294_14 or var_294_14 * (utf8.len(var_294_16) / 23)) > 0 and var_294_14 < var_294_18 then
					arg_291_1.talkMaxDuration = var_294_18
					var_294_13 = var_294_13 + 0.3

					if var_294_18 + var_294_13 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_13
					end
				end

				arg_291_1.text_.text = var_294_16
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_19 = var_294_13 + 0.3
			local var_294_20 = math.max(var_294_14, arg_291_1.talkMaxDuration)

			if var_294_13 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_19 + var_294_20 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_19) / var_294_20

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_19 + var_294_20 and arg_291_1.time_ < var_294_19 + var_294_20 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play116011069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116011069
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116011070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.95

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(116011069).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 38 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 38)

				if (38 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 38)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play116011070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116011070
		arg_301_1.duration_ = 1.53

		local var_301_0 = {
			zh = 1.533,
			ja = 1.5
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play116011071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_304_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_2 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_2

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_2
						arg_301_1.bgmTxt2_.text = var_304_2
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_301_1.time_ and arg_301_1.time_ <= 0.266666666666667 + arg_304_0 then
				arg_301_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_304_5 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if "" ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_5 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_5

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_5
						arg_301_1.bgmTxt2_.text = var_304_5
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_304_6 = 0
			local var_304_7 = 0.175

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_8 = arg_301_1:GetWordFromCfg(116011070)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 7 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 7)

				if (7 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 7)) > 0 and var_304_7 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011070", "story_v_out_116011.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_out_116011", "116011070", "story_v_out_116011.awb") / 1000

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end

					if var_304_8.prefab_name ~= "" and arg_301_1.actors_[var_304_8.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_8.prefab_name].transform, "story_v_out_116011", "116011070", "story_v_out_116011.awb")

						arg_301_1:RecordAudio("116011070", var_304_13)
						arg_301_1:RecordAudio("116011070", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_116011", "116011070", "story_v_out_116011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_116011", "116011070", "story_v_out_116011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116011071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116011071
		arg_307_1.duration_ = 1.2

		local var_307_0 = {
			zh = 1.033,
			ja = 1.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116011072(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.05

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:GetWordFromCfg(116011071)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 2 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 2)

				if (2 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 2)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011071", "story_v_out_116011.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011071", "story_v_out_116011.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_116011", "116011071", "story_v_out_116011.awb")

						arg_307_1:RecordAudio("116011071", var_310_6)
						arg_307_1:RecordAudio("116011071", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116011", "116011071", "story_v_out_116011.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116011", "116011071", "story_v_out_116011.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play116011072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116011072
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play116011073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 1.4

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(116011072).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 56 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 56)

				if (56 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 56)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play116011073 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 116011073
		arg_315_1.duration_ = 6

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play116011074(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_318_0 = 1

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				local var_318_1, var_318_2 = math.modf((arg_315_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_318_2 * 0.13, var_318_2 * 0.13, var_318_2 * 0.13) + arg_315_1.var_.shakeOldPos
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				manager.ui.mainCamera.transform.localPosition = arg_315_1.var_.shakeOldPos
			end

			local var_318_3 = 0

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			if arg_315_1.time_ >= var_318_3 + 1 and arg_315_1.time_ < var_318_3 + 1 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fall", "")
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_5 = 0.999999999999
			local var_318_6 = 0.85

			if 0.999999999999 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_7 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_7:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(116011073).content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 34 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 34)

				if (34 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 34)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10
					var_318_5 = var_318_5 + 0.3

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_11 = var_318_5 + 0.3
			local var_318_12 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 + 0.3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_11 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_11) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_11 + var_318_12 and arg_315_1.time_ < var_318_11 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play116011074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 116011074
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play116011075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.3

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(116011074).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 12 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 12)

				if (12 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 12)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play116011075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 116011075
		arg_325_1.duration_ = 1.9

		local var_325_0 = {
			zh = 1.3,
			ja = 1.9
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play116011076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.175

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(116011075)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 7 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 7)

				if (7 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 7)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011075", "story_v_out_116011.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011075", "story_v_out_116011.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_116011", "116011075", "story_v_out_116011.awb")

						arg_325_1:RecordAudio("116011075", var_328_6)
						arg_325_1:RecordAudio("116011075", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_116011", "116011075", "story_v_out_116011.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_116011", "116011075", "story_v_out_116011.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play116011076 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 116011076
		arg_329_1.duration_ = 1

		local var_329_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play116011077(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1039ui_story = arg_329_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).z)
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles = arg_329_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1039ui_story"].transform.position).z)
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1039ui_story"].transform.localEulerAngles = arg_329_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_332_1 = manager.ui.mainCamera.transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.shakeOldPos = var_332_1.localPosition
			end

			local var_332_2 = 0.6

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				local var_332_3, var_332_4 = math.modf((arg_329_1.time_ - 0) / 0.066)

				var_332_1.localPosition = Vector3.New(var_332_4 * 0.13, var_332_4 * 0.13, var_332_4 * 0.13) + arg_329_1.var_.shakeOldPos
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = arg_329_1.var_.shakeOldPos
			end

			local var_332_5 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_5 + 0.6 and arg_329_1.time_ < var_332_5 + 0.6 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_magic", "")
			end

			local var_332_7 = 0
			local var_332_8 = 0.125

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(116011076)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_12 = 5 <= 0 and var_332_8 or var_332_8 * (utf8.len(var_332_10) / 5)

				if (5 <= 0 and var_332_8 or var_332_8 * (utf8.len(var_332_10) / 5)) > 0 and var_332_8 < var_332_12 then
					arg_329_1.talkMaxDuration = var_332_12

					if var_332_12 + var_332_7 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_7
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011076", "story_v_out_116011.awb") ~= 0 then
					local var_332_13 = manager.audio:GetVoiceLength("story_v_out_116011", "116011076", "story_v_out_116011.awb") / 1000

					if var_332_13 + var_332_7 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_7
					end

					if var_332_9.prefab_name ~= "" and arg_329_1.actors_[var_332_9.prefab_name] ~= nil then
						local var_332_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_9.prefab_name].transform, "story_v_out_116011", "116011076", "story_v_out_116011.awb")

						arg_329_1:RecordAudio("116011076", var_332_14)
						arg_329_1:RecordAudio("116011076", var_332_14)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_116011", "116011076", "story_v_out_116011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_116011", "116011076", "story_v_out_116011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_15 = math.max(var_332_8, arg_329_1.talkMaxDuration)

			if var_332_7 <= arg_329_1.time_ and arg_329_1.time_ < var_332_7 + var_332_15 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_7) / var_332_15

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_7 + var_332_15 and arg_329_1.time_ < var_332_7 + var_332_15 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play116011077 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 116011077
		arg_333_1.duration_ = 6.5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play116011078(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_0 = 1.5

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				local var_336_1 = Color.New(1, 1, 1)

				var_336_1.a = Mathf.Lerp(1, 0, (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.mask_.color = var_336_1
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				local var_336_2 = Color.New(1, 1, 1)

				arg_333_1.mask_.enabled = false
				var_336_2.a = 0
				arg_333_1.mask_.color = var_336_2
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_3 = 1.5
			local var_336_4 = 1.05

			if 1.5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_5 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_5:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(116011077).content)

				arg_333_1.text_.text = var_336_6

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_8 = 42 <= 0 and var_336_4 or var_336_4 * (utf8.len(var_336_6) / 42)

				if (42 <= 0 and var_336_4 or var_336_4 * (utf8.len(var_336_6) / 42)) > 0 and var_336_4 < var_336_8 then
					arg_333_1.talkMaxDuration = var_336_8
					var_336_3 = var_336_3 + 0.3

					if var_336_8 + var_336_3 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_3
					end
				end

				arg_333_1.text_.text = var_336_6
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_9 = var_336_3 + 0.3
			local var_336_10 = math.max(var_336_4, arg_333_1.talkMaxDuration)

			if var_336_3 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_9) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play116011078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 116011078
		arg_339_1.duration_ = 2

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play116011079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1048ui_story = arg_339_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).z)
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles = arg_339_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_339_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1048ui_story"].transform.position).z)
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1048ui_story"].transform.localEulerAngles = arg_339_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action8_2")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_342_1 = arg_339_1.actors_["1048ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1048ui_story == nil then
				arg_339_1.var_.characterEffect1048ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1048ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1048ui_story then
				arg_339_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_342_4 = 0
			local var_342_5 = 0.2

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(116011078)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 8 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 8)

				if (8 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 8)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011078", "story_v_out_116011.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011078", "story_v_out_116011.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_116011", "116011078", "story_v_out_116011.awb")

						arg_339_1:RecordAudio("116011078", var_342_11)
						arg_339_1:RecordAudio("116011078", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_116011", "116011078", "story_v_out_116011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_116011", "116011078", "story_v_out_116011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play116011079 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 116011079
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play116011080(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1048ui_story = arg_343_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).z)
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles = arg_343_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1048ui_story"].transform.position).z)
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1048ui_story"].transform.localEulerAngles = arg_343_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_346_1 = 0
			local var_346_2 = 0.775

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(116011079).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 31 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 31)

				if (31 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 31)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play116011080 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 116011080
		arg_347_1.duration_ = 2.13

		local var_347_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play116011081(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1039ui_story"]) and arg_347_1.var_.characterEffect1039ui_story == nil then
				arg_347_1.var_.characterEffect1039ui_story = arg_347_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1039ui_story"]) then
				if arg_347_1.var_.characterEffect1039ui_story and not isNil(arg_347_1.actors_["1039ui_story"]) then
					arg_347_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1039ui_story"]) and arg_347_1.var_.characterEffect1039ui_story then
				arg_347_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_350_2 = arg_347_1.actors_["1039ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1039ui_story = var_350_2.localPosition
			end

			local var_350_3 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 then
				var_350_2.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_347_1.time_ - 0) / var_350_3)
				var_350_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_2.position).x, (manager.ui.mainCamera.transform.position - var_350_2.position).y, (manager.ui.mainCamera.transform.position - var_350_2.position).z)
				var_350_2.localEulerAngles.z = 0
				var_350_2.localEulerAngles.x = 0
				var_350_2.localEulerAngles = var_350_2.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 then
				var_350_2.localPosition = Vector3.New(0, -1.01, -5.9)
				var_350_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_2.position).x, (manager.ui.mainCamera.transform.position - var_350_2.position).y, (manager.ui.mainCamera.transform.position - var_350_2.position).z)
				var_350_2.localEulerAngles.z = 0
				var_350_2.localEulerAngles.x = 0
				var_350_2.localEulerAngles = var_350_2.localEulerAngles
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_350_4 = 0
			local var_350_5 = 0.1

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(116011080)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 4 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 4)

				if (4 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 4)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011080", "story_v_out_116011.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011080", "story_v_out_116011.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_out_116011", "116011080", "story_v_out_116011.awb")

						arg_347_1:RecordAudio("116011080", var_350_11)
						arg_347_1:RecordAudio("116011080", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_116011", "116011080", "story_v_out_116011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_116011", "116011080", "story_v_out_116011.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play116011081 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 116011081
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play116011082(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1039ui_story = arg_351_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).z)
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles = arg_351_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).z)
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles = arg_351_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_354_1 = 0
			local var_354_2 = 0.575

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(116011081).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 23 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 23)

				if (23 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 23)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play116011082 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 116011082
		arg_355_1.duration_ = 3.2

		local var_355_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play116011083(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1039ui_story = arg_355_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).z)
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles = arg_355_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_355_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1039ui_story"].transform.position).z)
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1039ui_story"].transform.localEulerAngles = arg_355_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_358_1 = arg_355_1.actors_["1039ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1039ui_story == nil then
				arg_355_1.var_.characterEffect1039ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1039ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1039ui_story then
				arg_355_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_358_4 = 0
			local var_358_5 = 0.275

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(116011082)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 11 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 11)

				if (11 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 11)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011082", "story_v_out_116011.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_116011", "116011082", "story_v_out_116011.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_116011", "116011082", "story_v_out_116011.awb")

						arg_355_1:RecordAudio("116011082", var_358_11)
						arg_355_1:RecordAudio("116011082", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_116011", "116011082", "story_v_out_116011.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_116011", "116011082", "story_v_out_116011.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play116011083 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 116011083
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play116011084(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1039ui_story = arg_359_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).z)
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles = arg_359_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1039ui_story"].transform.position).z)
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1039ui_story"].transform.localEulerAngles = arg_359_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_16", "se_story_16_skill01", "")
			end

			if 0.3 < arg_359_1.time_ and arg_359_1.time_ <= 0.3 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_16", "se_story_16_skill_loop", "")
			end

			local var_362_3 = 0
			local var_362_4 = 0.775

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_3 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_5 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(116011083).content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 31 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 31)

				if (31 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 31)) > 0 and var_362_4 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_3 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_3
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_4, arg_359_1.talkMaxDuration)

			if var_362_3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_3 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_3) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_3 + var_362_8 and arg_359_1.time_ < var_362_3 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play116011084 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 116011084
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play116011085(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_366_0 = 0.6

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				local var_366_1, var_366_2 = math.modf((arg_363_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_366_2 * 0.13, var_366_2 * 0.13, var_366_2 * 0.13) + arg_363_1.var_.shakeOldPos
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				manager.ui.mainCamera.transform.localPosition = arg_363_1.var_.shakeOldPos
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:AudioAction("stop", "music", "se_story_16", "se_story_16_skill_loop", "")

				local var_366_5 = manager.audio:GetAudioName("se_story_16", "se_story_16_skill_loop")

				if "" ~= "" then
					if arg_363_1.bgmTxt_.text ~= var_366_5 and arg_363_1.bgmTxt_.text ~= "" then
						if arg_363_1.bgmTxt2_.text ~= "" then
							arg_363_1.bgmTxt_.text = arg_363_1.bgmTxt2_.text
						end

						arg_363_1.bgmTxt2_.text = var_366_5

						arg_363_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_363_1.bgmTxt_.text = var_366_5
						arg_363_1.bgmTxt2_.text = var_366_5
					end

					if arg_363_1.bgmTimer then
						arg_363_1.bgmTimer:Stop()

						arg_363_1.bgmTimer = nil
					end

					if arg_363_1.settingData.show_music_name == 1 then
						arg_363_1.musicController:SetSelectedState("show")
						arg_363_1.musicAnimator_:Play("open", 0, 0)

						if arg_363_1.settingData.music_time ~= 0 then
							arg_363_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_363_1.settingData.music_time), function()
								if arg_363_1 == nil or isNil(arg_363_1.bgmTxt_) then
									return
								end

								arg_363_1.musicController:SetSelectedState("hide")
								arg_363_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:AudioAction("play", "effect", "se_story_16", "se_story_16_skill02", "")
			end

			local var_366_7 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			if arg_363_1.time_ >= var_366_7 + 0.6 and arg_363_1.time_ < var_366_7 + 0.6 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end

			local var_366_8 = 0
			local var_366_9 = 1.05

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(116011084).content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 42 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_10) / 42)

				if (42 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_10) / 42)) > 0 and var_366_9 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_13 and arg_363_1.time_ < var_366_8 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play116011085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116011085
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116011086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 1.775

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(116011085).content)

				arg_368_1.text_.text = var_371_1

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_3 = 71 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 71)

				if (71 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 71)) > 0 and var_371_0 < var_371_3 then
					arg_368_1.talkMaxDuration = var_371_3

					if var_371_3 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_3 + 0
					end
				end

				arg_368_1.text_.text = var_371_1
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_4 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_4

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play116011086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 116011086
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play116011087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1039ui_story = arg_372_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).z)
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles = arg_372_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_372_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1039ui_story"].transform.position).z)
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1039ui_story"].transform.localEulerAngles = arg_372_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_375_1 = 0
			local var_375_2 = 0.125

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(116011086)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 7 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 7)

				if (7 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 7)) > 0 and var_375_2 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011086", "story_v_out_116011.awb") ~= 0 then
					local var_375_7 = manager.audio:GetVoiceLength("story_v_out_116011", "116011086", "story_v_out_116011.awb") / 1000

					if var_375_7 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_1
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_116011", "116011086", "story_v_out_116011.awb")

						arg_372_1:RecordAudio("116011086", var_375_8)
						arg_372_1:RecordAudio("116011086", var_375_8)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_116011", "116011086", "story_v_out_116011.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_116011", "116011086", "story_v_out_116011.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_9 and arg_372_1.time_ < var_375_1 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play116011087 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 116011087
		arg_376_1.duration_ = 4.33

		local var_376_0 = {
			zh = 4.333,
			ja = 3.833
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play116011088(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_379_0 = 0
			local var_379_1 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(116011087)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 21 <= 0 and var_379_1 or var_379_1 * (utf8.len(var_379_3) / 21)

				if (21 <= 0 and var_379_1 or var_379_1 * (utf8.len(var_379_3) / 21)) > 0 and var_379_1 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011087", "story_v_out_116011.awb") ~= 0 then
					local var_379_6 = manager.audio:GetVoiceLength("story_v_out_116011", "116011087", "story_v_out_116011.awb") / 1000

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end

					if var_379_2.prefab_name ~= "" and arg_376_1.actors_[var_379_2.prefab_name] ~= nil then
						local var_379_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_2.prefab_name].transform, "story_v_out_116011", "116011087", "story_v_out_116011.awb")

						arg_376_1:RecordAudio("116011087", var_379_7)
						arg_376_1:RecordAudio("116011087", var_379_7)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_116011", "116011087", "story_v_out_116011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_116011", "116011087", "story_v_out_116011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_8 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_8 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_8

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_8 and arg_376_1.time_ < var_379_0 + var_379_8 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play116011088 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 116011088
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play116011089(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1039ui_story = arg_380_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).z)
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles = arg_380_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1039ui_story"].transform.position).z)
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1039ui_story"].transform.localEulerAngles = arg_380_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_383_1 = 0
			local var_383_2 = 1.375

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(116011088).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 55 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 55)

				if (55 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 55)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play116011089 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 116011089
		arg_384_1.duration_ = 4.4

		local var_384_0 = {
			zh = 3.633,
			ja = 4.4
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play116011090(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.35

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:GetWordFromCfg(116011089)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 14 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 14)

				if (14 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 14)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011089", "story_v_out_116011.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011089", "story_v_out_116011.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_116011", "116011089", "story_v_out_116011.awb")

						arg_384_1:RecordAudio("116011089", var_387_6)
						arg_384_1:RecordAudio("116011089", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_116011", "116011089", "story_v_out_116011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_116011", "116011089", "story_v_out_116011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play116011090 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 116011090
		arg_388_1.duration_ = 3.83

		local var_388_0 = {
			zh = 2.466,
			ja = 3.833
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play116011091(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.15

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:GetWordFromCfg(116011090)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.text_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 6 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 6)

				if (6 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 6)) > 0 and var_391_0 < var_391_4 then
					arg_388_1.talkMaxDuration = var_391_4

					if var_391_4 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_4 + 0
					end
				end

				arg_388_1.text_.text = var_391_2
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011090", "story_v_out_116011.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011090", "story_v_out_116011.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_out_116011", "116011090", "story_v_out_116011.awb")

						arg_388_1:RecordAudio("116011090", var_391_6)
						arg_388_1:RecordAudio("116011090", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_116011", "116011090", "story_v_out_116011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_116011", "116011090", "story_v_out_116011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play116011091 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 116011091
		arg_392_1.duration_ = 5.3

		local var_392_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
			arg_392_1.auto_ = false
		end

		function arg_392_1.playNext_(arg_394_0)
			arg_392_1.onStoryFinished_()
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.833333333333333

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039_split_4_1")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:GetWordFromCfg(116011091)
				local var_395_2 = arg_392_1:FormatText(var_395_1.content)

				arg_392_1.text_.text = var_395_2

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 10 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 10)

				if (10 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 10)) > 0 and var_395_0 < var_395_4 then
					arg_392_1.talkMaxDuration = var_395_4

					if var_395_4 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_4 + 0
					end
				end

				arg_392_1.text_.text = var_395_2
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116011", "116011091", "story_v_out_116011.awb") ~= 0 then
					local var_395_5 = manager.audio:GetVoiceLength("story_v_out_116011", "116011091", "story_v_out_116011.awb") / 1000

					if var_395_5 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + 0
					end

					if var_395_1.prefab_name ~= "" and arg_392_1.actors_[var_395_1.prefab_name] ~= nil then
						local var_395_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_1.prefab_name].transform, "story_v_out_116011", "116011091", "story_v_out_116011.awb")

						arg_392_1:RecordAudio("116011091", var_395_6)
						arg_392_1:RecordAudio("116011091", var_395_6)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_116011", "116011091", "story_v_out_116011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_116011", "116011091", "story_v_out_116011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05f",
		"SofdecAsset/story/101160101.usm",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_out_116011.awb"
	},
	skipMarkers = {
		116011001
	}
}
