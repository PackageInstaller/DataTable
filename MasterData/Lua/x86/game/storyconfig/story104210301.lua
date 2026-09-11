return {
	Play421031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 1.999999999999 + 0.3 and arg_1_1.time_ < 1.999999999999 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "ST0601"

			if arg_1_1.bgs_.ST0601 == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.ST0601

				arg_1_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0601" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 1.999999999999
			local var_4_17 = 0.775

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421031001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 31 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 31)

				if (31 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 31)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.45

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(421031002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 18 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 18)

				if (18 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 18)) > 0 and var_12_0 < var_12_3 then
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
	Play421031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(421031003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 40 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 40)

				if (40 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 40)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play421031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421031004
		arg_17_1.duration_ = 8.8

		local var_17_0 = {
			zh = 5.866,
			ja = 8.8
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10102ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10102ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10102ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10102ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10102ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["10102ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10102ui_story == nil then
				arg_17_1.var_.characterEffect10102ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect10102ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10102ui_story then
				arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_8 = 0
			local var_20_9 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(421031004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 25 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 25)

				if (25 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 25)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031004", "story_v_out_421031.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031004", "story_v_out_421031.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_421031", "421031004", "story_v_out_421031.awb")

						arg_17_1:RecordAudio("421031004", var_20_15)
						arg_17_1:RecordAudio("421031004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421031", "421031004", "story_v_out_421031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421031", "421031004", "story_v_out_421031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play421031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story == nil then
				arg_21_1.var_.characterEffect10102ui_story = arg_21_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) then
				if arg_21_1.var_.characterEffect10102ui_story and not isNil(arg_21_1.actors_["10102ui_story"]) then
					arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story then
				arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(421031005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)

				if (18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play421031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102ui_story = arg_25_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(421031006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 19 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 19)

				if (19 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 19)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421031007
		arg_29_1.duration_ = 6.5

		local var_29_0 = {
			zh = 6.5,
			ja = 6.233
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
				arg_29_0:Play421031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1047ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1047ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1047ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1047ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1047ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047ui_story = var_32_3.localPosition

				arg_29_1:ShowWeapon(arg_29_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1047ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1047ui_story == nil then
				arg_29_1.var_.characterEffect1047ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1047ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1047ui_story then
				arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_8 = 0
			local var_32_9 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(421031007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 25 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 25)

				if (25 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 25)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031007", "story_v_out_421031.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031007", "story_v_out_421031.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_421031", "421031007", "story_v_out_421031.awb")

						arg_29_1:RecordAudio("421031007", var_32_15)
						arg_29_1:RecordAudio("421031007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421031", "421031007", "story_v_out_421031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421031", "421031007", "story_v_out_421031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play421031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421031008
		arg_33_1.duration_ = 12.53

		local var_33_0 = {
			zh = 10.066,
			ja = 12.533
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play421031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1047ui_story = arg_33_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).z)
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles = arg_33_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_33_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1047ui_story"].transform.position).z)
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1047ui_story"].transform.localEulerAngles = arg_33_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_1 = 0
			local var_36_2 = 1.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(421031008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 48 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 48)

				if (48 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 48)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031008", "story_v_out_421031.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031008", "story_v_out_421031.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_421031", "421031008", "story_v_out_421031.awb")

						arg_33_1:RecordAudio("421031008", var_36_8)
						arg_33_1:RecordAudio("421031008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421031", "421031008", "story_v_out_421031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421031", "421031008", "story_v_out_421031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421031009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = arg_37_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(arg_37_1.actors_["1047ui_story"]) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1047ui_story"]) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(421031009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 8 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 8)

				if (8 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 8)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play421031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421031010
		arg_41_1.duration_ = 10.4

		local var_41_0 = {
			zh = 7.666,
			ja = 10.4
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1047ui_story = arg_41_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).z)
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles = arg_41_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_41_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).z)
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles = arg_41_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1047ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1047ui_story == nil then
				arg_41_1.var_.characterEffect1047ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1047ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1047ui_story then
				arg_41_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_44_4 = 0
			local var_44_5 = 1.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(421031010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 42 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 42)

				if (42 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 42)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031010", "story_v_out_421031.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031010", "story_v_out_421031.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_421031", "421031010", "story_v_out_421031.awb")

						arg_41_1:RecordAudio("421031010", var_44_11)
						arg_41_1:RecordAudio("421031010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_421031", "421031010", "story_v_out_421031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_421031", "421031010", "story_v_out_421031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play421031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play421031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1047ui_story"]) and arg_45_1.var_.characterEffect1047ui_story == nil then
				arg_45_1.var_.characterEffect1047ui_story = arg_45_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1047ui_story"]) then
				if arg_45_1.var_.characterEffect1047ui_story and not isNil(arg_45_1.actors_["1047ui_story"]) then
					arg_45_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1047ui_story"]) and arg_45_1.var_.characterEffect1047ui_story then
				arg_45_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.55

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(421031011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 22)

				if (22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 22)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play421031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421031012
		arg_49_1.duration_ = 8.5

		local var_49_0 = {
			zh = 7.2,
			ja = 8.5
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
				arg_49_0:Play421031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102ui_story = arg_49_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).z)
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles = arg_49_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_49_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).z)
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles = arg_49_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1047ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = var_52_1.localPosition
			end

			local var_52_2 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 then
				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_49_1.time_ - 0) / var_52_2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(0.74, -1.13, -6.2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			local var_52_3 = arg_49_1.actors_["10102ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect10102ui_story == nil then
				arg_49_1.var_.characterEffect10102ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect10102ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect10102ui_story then
				arg_49_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(421031012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 33 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 33)

				if (33 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 33)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031012", "story_v_out_421031.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031012", "story_v_out_421031.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_421031", "421031012", "story_v_out_421031.awb")

						arg_49_1:RecordAudio("421031012", var_52_13)
						arg_49_1:RecordAudio("421031012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421031", "421031012", "story_v_out_421031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421031", "421031012", "story_v_out_421031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421031013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play421031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) and arg_53_1.var_.characterEffect10102ui_story == nil then
				arg_53_1.var_.characterEffect10102ui_story = arg_53_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) then
				if arg_53_1.var_.characterEffect10102ui_story and not isNil(arg_53_1.actors_["10102ui_story"]) then
					arg_53_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) and arg_53_1.var_.characterEffect10102ui_story then
				arg_53_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(421031013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 27 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 27)

				if (27 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 27)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play421031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421031014
		arg_57_1.duration_ = 3.53

		local var_57_0 = {
			zh = 3.3,
			ja = 3.533
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
				arg_57_0:Play421031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047ui_story = arg_57_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).z)
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles = arg_57_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_57_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1047ui_story"].transform.position).z)
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1047ui_story"].transform.localEulerAngles = arg_57_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1047ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1047ui_story == nil then
				arg_57_1.var_.characterEffect1047ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1047ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1047ui_story then
				arg_57_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_60_4 = 0
			local var_60_5 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(421031014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 5 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 5)

				if (5 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 5)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031014", "story_v_out_421031.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031014", "story_v_out_421031.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_421031", "421031014", "story_v_out_421031.awb")

						arg_57_1:RecordAudio("421031014", var_60_11)
						arg_57_1:RecordAudio("421031014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_421031", "421031014", "story_v_out_421031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_421031", "421031014", "story_v_out_421031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play421031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421031015
		arg_61_1.duration_ = 12.77

		local var_61_0 = {
			zh = 8.933,
			ja = 12.766
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play421031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1047ui_story = arg_61_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).z)
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles = arg_61_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1047ui_story"].transform.position).z)
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1047ui_story"].transform.localEulerAngles = arg_61_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10102ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10102ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if 0.1 < arg_61_1.time_ and arg_61_1.time_ <= 0.1 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_143", "se_story_143_hit_table", "")
			end

			local var_64_4 = 0
			local var_64_5 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_6 = arg_61_1:GetWordFromCfg(421031015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 35 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 35)

				if (35 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 35)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031015", "story_v_out_421031.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031015", "story_v_out_421031.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_421031", "421031015", "story_v_out_421031.awb")

						arg_61_1:RecordAudio("421031015", var_64_11)
						arg_61_1:RecordAudio("421031015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421031", "421031015", "story_v_out_421031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421031", "421031015", "story_v_out_421031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421031016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.8

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(421031016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 32 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 32)

				if (32 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 32)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play421031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421031017
		arg_69_1.duration_ = 6.03

		local var_69_0 = {
			zh = 5.433,
			ja = 6.033
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
				arg_69_0:Play421031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(421031017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 25)

				if (25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 25)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031017", "story_v_out_421031.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031017", "story_v_out_421031.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_421031", "421031017", "story_v_out_421031.awb")

						arg_69_1:RecordAudio("421031017", var_72_6)
						arg_69_1:RecordAudio("421031017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421031", "421031017", "story_v_out_421031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421031", "421031017", "story_v_out_421031.awb")
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
	Play421031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421031018
		arg_73_1.duration_ = 8.13

		local var_73_0 = {
			zh = 5.8,
			ja = 8.133
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play421031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.525

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(421031018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 21 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 21)

				if (21 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 21)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031018", "story_v_out_421031.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031018", "story_v_out_421031.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_421031", "421031018", "story_v_out_421031.awb")

						arg_73_1:RecordAudio("421031018", var_76_6)
						arg_73_1:RecordAudio("421031018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_421031", "421031018", "story_v_out_421031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_421031", "421031018", "story_v_out_421031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play421031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421031019
		arg_77_1.duration_ = 6.5

		local var_77_0 = {
			zh = 4.166,
			ja = 6.5
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
				arg_77_0:Play421031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(421031019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 21 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 21)

				if (21 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 21)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031019", "story_v_out_421031.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031019", "story_v_out_421031.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_421031", "421031019", "story_v_out_421031.awb")

						arg_77_1:RecordAudio("421031019", var_80_6)
						arg_77_1:RecordAudio("421031019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_421031", "421031019", "story_v_out_421031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_421031", "421031019", "story_v_out_421031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play421031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421031020
		arg_81_1.duration_ = 14.33

		local var_81_0 = {
			zh = 11.333,
			ja = 14.333
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
				arg_81_0:Play421031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(421031020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 47)

				if (47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 47)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031020", "story_v_out_421031.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031020", "story_v_out_421031.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_421031", "421031020", "story_v_out_421031.awb")

						arg_81_1:RecordAudio("421031020", var_84_6)
						arg_81_1:RecordAudio("421031020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421031", "421031020", "story_v_out_421031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421031", "421031020", "story_v_out_421031.awb")
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
	Play421031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421031021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play421031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_143", "se_story_143_crack", "")
			end

			local var_88_1 = 0
			local var_88_2 = 1.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(421031021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 65 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 65)

				if (65 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 65)) > 0 and var_88_2 < var_88_5 then
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
	Play421031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421031022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play421031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(421031022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 8)

				if (8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 8)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play421031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421031023
		arg_93_1.duration_ = 2.4

		local var_93_0 = {
			zh = 2.4,
			ja = 2.2
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
				arg_93_0:Play421031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10102ui_story = arg_93_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10102ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10102ui_story == nil then
				arg_93_1.var_.characterEffect10102ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10102ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10102ui_story then
				arg_93_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(421031023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 10 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 10)

				if (10 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 10)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031023", "story_v_out_421031.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031023", "story_v_out_421031.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_421031", "421031023", "story_v_out_421031.awb")

						arg_93_1:RecordAudio("421031023", var_96_11)
						arg_93_1:RecordAudio("421031023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_421031", "421031023", "story_v_out_421031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_421031", "421031023", "story_v_out_421031.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421031024
		arg_97_1.duration_ = 9.8

		local var_97_0 = {
			zh = 7,
			ja = 9.8
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
				arg_97_0:Play421031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1047ui_story = arg_97_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).z)
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles = arg_97_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_97_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1047ui_story"].transform.position).z)
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1047ui_story"].transform.localEulerAngles = arg_97_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10102ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10102ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = arg_97_1.actors_["1047ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1047ui_story == nil then
				arg_97_1.var_.characterEffect1047ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect1047ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1047ui_story then
				arg_97_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_100_6 = arg_97_1.actors_["10102ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10102ui_story == nil then
				arg_97_1.var_.characterEffect10102ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect10102ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10102ui_story then
				arg_97_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_8 = 0
			local var_100_9 = 0.775

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(421031024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 31 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 31)

				if (31 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 31)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031024", "story_v_out_421031.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031024", "story_v_out_421031.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_421031", "421031024", "story_v_out_421031.awb")

						arg_97_1:RecordAudio("421031024", var_100_15)
						arg_97_1:RecordAudio("421031024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421031", "421031024", "story_v_out_421031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421031", "421031024", "story_v_out_421031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421031025
		arg_101_1.duration_ = 2

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play421031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10102ui_story = arg_101_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).z)
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles = arg_101_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_101_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).z)
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles = arg_101_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10102ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10102ui_story == nil then
				arg_101_1.var_.characterEffect10102ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10102ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10102ui_story then
				arg_101_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["1047ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1047ui_story == nil then
				arg_101_1.var_.characterEffect1047ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect1047ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1047ui_story then
				arg_101_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(421031025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 4 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 4)

				if (4 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 4)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031025", "story_v_out_421031.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031025", "story_v_out_421031.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_421031", "421031025", "story_v_out_421031.awb")

						arg_101_1:RecordAudio("421031025", var_104_13)
						arg_101_1:RecordAudio("421031025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421031", "421031025", "story_v_out_421031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421031", "421031025", "story_v_out_421031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play421031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10102ui_story = arg_105_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).z)
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles = arg_105_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10102ui_story"].transform.position).z)
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10102ui_story"].transform.localEulerAngles = arg_105_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1047ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1047ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, 100, 0)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if 0.1 < arg_105_1.time_ and arg_105_1.time_ <= 0.1 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_108_4 = 0
			local var_108_5 = 1.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(421031026).content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 55 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 55)

				if (55 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 55)) > 0 and var_108_5 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_9 and arg_105_1.time_ < var_108_4 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421031027
		arg_109_1.duration_ = 2.53

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(421031027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 10 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 10)

				if (10 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 10)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031027", "story_v_out_421031.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031027", "story_v_out_421031.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_421031", "421031027", "story_v_out_421031.awb")

						arg_109_1:RecordAudio("421031027", var_112_6)
						arg_109_1:RecordAudio("421031027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_421031", "421031027", "story_v_out_421031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_421031", "421031027", "story_v_out_421031.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play421031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421031028
		arg_113_1.duration_ = 13.03

		local var_113_0 = {
			zh = 10.533,
			ja = 13.033
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play421031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(421031028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 44)

				if (44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 44)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031028", "story_v_out_421031.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031028", "story_v_out_421031.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_421031", "421031028", "story_v_out_421031.awb")

						arg_113_1:RecordAudio("421031028", var_116_6)
						arg_113_1:RecordAudio("421031028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421031", "421031028", "story_v_out_421031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421031", "421031028", "story_v_out_421031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play421031029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421031029
		arg_117_1.duration_ = 8.93

		local var_117_0 = {
			zh = 8.433,
			ja = 8.933
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
				arg_117_0:Play421031030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.85

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(421031029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 34 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 34)

				if (34 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 34)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031029", "story_v_out_421031.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031029", "story_v_out_421031.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_421031", "421031029", "story_v_out_421031.awb")

						arg_117_1:RecordAudio("421031029", var_120_6)
						arg_117_1:RecordAudio("421031029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_421031", "421031029", "story_v_out_421031.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_421031", "421031029", "story_v_out_421031.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play421031030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421031030
		arg_121_1.duration_ = 12.97

		local var_121_0 = {
			zh = 9.266,
			ja = 12.966
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
				arg_121_0:Play421031031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.85

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(421031030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 34 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 34)

				if (34 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 34)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031030", "story_v_out_421031.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031030", "story_v_out_421031.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_421031", "421031030", "story_v_out_421031.awb")

						arg_121_1:RecordAudio("421031030", var_124_6)
						arg_121_1:RecordAudio("421031030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421031", "421031030", "story_v_out_421031.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421031", "421031030", "story_v_out_421031.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play421031031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421031031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play421031032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.975

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(421031031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 39 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 39)

				if (39 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 39)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play421031032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421031032
		arg_129_1.duration_ = 2.07

		local var_129_0 = {
			zh = 1.2,
			ja = 2.066
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
				arg_129_0:Play421031033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(421031032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 5 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 5)

				if (5 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 5)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031032", "story_v_out_421031.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031032", "story_v_out_421031.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_421031", "421031032", "story_v_out_421031.awb")

						arg_129_1:RecordAudio("421031032", var_132_6)
						arg_129_1:RecordAudio("421031032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421031", "421031032", "story_v_out_421031.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421031", "421031032", "story_v_out_421031.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play421031033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421031033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play421031034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0.166666666666667 < arg_133_1.time_ and arg_133_1.time_ <= 0.166666666666667 + arg_136_0 then
				arg_133_1:AudioAction("play", "effect", "se_story_140", "se_story_140_catch", "")
			end

			local var_136_1 = 0
			local var_136_2 = 0.9

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(421031033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 36 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 36)

				if (36 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 36)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play421031034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421031034
		arg_137_1.duration_ = 7.2

		local var_137_0 = {
			zh = 4.2,
			ja = 7.2
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
				arg_137_0:Play421031035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.425

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(421031034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 17 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 17)

				if (17 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 17)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031034", "story_v_out_421031.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031034", "story_v_out_421031.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_421031", "421031034", "story_v_out_421031.awb")

						arg_137_1:RecordAudio("421031034", var_140_6)
						arg_137_1:RecordAudio("421031034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421031", "421031034", "story_v_out_421031.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421031", "421031034", "story_v_out_421031.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play421031035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421031035
		arg_141_1.duration_ = 5.03

		local var_141_0 = {
			zh = 4.033,
			ja = 5.033
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
				arg_141_0:Play421031036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(421031035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 14)

				if (14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 14)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031035", "story_v_out_421031.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031035", "story_v_out_421031.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_421031", "421031035", "story_v_out_421031.awb")

						arg_141_1:RecordAudio("421031035", var_144_6)
						arg_141_1:RecordAudio("421031035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_421031", "421031035", "story_v_out_421031.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_421031", "421031035", "story_v_out_421031.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play421031036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421031036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play421031037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.2

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(421031036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 48 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 48)

				if (48 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 48)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play421031037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421031037
		arg_149_1.duration_ = 10.1

		local var_149_0 = {
			zh = 5.1,
			ja = 10.1
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
				arg_149_0:Play421031038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(421031037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 19 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 19)

				if (19 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 19)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031037", "story_v_out_421031.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031037", "story_v_out_421031.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_421031", "421031037", "story_v_out_421031.awb")

						arg_149_1:RecordAudio("421031037", var_152_6)
						arg_149_1:RecordAudio("421031037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_421031", "421031037", "story_v_out_421031.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_421031", "421031037", "story_v_out_421031.awb")
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
	Play421031038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421031038
		arg_153_1.duration_ = 8.2

		local var_153_0 = {
			zh = 6.5,
			ja = 8.2
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
				arg_153_0:Play421031039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(421031038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 27 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 27)

				if (27 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 27)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031038", "story_v_out_421031.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031038", "story_v_out_421031.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_421031", "421031038", "story_v_out_421031.awb")

						arg_153_1:RecordAudio("421031038", var_156_6)
						arg_153_1:RecordAudio("421031038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421031", "421031038", "story_v_out_421031.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421031", "421031038", "story_v_out_421031.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play421031039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421031039
		arg_157_1.duration_ = 11.83

		local var_157_0 = {
			zh = 10.4,
			ja = 11.833
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
				arg_157_0:Play421031040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(421031039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 27)

				if (27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 27)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031039", "story_v_out_421031.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031039", "story_v_out_421031.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_421031", "421031039", "story_v_out_421031.awb")

						arg_157_1:RecordAudio("421031039", var_160_6)
						arg_157_1:RecordAudio("421031039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_421031", "421031039", "story_v_out_421031.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_421031", "421031039", "story_v_out_421031.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play421031040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421031040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play421031041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.2

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(421031040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 48 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 48)

				if (48 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 48)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play421031041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421031041
		arg_165_1.duration_ = 10.83

		local var_165_0 = {
			zh = 10.833,
			ja = 9.266
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
				arg_165_0:Play421031042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.975

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(421031041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 39 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 39)

				if (39 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 39)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031041", "story_v_out_421031.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031041", "story_v_out_421031.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_421031", "421031041", "story_v_out_421031.awb")

						arg_165_1:RecordAudio("421031041", var_168_6)
						arg_165_1:RecordAudio("421031041", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_421031", "421031041", "story_v_out_421031.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_421031", "421031041", "story_v_out_421031.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play421031042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421031042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play421031043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(421031042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 40)

				if (40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 40)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play421031043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421031043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play421031044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047ui_story = arg_173_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1047ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.125

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(421031043)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 5)

				if (5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 5)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031043", "story_v_out_421031.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031043", "story_v_out_421031.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_421031", "421031043", "story_v_out_421031.awb")

						arg_173_1:RecordAudio("421031043", var_176_11)
						arg_173_1:RecordAudio("421031043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421031", "421031043", "story_v_out_421031.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421031", "421031043", "story_v_out_421031.awb")
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

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421031044
		arg_177_1.duration_ = 2.77

		local var_177_0 = {
			zh = 1.566,
			ja = 2.766
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
				arg_177_0:Play421031045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1047ui_story"]) and arg_177_1.var_.characterEffect1047ui_story == nil then
				arg_177_1.var_.characterEffect1047ui_story = arg_177_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1047ui_story"]) then
				if arg_177_1.var_.characterEffect1047ui_story and not isNil(arg_177_1.actors_["1047ui_story"]) then
					arg_177_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1047ui_story"]) and arg_177_1.var_.characterEffect1047ui_story then
				arg_177_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.15

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(421031044)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 6 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 6)

				if (6 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 6)) > 0 and var_180_2 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031044", "story_v_out_421031.awb") ~= 0 then
					local var_180_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031044", "story_v_out_421031.awb") / 1000

					if var_180_7 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_1
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_421031", "421031044", "story_v_out_421031.awb")

						arg_177_1:RecordAudio("421031044", var_180_8)
						arg_177_1:RecordAudio("421031044", var_180_8)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421031", "421031044", "story_v_out_421031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421031", "421031044", "story_v_out_421031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_9 and arg_177_1.time_ < var_180_1 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play421031045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421031045
		arg_181_1.duration_ = 8.9

		local var_181_0 = {
			zh = 6.1,
			ja = 8.9
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
				arg_181_0:Play421031046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1047ui_story = arg_181_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).z)
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles = arg_181_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_181_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1047ui_story"].transform.position).z)
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1047ui_story"].transform.localEulerAngles = arg_181_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1047ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1047ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1047ui_story then
				arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_184_4 = 0
			local var_184_5 = 0.725

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(421031045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 29 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 29)

				if (29 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 29)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031045", "story_v_out_421031.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031045", "story_v_out_421031.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_421031", "421031045", "story_v_out_421031.awb")

						arg_181_1:RecordAudio("421031045", var_184_11)
						arg_181_1:RecordAudio("421031045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421031", "421031045", "story_v_out_421031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421031", "421031045", "story_v_out_421031.awb")
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

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421031046
		arg_185_1.duration_ = 9.8

		local var_185_0 = {
			zh = 8.5,
			ja = 9.8
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
				arg_185_0:Play421031047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1047ui_story"]) and arg_185_1.var_.characterEffect1047ui_story == nil then
				arg_185_1.var_.characterEffect1047ui_story = arg_185_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1047ui_story"]) then
				if arg_185_1.var_.characterEffect1047ui_story and not isNil(arg_185_1.actors_["1047ui_story"]) then
					arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1047ui_story"]) and arg_185_1.var_.characterEffect1047ui_story then
				arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 0.95

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(421031046)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 38 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 38)

				if (38 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 38)) > 0 and var_188_2 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031046", "story_v_out_421031.awb") ~= 0 then
					local var_188_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031046", "story_v_out_421031.awb") / 1000

					if var_188_7 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_1
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_421031", "421031046", "story_v_out_421031.awb")

						arg_185_1:RecordAudio("421031046", var_188_8)
						arg_185_1:RecordAudio("421031046", var_188_8)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421031", "421031046", "story_v_out_421031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421031", "421031046", "story_v_out_421031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_9 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_9

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_9 and arg_185_1.time_ < var_188_1 + var_188_9 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play421031047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421031047
		arg_189_1.duration_ = 11.93

		local var_189_0 = {
			zh = 7.766,
			ja = 11.933
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
				arg_189_0:Play421031048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1047ui_story = arg_189_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1047ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1047ui_story == nil then
				arg_189_1.var_.characterEffect1047ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1047ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1047ui_story then
				arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.775

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(421031047)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 31 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 31)

				if (31 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 31)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031047", "story_v_out_421031.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031047", "story_v_out_421031.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_421031", "421031047", "story_v_out_421031.awb")

						arg_189_1:RecordAudio("421031047", var_192_11)
						arg_189_1:RecordAudio("421031047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_421031", "421031047", "story_v_out_421031.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_421031", "421031047", "story_v_out_421031.awb")
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

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421031048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421031049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1047ui_story = arg_193_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_196_1 = 0
			local var_196_2 = 0.85

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(421031048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 34 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 34)

				if (34 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 34)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421031049
		arg_197_1.duration_ = 3.97

		local var_197_0 = {
			zh = 3.933,
			ja = 3.966
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
				arg_197_0:Play421031050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.425

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(421031049)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 17 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 17)

				if (17 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 17)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031049", "story_v_out_421031.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031049", "story_v_out_421031.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_421031", "421031049", "story_v_out_421031.awb")

						arg_197_1:RecordAudio("421031049", var_200_6)
						arg_197_1:RecordAudio("421031049", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421031", "421031049", "story_v_out_421031.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421031", "421031049", "story_v_out_421031.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play421031050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421031050
		arg_201_1.duration_ = 2

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play421031051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1047ui_story = arg_201_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1047ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1047ui_story == nil then
				arg_201_1.var_.characterEffect1047ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1047ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1047ui_story then
				arg_201_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(421031050)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 4 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 4)

				if (4 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 4)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031050", "story_v_out_421031.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031050", "story_v_out_421031.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_421031", "421031050", "story_v_out_421031.awb")

						arg_201_1:RecordAudio("421031050", var_204_11)
						arg_201_1:RecordAudio("421031050", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421031", "421031050", "story_v_out_421031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421031", "421031050", "story_v_out_421031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421031051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421031052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) and arg_205_1.var_.characterEffect1047ui_story == nil then
				arg_205_1.var_.characterEffect1047ui_story = arg_205_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) then
				if arg_205_1.var_.characterEffect1047ui_story and not isNil(arg_205_1.actors_["1047ui_story"]) then
					arg_205_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1047ui_story"]) and arg_205_1.var_.characterEffect1047ui_story then
				arg_205_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.075

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
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

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(421031051).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 3 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 3)

				if (3 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 3)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play421031052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421031052
		arg_209_1.duration_ = 3.73

		local var_209_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_209_0:Play421031053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = arg_209_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1047ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(421031052)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 4 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 4)

				if (4 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 4)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031052", "story_v_out_421031.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031052", "story_v_out_421031.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_421031", "421031052", "story_v_out_421031.awb")

						arg_209_1:RecordAudio("421031052", var_212_11)
						arg_209_1:RecordAudio("421031052", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421031", "421031052", "story_v_out_421031.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421031", "421031052", "story_v_out_421031.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421031053
		arg_213_1.duration_ = 9.5

		local var_213_0 = {
			zh = 7.666,
			ja = 9.5
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
				arg_213_0:Play421031054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.ST84a == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST84a")
				var_216_0.name = "ST84a"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.ST84a = var_216_0
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.ST84a

				arg_213_1.bgs_.ST84a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "ST84a" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 4

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			if arg_213_1.time_ >= var_216_4 + 0.3 and arg_213_1.time_ < var_216_4 + 0.3 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_5 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_6 = 2

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_5) / var_216_6)
				arg_213_1.mask_.color = var_216_7
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 then
				local var_216_8 = Color.New(0, 0, 0)

				var_216_8.a = 1
				arg_213_1.mask_.color = var_216_8
			end

			local var_216_9 = 2

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 then
				local var_216_11 = Color.New(0, 0, 0)

				var_216_11.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_9) / var_216_10)
				arg_213_1.mask_.color = var_216_11
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 then
				local var_216_12 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_12.a = 0
				arg_213_1.mask_.color = var_216_12
			end

			local var_216_13 = arg_213_1.actors_["1047ui_story"].transform

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = var_216_13.localPosition
			end

			local var_216_14 = 0.001

			if 2 <= arg_213_1.time_ and arg_213_1.time_ < 2 + var_216_14 then
				var_216_13.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 2) / var_216_14)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles
			end

			if arg_213_1.time_ >= 2 + var_216_14 and arg_213_1.time_ < 2 + var_216_14 + arg_216_0 then
				var_216_13.localPosition = Vector3.New(0, 100, 0)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles
			end

			local var_216_15 = arg_213_1.actors_["10102ui_story"].transform

			if 3.76666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 3.76666666666667 + arg_216_0 then
				arg_213_1.var_.moveOldPos10102ui_story = var_216_15.localPosition
			end

			local var_216_16 = 0.001

			if 3.76666666666667 <= arg_213_1.time_ and arg_213_1.time_ < 3.76666666666667 + var_216_16 then
				var_216_15.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_213_1.time_ - 3.76666666666667) / var_216_16)
				var_216_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_15.position).x, (manager.ui.mainCamera.transform.position - var_216_15.position).y, (manager.ui.mainCamera.transform.position - var_216_15.position).z)
				var_216_15.localEulerAngles.z = 0
				var_216_15.localEulerAngles.x = 0
				var_216_15.localEulerAngles = var_216_15.localEulerAngles
			end

			if arg_213_1.time_ >= 3.76666666666667 + var_216_16 and arg_213_1.time_ < 3.76666666666667 + var_216_16 + arg_216_0 then
				var_216_15.localPosition = Vector3.New(0, -0.985, -6.275)
				var_216_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_15.position).x, (manager.ui.mainCamera.transform.position - var_216_15.position).y, (manager.ui.mainCamera.transform.position - var_216_15.position).z)
				var_216_15.localEulerAngles.z = 0
				var_216_15.localEulerAngles.x = 0
				var_216_15.localEulerAngles = var_216_15.localEulerAngles
			end

			local var_216_17 = arg_213_1.actors_["10102ui_story"]

			if 3.76666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 3.76666666666667 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect10102ui_story == nil then
				arg_213_1.var_.characterEffect10102ui_story = var_216_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_18 = 0.200000002980232

			if 3.76666666666667 <= arg_213_1.time_ and arg_213_1.time_ < 3.76666666666667 + var_216_18 and not isNil(var_216_17) then
				if arg_213_1.var_.characterEffect10102ui_story and not isNil(var_216_17) then
					arg_213_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 3.76666666666667 + var_216_18 and arg_213_1.time_ < 3.76666666666667 + var_216_18 + arg_216_0 and not isNil(var_216_17) and arg_213_1.var_.characterEffect10102ui_story then
				arg_213_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 3.76666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 3.76666666666667 + arg_216_0 then
				arg_213_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_1")
			end

			if 3.76666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 3.76666666666667 + arg_216_0 then
				arg_213_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0.3 < arg_213_1.time_ and arg_213_1.time_ <= 0.3 + arg_216_0 then
				arg_213_1:AudioAction("stop", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if 1.5 < arg_213_1.time_ and arg_213_1.time_ <= 1.5 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_22 = 4
			local var_216_23 = 0.525

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_22 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_24 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_24:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_25 = arg_213_1:GetWordFromCfg(421031053)
				local var_216_26 = arg_213_1:FormatText(var_216_25.content)

				arg_213_1.text_.text = var_216_26

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 21 <= 0 and var_216_23 or var_216_23 * (utf8.len(var_216_26) / 21)

				if (21 <= 0 and var_216_23 or var_216_23 * (utf8.len(var_216_26) / 21)) > 0 and var_216_23 < var_216_28 then
					arg_213_1.talkMaxDuration = var_216_28
					var_216_22 = var_216_22 + 0.3

					if var_216_28 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_28 + var_216_22
					end
				end

				arg_213_1.text_.text = var_216_26
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031053", "story_v_out_421031.awb") ~= 0 then
					local var_216_29 = manager.audio:GetVoiceLength("story_v_out_421031", "421031053", "story_v_out_421031.awb") / 1000

					if var_216_29 + var_216_22 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_29 + var_216_22
					end

					if var_216_25.prefab_name ~= "" and arg_213_1.actors_[var_216_25.prefab_name] ~= nil then
						local var_216_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_25.prefab_name].transform, "story_v_out_421031", "421031053", "story_v_out_421031.awb")

						arg_213_1:RecordAudio("421031053", var_216_30)
						arg_213_1:RecordAudio("421031053", var_216_30)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421031", "421031053", "story_v_out_421031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421031", "421031053", "story_v_out_421031.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_31 = var_216_22 + 0.3
			local var_216_32 = math.max(var_216_23, arg_213_1.talkMaxDuration)

			if var_216_22 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_31 + var_216_32 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_31) / var_216_32

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_31 + var_216_32 and arg_213_1.time_ < var_216_31 + var_216_32 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play421031054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 421031054
		arg_219_1.duration_ = 5.13

		local var_219_0 = {
			zh = 4.033,
			ja = 5.133
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
				arg_219_0:Play421031055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1047ui_story = arg_219_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).z)
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles = arg_219_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_219_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1047ui_story"].transform.position).z)
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1047ui_story"].transform.localEulerAngles = arg_219_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10102ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10102ui_story = var_222_1.localPosition
			end

			local var_222_2 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 then
				var_222_1.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_219_1.time_ - 0) / var_222_2)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 then
				var_222_1.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			local var_222_3 = arg_219_1.actors_["1047ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1047ui_story == nil then
				arg_219_1.var_.characterEffect1047ui_story = var_222_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_4 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 and not isNil(var_222_3) then
				if arg_219_1.var_.characterEffect1047ui_story and not isNil(var_222_3) then
					arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1047ui_story then
				arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_222_6 = arg_219_1.actors_["10102ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect10102ui_story == nil then
				arg_219_1.var_.characterEffect10102ui_story = var_222_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_7 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 and not isNil(var_222_6) then
				if arg_219_1.var_.characterEffect10102ui_story and not isNil(var_222_6) then
					arg_219_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_7)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect10102ui_story then
				arg_219_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_222_8 = 0
			local var_222_9 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(421031054)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 19 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 19)

				if (19 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 19)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031054", "story_v_out_421031.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031054", "story_v_out_421031.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_421031", "421031054", "story_v_out_421031.awb")

						arg_219_1:RecordAudio("421031054", var_222_15)
						arg_219_1:RecordAudio("421031054", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_421031", "421031054", "story_v_out_421031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_421031", "421031054", "story_v_out_421031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_16 and arg_219_1.time_ < var_222_8 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play421031055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 421031055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play421031056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) and arg_223_1.var_.characterEffect1047ui_story == nil then
				arg_223_1.var_.characterEffect1047ui_story = arg_223_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) then
				if arg_223_1.var_.characterEffect1047ui_story and not isNil(arg_223_1.actors_["1047ui_story"]) then
					arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1047ui_story"]) and arg_223_1.var_.characterEffect1047ui_story then
				arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.275

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(421031055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 11 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 11)

				if (11 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 11)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play421031056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 421031056
		arg_227_1.duration_ = 4.57

		local var_227_0 = {
			zh = 3.6,
			ja = 4.566
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
				arg_227_0:Play421031057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1047ui_story = arg_227_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).z)
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles = arg_227_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_227_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1047ui_story"].transform.position).z)
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1047ui_story"].transform.localEulerAngles = arg_227_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1047ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1047ui_story == nil then
				arg_227_1.var_.characterEffect1047ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1047ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1047ui_story then
				arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_4 = 0
			local var_230_5 = 0.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(421031056)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)

				if (14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031056", "story_v_out_421031.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031056", "story_v_out_421031.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_421031", "421031056", "story_v_out_421031.awb")

						arg_227_1:RecordAudio("421031056", var_230_11)
						arg_227_1:RecordAudio("421031056", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_421031", "421031056", "story_v_out_421031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_421031", "421031056", "story_v_out_421031.awb")
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

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play421031057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 421031057
		arg_231_1.duration_ = 6.03

		local var_231_0 = {
			zh = 5.866,
			ja = 6.033
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
				arg_231_0:Play421031058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10102ui_story = arg_231_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).z)
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles = arg_231_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_231_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).z)
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles = arg_231_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10102ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10102ui_story == nil then
				arg_231_1.var_.characterEffect10102ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect10102ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10102ui_story then
				arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["1047ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1047ui_story == nil then
				arg_231_1.var_.characterEffect1047ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_5 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_5 and not isNil(var_234_4) then
				if arg_231_1.var_.characterEffect1047ui_story and not isNil(var_234_4) then
					arg_231_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_5)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_5 and arg_231_1.time_ < 0 + var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1047ui_story then
				arg_231_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_2")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_6 = 0
			local var_234_7 = 0.525

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(421031057)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 21 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 21)

				if (21 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 21)) > 0 and var_234_7 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031057", "story_v_out_421031.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031057", "story_v_out_421031.awb") / 1000

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_421031", "421031057", "story_v_out_421031.awb")

						arg_231_1:RecordAudio("421031057", var_234_13)
						arg_231_1:RecordAudio("421031057", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_421031", "421031057", "story_v_out_421031.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_421031", "421031057", "story_v_out_421031.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play421031058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421031058
		arg_235_1.duration_ = 2.33

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_235_0:Play421031059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1047ui_story = arg_235_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).z)
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles = arg_235_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_235_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).z)
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles = arg_235_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1047ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1047ui_story == nil then
				arg_235_1.var_.characterEffect1047ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1047ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1047ui_story then
				arg_235_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["10102ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect10102ui_story == nil then
				arg_235_1.var_.characterEffect10102ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_5 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 and not isNil(var_238_4) then
				if arg_235_1.var_.characterEffect10102ui_story and not isNil(var_238_4) then
					arg_235_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_5)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect10102ui_story then
				arg_235_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_238_6 = 0
			local var_238_7 = 0.2

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:GetWordFromCfg(421031058)
				local var_238_9 = arg_235_1:FormatText(var_238_8.content)

				arg_235_1.text_.text = var_238_9

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 8 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 8)

				if (8 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 8)) > 0 and var_238_7 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_9
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031058", "story_v_out_421031.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031058", "story_v_out_421031.awb") / 1000

					if var_238_12 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_6
					end

					if var_238_8.prefab_name ~= "" and arg_235_1.actors_[var_238_8.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_8.prefab_name].transform, "story_v_out_421031", "421031058", "story_v_out_421031.awb")

						arg_235_1:RecordAudio("421031058", var_238_13)
						arg_235_1:RecordAudio("421031058", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_421031", "421031058", "story_v_out_421031.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_421031", "421031058", "story_v_out_421031.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play421031059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421031059
		arg_239_1.duration_ = 2.1

		local var_239_0 = {
			zh = 2.1,
			ja = 1.999999999999
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
				arg_239_0:Play421031060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10102ui_story = arg_239_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).z)
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles = arg_239_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_239_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10102ui_story"].transform.position).z)
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10102ui_story"].transform.localEulerAngles = arg_239_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["10102ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10102ui_story == nil then
				arg_239_1.var_.characterEffect10102ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect10102ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10102ui_story then
				arg_239_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_242_4 = arg_239_1.actors_["1047ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_5 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 and not isNil(var_242_4) then
				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_4) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_5)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_242_6 = 0
			local var_242_7 = 0.125

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(421031059)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 5 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 5)

				if (5 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 5)) > 0 and var_242_7 < var_242_11 then
					arg_239_1.talkMaxDuration = var_242_11

					if var_242_11 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031059", "story_v_out_421031.awb") ~= 0 then
					local var_242_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031059", "story_v_out_421031.awb") / 1000

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_421031", "421031059", "story_v_out_421031.awb")

						arg_239_1:RecordAudio("421031059", var_242_13)
						arg_239_1:RecordAudio("421031059", var_242_13)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421031", "421031059", "story_v_out_421031.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421031", "421031059", "story_v_out_421031.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play421031060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421031060
		arg_243_1.duration_ = 15.07

		local var_243_0 = {
			zh = 10.6,
			ja = 15.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play421031061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1047ui_story = arg_243_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).z)
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles = arg_243_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_243_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1047ui_story"].transform.position).z)
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1047ui_story"].transform.localEulerAngles = arg_243_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1047ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1047ui_story == nil then
				arg_243_1.var_.characterEffect1047ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1047ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1047ui_story then
				arg_243_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_246_4 = arg_243_1.actors_["10102ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect10102ui_story == nil then
				arg_243_1.var_.characterEffect10102ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_5 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 and not isNil(var_246_4) then
				if arg_243_1.var_.characterEffect10102ui_story and not isNil(var_246_4) then
					arg_243_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_5)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect10102ui_story then
				arg_243_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_246_6 = 0
			local var_246_7 = 1.225

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(421031060)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 49 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 49)

				if (49 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 49)) > 0 and var_246_7 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031060", "story_v_out_421031.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031060", "story_v_out_421031.awb") / 1000

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_421031", "421031060", "story_v_out_421031.awb")

						arg_243_1:RecordAudio("421031060", var_246_13)
						arg_243_1:RecordAudio("421031060", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_421031", "421031060", "story_v_out_421031.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_421031", "421031060", "story_v_out_421031.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play421031061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421031061
		arg_247_1.duration_ = 11.37

		local var_247_0 = {
			zh = 8.9,
			ja = 11.366
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play421031062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(421031061)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)

				if (44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031061", "story_v_out_421031.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031061", "story_v_out_421031.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_421031", "421031061", "story_v_out_421031.awb")

						arg_247_1:RecordAudio("421031061", var_250_6)
						arg_247_1:RecordAudio("421031061", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_421031", "421031061", "story_v_out_421031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_421031", "421031061", "story_v_out_421031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play421031062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421031062
		arg_251_1.duration_ = 9.5

		local var_251_0 = {
			zh = 9.5,
			ja = 6.866
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play421031063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1047ui_story = arg_251_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_1 = 0
			local var_254_2 = 1.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(421031062)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 43 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_4) / 43)

				if (43 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_4) / 43)) > 0 and var_254_2 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031062", "story_v_out_421031.awb") ~= 0 then
					local var_254_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031062", "story_v_out_421031.awb") / 1000

					if var_254_7 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_1
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_421031", "421031062", "story_v_out_421031.awb")

						arg_251_1:RecordAudio("421031062", var_254_8)
						arg_251_1:RecordAudio("421031062", var_254_8)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421031", "421031062", "story_v_out_421031.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421031", "421031062", "story_v_out_421031.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_9 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_9 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_9

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_9 and arg_251_1.time_ < var_254_1 + var_254_9 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play421031063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421031063
		arg_255_1.duration_ = 9

		local var_255_0 = {
			zh = 3.933,
			ja = 9
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play421031064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10102ui_story = arg_255_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).z)
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles = arg_255_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_255_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10102ui_story"].transform.position).z)
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10102ui_story"].transform.localEulerAngles = arg_255_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["10102ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10102ui_story == nil then
				arg_255_1.var_.characterEffect10102ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect10102ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10102ui_story then
				arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["1047ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1047ui_story == nil then
				arg_255_1.var_.characterEffect1047ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_5 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_5 and not isNil(var_258_4) then
				if arg_255_1.var_.characterEffect1047ui_story and not isNil(var_258_4) then
					arg_255_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_5)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_5 and arg_255_1.time_ < 0 + var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1047ui_story then
				arg_255_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_6 = 0
			local var_258_7 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:GetWordFromCfg(421031063)
				local var_258_9 = arg_255_1:FormatText(var_258_8.content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 21 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 21)

				if (21 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 21)) > 0 and var_258_7 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031063", "story_v_out_421031.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031063", "story_v_out_421031.awb") / 1000

					if var_258_12 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_6
					end

					if var_258_8.prefab_name ~= "" and arg_255_1.actors_[var_258_8.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_8.prefab_name].transform, "story_v_out_421031", "421031063", "story_v_out_421031.awb")

						arg_255_1:RecordAudio("421031063", var_258_13)
						arg_255_1:RecordAudio("421031063", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_421031", "421031063", "story_v_out_421031.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_421031", "421031063", "story_v_out_421031.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421031064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 421031064
		arg_259_1.duration_ = 7.63

		local var_259_0 = {
			zh = 4.5,
			ja = 7.633
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play421031065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1047ui_story = arg_259_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).z)
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles = arg_259_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_259_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).z)
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles = arg_259_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1047ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1047ui_story == nil then
				arg_259_1.var_.characterEffect1047ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1047ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1047ui_story then
				arg_259_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_262_4 = arg_259_1.actors_["10102ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10102ui_story == nil then
				arg_259_1.var_.characterEffect10102ui_story = var_262_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_5 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 and not isNil(var_262_4) then
				if arg_259_1.var_.characterEffect10102ui_story and not isNil(var_262_4) then
					arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_5)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10102ui_story then
				arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_262_6 = 0
			local var_262_7 = 0.55

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(421031064)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 22 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 22)

				if (22 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 22)) > 0 and var_262_7 < var_262_11 then
					arg_259_1.talkMaxDuration = var_262_11

					if var_262_11 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031064", "story_v_out_421031.awb") ~= 0 then
					local var_262_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031064", "story_v_out_421031.awb") / 1000

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end

					if var_262_8.prefab_name ~= "" and arg_259_1.actors_[var_262_8.prefab_name] ~= nil then
						local var_262_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_8.prefab_name].transform, "story_v_out_421031", "421031064", "story_v_out_421031.awb")

						arg_259_1:RecordAudio("421031064", var_262_13)
						arg_259_1:RecordAudio("421031064", var_262_13)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_421031", "421031064", "story_v_out_421031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_421031", "421031064", "story_v_out_421031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play421031065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 421031065
		arg_263_1.duration_ = 2.2

		local var_263_0 = {
			zh = 2.066,
			ja = 2.2
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
				arg_263_0:Play421031066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10102ui_story = arg_263_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).z)
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles = arg_263_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_263_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10102ui_story"].transform.position).z)
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10102ui_story"].transform.localEulerAngles = arg_263_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10102ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10102ui_story == nil then
				arg_263_1.var_.characterEffect10102ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10102ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10102ui_story then
				arg_263_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_266_4 = arg_263_1.actors_["1047ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1047ui_story == nil then
				arg_263_1.var_.characterEffect1047ui_story = var_266_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_5 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 and not isNil(var_266_4) then
				if arg_263_1.var_.characterEffect1047ui_story and not isNil(var_266_4) then
					arg_263_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_5)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1047ui_story then
				arg_263_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_266_6 = 0
			local var_266_7 = 0.175

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:GetWordFromCfg(421031065)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 7 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 7)

				if (7 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 7)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031065", "story_v_out_421031.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031065", "story_v_out_421031.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_421031", "421031065", "story_v_out_421031.awb")

						arg_263_1:RecordAudio("421031065", var_266_13)
						arg_263_1:RecordAudio("421031065", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_421031", "421031065", "story_v_out_421031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_421031", "421031065", "story_v_out_421031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 421031066
		arg_267_1.duration_ = 18.9

		local var_267_0 = {
			zh = 13.5,
			ja = 18.9
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
				arg_267_0:Play421031067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1047ui_story = arg_267_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).z)
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles = arg_267_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_267_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).z)
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles = arg_267_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1047ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1047ui_story == nil then
				arg_267_1.var_.characterEffect1047ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1047ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1047ui_story then
				arg_267_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["10102ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10102ui_story == nil then
				arg_267_1.var_.characterEffect10102ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_5 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 and not isNil(var_270_4) then
				if arg_267_1.var_.characterEffect10102ui_story and not isNil(var_270_4) then
					arg_267_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_5)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10102ui_story then
				arg_267_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_270_6 = 0
			local var_270_7 = 1.6

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(421031066)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 64 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 64)

				if (64 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 64)) > 0 and var_270_7 < var_270_11 then
					arg_267_1.talkMaxDuration = var_270_11

					if var_270_11 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031066", "story_v_out_421031.awb") ~= 0 then
					local var_270_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031066", "story_v_out_421031.awb") / 1000

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_421031", "421031066", "story_v_out_421031.awb")

						arg_267_1:RecordAudio("421031066", var_270_13)
						arg_267_1:RecordAudio("421031066", var_270_13)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_421031", "421031066", "story_v_out_421031.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_421031", "421031066", "story_v_out_421031.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play421031067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 421031067
		arg_271_1.duration_ = 6.83

		local var_271_0 = {
			zh = 4.733,
			ja = 6.833
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
				arg_271_0:Play421031068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1047ui_story = arg_271_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).z)
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles = arg_271_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_271_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).z)
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles = arg_271_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_274_1 = 0
			local var_274_2 = 0.525

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:GetWordFromCfg(421031067)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_6 = 21 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_4) / 21)

				if (21 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_4) / 21)) > 0 and var_274_2 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031067", "story_v_out_421031.awb") ~= 0 then
					local var_274_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031067", "story_v_out_421031.awb") / 1000

					if var_274_7 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_1
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_421031", "421031067", "story_v_out_421031.awb")

						arg_271_1:RecordAudio("421031067", var_274_8)
						arg_271_1:RecordAudio("421031067", var_274_8)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_421031", "421031067", "story_v_out_421031.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_421031", "421031067", "story_v_out_421031.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_9 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_9 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_9

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_9 and arg_271_1.time_ < var_274_1 + var_274_9 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 421031068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play421031069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) and arg_275_1.var_.characterEffect1047ui_story == nil then
				arg_275_1.var_.characterEffect1047ui_story = arg_275_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) then
				if arg_275_1.var_.characterEffect1047ui_story and not isNil(arg_275_1.actors_["1047ui_story"]) then
					arg_275_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) and arg_275_1.var_.characterEffect1047ui_story then
				arg_275_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.725

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(421031068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)

				if (29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play421031069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 421031069
		arg_279_1.duration_ = 4.37

		local var_279_0 = {
			zh = 2.833,
			ja = 4.366
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play421031070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1047ui_story = arg_279_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).z)
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles = arg_279_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_279_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).z)
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles = arg_279_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1047ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1047ui_story == nil then
				arg_279_1.var_.characterEffect1047ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1047ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1047ui_story then
				arg_279_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_282_4 = 0
			local var_282_5 = 0.25

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(421031069)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 10 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 10)

				if (10 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 10)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031069", "story_v_out_421031.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031069", "story_v_out_421031.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_421031", "421031069", "story_v_out_421031.awb")

						arg_279_1:RecordAudio("421031069", var_282_11)
						arg_279_1:RecordAudio("421031069", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_421031", "421031069", "story_v_out_421031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_421031", "421031069", "story_v_out_421031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play421031070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 421031070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play421031071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) and arg_283_1.var_.characterEffect1047ui_story == nil then
				arg_283_1.var_.characterEffect1047ui_story = arg_283_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) then
				if arg_283_1.var_.characterEffect1047ui_story and not isNil(arg_283_1.actors_["1047ui_story"]) then
					arg_283_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) and arg_283_1.var_.characterEffect1047ui_story then
				arg_283_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(421031070).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 19 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 19)

				if (19 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 19)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play421031071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 421031071
		arg_287_1.duration_ = 22.23

		local var_287_0 = {
			zh = 12.766,
			ja = 22.233
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
				arg_287_0:Play421031072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1047ui_story = arg_287_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).z)
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles = arg_287_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_287_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).z)
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles = arg_287_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1047ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1047ui_story == nil then
				arg_287_1.var_.characterEffect1047ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1047ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1047ui_story then
				arg_287_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_290_4 = 0
			local var_290_5 = 1.75

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(421031071)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 61 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 61)

				if (61 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 61)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031071", "story_v_out_421031.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031071", "story_v_out_421031.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_421031", "421031071", "story_v_out_421031.awb")

						arg_287_1:RecordAudio("421031071", var_290_11)
						arg_287_1:RecordAudio("421031071", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_421031", "421031071", "story_v_out_421031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_421031", "421031071", "story_v_out_421031.awb")
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

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 421031072
		arg_291_1.duration_ = 6.57

		local var_291_0 = {
			zh = 5.666,
			ja = 6.566
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
				arg_291_0:Play421031073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1047ui_story = arg_291_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).z)
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles = arg_291_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_291_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1047ui_story"].transform.position).z)
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1047ui_story"].transform.localEulerAngles = arg_291_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_294_1 = arg_291_1.actors_["1047ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1047ui_story == nil then
				arg_291_1.var_.characterEffect1047ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1047ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1047ui_story then
				arg_291_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_294_4 = 0
			local var_294_5 = 0.675

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(421031072)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 27 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 27)

				if (27 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 27)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031072", "story_v_out_421031.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031072", "story_v_out_421031.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_out_421031", "421031072", "story_v_out_421031.awb")

						arg_291_1:RecordAudio("421031072", var_294_11)
						arg_291_1:RecordAudio("421031072", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_421031", "421031072", "story_v_out_421031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_421031", "421031072", "story_v_out_421031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play421031073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 421031073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play421031074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1047ui_story"]) and arg_295_1.var_.characterEffect1047ui_story == nil then
				arg_295_1.var_.characterEffect1047ui_story = arg_295_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1047ui_story"]) then
				if arg_295_1.var_.characterEffect1047ui_story and not isNil(arg_295_1.actors_["1047ui_story"]) then
					arg_295_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1047ui_story"]) and arg_295_1.var_.characterEffect1047ui_story then
				arg_295_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.95

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(421031073).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 38 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 38)

				if (38 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 38)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play421031074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 421031074
		arg_299_1.duration_ = 16.87

		local var_299_0 = {
			zh = 12.1,
			ja = 16.866
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
				arg_299_0:Play421031075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1047ui_story = arg_299_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).z)
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles = arg_299_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_299_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1047ui_story"].transform.position).z)
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1047ui_story"].transform.localEulerAngles = arg_299_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1047ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1047ui_story == nil then
				arg_299_1.var_.characterEffect1047ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1047ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1047ui_story then
				arg_299_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_302_4 = 0
			local var_302_5 = 1.375

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(421031074)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 55 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 55)

				if (55 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 55)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031074", "story_v_out_421031.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031074", "story_v_out_421031.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_421031", "421031074", "story_v_out_421031.awb")

						arg_299_1:RecordAudio("421031074", var_302_11)
						arg_299_1:RecordAudio("421031074", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_421031", "421031074", "story_v_out_421031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_421031", "421031074", "story_v_out_421031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play421031075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 421031075
		arg_303_1.duration_ = 10.97

		local var_303_0 = {
			zh = 9.166,
			ja = 10.966
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
				arg_303_0:Play421031076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1047ui_story = arg_303_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).z)
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles = arg_303_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_303_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).z)
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles = arg_303_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_306_1 = 0
			local var_306_2 = 1.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(421031075)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 40 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 40)

				if (40 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 40)) > 0 and var_306_2 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031075", "story_v_out_421031.awb") ~= 0 then
					local var_306_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031075", "story_v_out_421031.awb") / 1000

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_421031", "421031075", "story_v_out_421031.awb")

						arg_303_1:RecordAudio("421031075", var_306_8)
						arg_303_1:RecordAudio("421031075", var_306_8)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_421031", "421031075", "story_v_out_421031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_421031", "421031075", "story_v_out_421031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_9 and arg_303_1.time_ < var_306_1 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 421031076
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play421031077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1047ui_story"]) and arg_307_1.var_.characterEffect1047ui_story == nil then
				arg_307_1.var_.characterEffect1047ui_story = arg_307_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1047ui_story"]) then
				if arg_307_1.var_.characterEffect1047ui_story and not isNil(arg_307_1.actors_["1047ui_story"]) then
					arg_307_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1047ui_story"]) and arg_307_1.var_.characterEffect1047ui_story then
				arg_307_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.675

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(421031076).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 27 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 27)

				if (27 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 27)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play421031077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 421031077
		arg_311_1.duration_ = 5.17

		local var_311_0 = {
			zh = 4.566,
			ja = 5.166
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
				arg_311_0:Play421031078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos10102ui_story = arg_311_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).z)
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles = arg_311_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_311_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10102ui_story"].transform.position).z)
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10102ui_story"].transform.localEulerAngles = arg_311_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["10102ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10102ui_story == nil then
				arg_311_1.var_.characterEffect10102ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect10102ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10102ui_story then
				arg_311_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_4 = 0
			local var_314_5 = 0.475

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(421031077)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 19 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 19)

				if (19 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 19)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031077", "story_v_out_421031.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031077", "story_v_out_421031.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_out_421031", "421031077", "story_v_out_421031.awb")

						arg_311_1:RecordAudio("421031077", var_314_11)
						arg_311_1:RecordAudio("421031077", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_421031", "421031077", "story_v_out_421031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_421031", "421031077", "story_v_out_421031.awb")
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
				actorName = "10102ui_story",
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
	Play421031078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 421031078
		arg_315_1.duration_ = 11.27

		local var_315_0 = {
			zh = 8.433,
			ja = 11.266
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
				arg_315_0:Play421031079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1047ui_story = arg_315_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).z)
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles = arg_315_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_315_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1047ui_story"].transform.position).z)
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1047ui_story"].transform.localEulerAngles = arg_315_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1047ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1047ui_story == nil then
				arg_315_1.var_.characterEffect1047ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1047ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1047ui_story then
				arg_315_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_318_4 = arg_315_1.actors_["10102ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_4) and arg_315_1.var_.characterEffect10102ui_story == nil then
				arg_315_1.var_.characterEffect10102ui_story = var_318_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_5 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 and not isNil(var_318_4) then
				if arg_315_1.var_.characterEffect10102ui_story and not isNil(var_318_4) then
					arg_315_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_5)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 and not isNil(var_318_4) and arg_315_1.var_.characterEffect10102ui_story then
				arg_315_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_318_6 = 0
			local var_318_7 = 0.95

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(421031078)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 38 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 38)

				if (38 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 38)) > 0 and var_318_7 < var_318_11 then
					arg_315_1.talkMaxDuration = var_318_11

					if var_318_11 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031078", "story_v_out_421031.awb") ~= 0 then
					local var_318_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031078", "story_v_out_421031.awb") / 1000

					if var_318_12 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_6
					end

					if var_318_8.prefab_name ~= "" and arg_315_1.actors_[var_318_8.prefab_name] ~= nil then
						local var_318_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_8.prefab_name].transform, "story_v_out_421031", "421031078", "story_v_out_421031.awb")

						arg_315_1:RecordAudio("421031078", var_318_13)
						arg_315_1:RecordAudio("421031078", var_318_13)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_421031", "421031078", "story_v_out_421031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_421031", "421031078", "story_v_out_421031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play421031079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 421031079
		arg_319_1.duration_ = 11.93

		local var_319_0 = {
			zh = 9.433,
			ja = 11.933
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
				arg_319_0:Play421031080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.05

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:GetWordFromCfg(421031079)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 42 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 42)

				if (42 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 42)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031079", "story_v_out_421031.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031079", "story_v_out_421031.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_421031", "421031079", "story_v_out_421031.awb")

						arg_319_1:RecordAudio("421031079", var_322_6)
						arg_319_1:RecordAudio("421031079", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_421031", "421031079", "story_v_out_421031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_421031", "421031079", "story_v_out_421031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play421031080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 421031080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play421031081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) and arg_323_1.var_.characterEffect1047ui_story == nil then
				arg_323_1.var_.characterEffect1047ui_story = arg_323_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) then
				if arg_323_1.var_.characterEffect1047ui_story and not isNil(arg_323_1.actors_["1047ui_story"]) then
					arg_323_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1047ui_story"]) and arg_323_1.var_.characterEffect1047ui_story then
				arg_323_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.65

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(421031080).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 26 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 26)

				if (26 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 26)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play421031081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 421031081
		arg_327_1.duration_ = 9.83

		local var_327_0 = {
			zh = 9.833,
			ja = 9
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
				arg_327_0:Play421031082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10102ui_story = arg_327_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).z)
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles = arg_327_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_327_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["10102ui_story"].transform.position).z)
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["10102ui_story"].transform.localEulerAngles = arg_327_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["10102ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect10102ui_story == nil then
				arg_327_1.var_.characterEffect10102ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect10102ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect10102ui_story then
				arg_327_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_330_4 = 0
			local var_330_5 = 1.1

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(421031081)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 44 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 44)

				if (44 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 44)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031081", "story_v_out_421031.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031081", "story_v_out_421031.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_421031", "421031081", "story_v_out_421031.awb")

						arg_327_1:RecordAudio("421031081", var_330_11)
						arg_327_1:RecordAudio("421031081", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_421031", "421031081", "story_v_out_421031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_421031", "421031081", "story_v_out_421031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 421031082
		arg_331_1.duration_ = 11.57

		local var_331_0 = {
			zh = 9.566,
			ja = 11.566
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play421031083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1047ui_story = arg_331_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).z)
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles = arg_331_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_331_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1047ui_story"].transform.position).z)
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1047ui_story"].transform.localEulerAngles = arg_331_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1047ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1047ui_story == nil then
				arg_331_1.var_.characterEffect1047ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1047ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1047ui_story then
				arg_331_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["10102ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10102ui_story == nil then
				arg_331_1.var_.characterEffect10102ui_story = var_334_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_5 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 and not isNil(var_334_4) then
				if arg_331_1.var_.characterEffect10102ui_story and not isNil(var_334_4) then
					arg_331_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_5)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10102ui_story then
				arg_331_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_334_6 = 0
			local var_334_7 = 1.1

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(421031082)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 44 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 44)

				if (44 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 44)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031082", "story_v_out_421031.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031082", "story_v_out_421031.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_out_421031", "421031082", "story_v_out_421031.awb")

						arg_331_1:RecordAudio("421031082", var_334_13)
						arg_331_1:RecordAudio("421031082", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_421031", "421031082", "story_v_out_421031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_421031", "421031082", "story_v_out_421031.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play421031083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 421031083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play421031084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1047ui_story"]) and arg_335_1.var_.characterEffect1047ui_story == nil then
				arg_335_1.var_.characterEffect1047ui_story = arg_335_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1047ui_story"]) then
				if arg_335_1.var_.characterEffect1047ui_story and not isNil(arg_335_1.actors_["1047ui_story"]) then
					arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1047ui_story"]) and arg_335_1.var_.characterEffect1047ui_story then
				arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.3

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(421031083).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 12 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 12)

				if (12 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 12)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play421031084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 421031084
		arg_339_1.duration_ = 16.17

		local var_339_0 = {
			zh = 11.7,
			ja = 16.166
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play421031085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1047ui_story = arg_339_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).z)
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles = arg_339_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_339_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1047ui_story"].transform.position).z)
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1047ui_story"].transform.localEulerAngles = arg_339_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1047ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1047ui_story == nil then
				arg_339_1.var_.characterEffect1047ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1047ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1047ui_story then
				arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_342_4 = 0
			local var_342_5 = 1.35

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(421031084)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 54 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 54)

				if (54 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 54)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031084", "story_v_out_421031.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031084", "story_v_out_421031.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_421031", "421031084", "story_v_out_421031.awb")

						arg_339_1:RecordAudio("421031084", var_342_11)
						arg_339_1:RecordAudio("421031084", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_421031", "421031084", "story_v_out_421031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_421031", "421031084", "story_v_out_421031.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play421031085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 421031085
		arg_343_1.duration_ = 17.97

		local var_343_0 = {
			zh = 14.633,
			ja = 17.966
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play421031086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1047ui_story = arg_343_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).z)
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles = arg_343_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_343_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1047ui_story"].transform.position).z)
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1047ui_story"].transform.localEulerAngles = arg_343_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_346_1 = 0
			local var_346_2 = 1.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(421031085)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 59 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 59)

				if (59 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 59)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031085", "story_v_out_421031.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031085", "story_v_out_421031.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_421031", "421031085", "story_v_out_421031.awb")

						arg_343_1:RecordAudio("421031085", var_346_8)
						arg_343_1:RecordAudio("421031085", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_421031", "421031085", "story_v_out_421031.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_421031", "421031085", "story_v_out_421031.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play421031086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 421031086
		arg_347_1.duration_ = 2

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play421031087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10102ui_story = arg_347_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).z)
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles = arg_347_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_347_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["10102ui_story"].transform.position).z)
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["10102ui_story"].transform.localEulerAngles = arg_347_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["10102ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect10102ui_story == nil then
				arg_347_1.var_.characterEffect10102ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect10102ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect10102ui_story then
				arg_347_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_350_4 = arg_347_1.actors_["1047ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_4) and arg_347_1.var_.characterEffect1047ui_story == nil then
				arg_347_1.var_.characterEffect1047ui_story = var_350_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_5 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_5 and not isNil(var_350_4) then
				if arg_347_1.var_.characterEffect1047ui_story and not isNil(var_350_4) then
					arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_5)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_5 and arg_347_1.time_ < 0 + var_350_5 + arg_350_0 and not isNil(var_350_4) and arg_347_1.var_.characterEffect1047ui_story then
				arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_350_6 = 0
			local var_350_7 = 0.1

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_8 = arg_347_1:GetWordFromCfg(421031086)
				local var_350_9 = arg_347_1:FormatText(var_350_8.content)

				arg_347_1.text_.text = var_350_9

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 4 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 4)

				if (4 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 4)) > 0 and var_350_7 < var_350_11 then
					arg_347_1.talkMaxDuration = var_350_11

					if var_350_11 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_9
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031086", "story_v_out_421031.awb") ~= 0 then
					local var_350_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031086", "story_v_out_421031.awb") / 1000

					if var_350_12 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_6
					end

					if var_350_8.prefab_name ~= "" and arg_347_1.actors_[var_350_8.prefab_name] ~= nil then
						local var_350_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_8.prefab_name].transform, "story_v_out_421031", "421031086", "story_v_out_421031.awb")

						arg_347_1:RecordAudio("421031086", var_350_13)
						arg_347_1:RecordAudio("421031086", var_350_13)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_421031", "421031086", "story_v_out_421031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_421031", "421031086", "story_v_out_421031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play421031087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 421031087
		arg_351_1.duration_ = 7.13

		local var_351_0 = {
			zh = 5.1,
			ja = 7.133
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play421031088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1047ui_story = arg_351_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).z)
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles = arg_351_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_351_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1047ui_story"].transform.position).z)
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1047ui_story"].transform.localEulerAngles = arg_351_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1047ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1047ui_story == nil then
				arg_351_1.var_.characterEffect1047ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1047ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1047ui_story then
				arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_354_4 = arg_351_1.actors_["10102ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect10102ui_story == nil then
				arg_351_1.var_.characterEffect10102ui_story = var_354_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_5 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_5 and not isNil(var_354_4) then
				if arg_351_1.var_.characterEffect10102ui_story and not isNil(var_354_4) then
					arg_351_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_5)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_5 and arg_351_1.time_ < 0 + var_354_5 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect10102ui_story then
				arg_351_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_354_6 = 0
			local var_354_7 = 0.625

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_8 = arg_351_1:GetWordFromCfg(421031087)
				local var_354_9 = arg_351_1:FormatText(var_354_8.content)

				arg_351_1.text_.text = var_354_9

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 25 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 25)

				if (25 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 25)) > 0 and var_354_7 < var_354_11 then
					arg_351_1.talkMaxDuration = var_354_11

					if var_354_11 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_9
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031087", "story_v_out_421031.awb") ~= 0 then
					local var_354_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031087", "story_v_out_421031.awb") / 1000

					if var_354_12 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_6
					end

					if var_354_8.prefab_name ~= "" and arg_351_1.actors_[var_354_8.prefab_name] ~= nil then
						local var_354_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_8.prefab_name].transform, "story_v_out_421031", "421031087", "story_v_out_421031.awb")

						arg_351_1:RecordAudio("421031087", var_354_13)
						arg_351_1:RecordAudio("421031087", var_354_13)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_421031", "421031087", "story_v_out_421031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_421031", "421031087", "story_v_out_421031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play421031088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 421031088
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play421031089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1047ui_story"]) and arg_355_1.var_.characterEffect1047ui_story == nil then
				arg_355_1.var_.characterEffect1047ui_story = arg_355_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1047ui_story"]) then
				if arg_355_1.var_.characterEffect1047ui_story and not isNil(arg_355_1.actors_["1047ui_story"]) then
					arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1047ui_story"]) and arg_355_1.var_.characterEffect1047ui_story then
				arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.225

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(421031088).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 9 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 9)

				if (9 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 9)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play421031089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 421031089
		arg_359_1.duration_ = 22.4

		local var_359_0 = {
			zh = 16.933,
			ja = 22.4
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play421031090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1047ui_story = arg_359_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).z)
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles = arg_359_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_359_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1047ui_story"].transform.position).z)
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1047ui_story"].transform.localEulerAngles = arg_359_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1047ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1047ui_story == nil then
				arg_359_1.var_.characterEffect1047ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1047ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1047ui_story then
				arg_359_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_362_4 = 0
			local var_362_5 = 1.45

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(421031089)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 58 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 58)

				if (58 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 58)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031089", "story_v_out_421031.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031089", "story_v_out_421031.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_421031", "421031089", "story_v_out_421031.awb")

						arg_359_1:RecordAudio("421031089", var_362_11)
						arg_359_1:RecordAudio("421031089", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_421031", "421031089", "story_v_out_421031.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_421031", "421031089", "story_v_out_421031.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play421031090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 421031090
		arg_363_1.duration_ = 14.73

		local var_363_0 = {
			zh = 12.733,
			ja = 14.733
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play421031091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.275

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:GetWordFromCfg(421031090)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 51 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 51)

				if (51 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 51)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031090", "story_v_out_421031.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031090", "story_v_out_421031.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_421031", "421031090", "story_v_out_421031.awb")

						arg_363_1:RecordAudio("421031090", var_366_6)
						arg_363_1:RecordAudio("421031090", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_421031", "421031090", "story_v_out_421031.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_421031", "421031090", "story_v_out_421031.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play421031091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 421031091
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play421031092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) and arg_367_1.var_.characterEffect1047ui_story == nil then
				arg_367_1.var_.characterEffect1047ui_story = arg_367_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) then
				if arg_367_1.var_.characterEffect1047ui_story and not isNil(arg_367_1.actors_["1047ui_story"]) then
					arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1047ui_story"]) and arg_367_1.var_.characterEffect1047ui_story then
				arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(421031091).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 26 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 26)

				if (26 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 26)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play421031092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 421031092
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play421031093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(421031092).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 14 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 14)

				if (14 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 14)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play421031093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 421031093
		arg_375_1.duration_ = 15.97

		local var_375_0 = {
			zh = 11,
			ja = 15.966
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play421031094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1047ui_story = arg_375_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).z)
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles = arg_375_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_375_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1047ui_story"].transform.position).z)
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1047ui_story"].transform.localEulerAngles = arg_375_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1047ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1047ui_story == nil then
				arg_375_1.var_.characterEffect1047ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1047ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1047ui_story then
				arg_375_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_378_4 = 0
			local var_378_5 = 1.15

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(421031093)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 46 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 46)

				if (46 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 46)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031093", "story_v_out_421031.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031093", "story_v_out_421031.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_421031", "421031093", "story_v_out_421031.awb")

						arg_375_1:RecordAudio("421031093", var_378_11)
						arg_375_1:RecordAudio("421031093", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_421031", "421031093", "story_v_out_421031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_421031", "421031093", "story_v_out_421031.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play421031094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 421031094
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play421031095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1047ui_story = arg_379_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).z)
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles = arg_379_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_379_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1047ui_story"].transform.position).z)
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1047ui_story"].transform.localEulerAngles = arg_379_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["10102ui_story"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10102ui_story = var_382_1.localPosition
			end

			local var_382_2 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 then
				var_382_1.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_2)
				var_382_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_1.position).x, (manager.ui.mainCamera.transform.position - var_382_1.position).y, (manager.ui.mainCamera.transform.position - var_382_1.position).z)
				var_382_1.localEulerAngles.z = 0
				var_382_1.localEulerAngles.x = 0
				var_382_1.localEulerAngles = var_382_1.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 then
				var_382_1.localPosition = Vector3.New(0, 100, 0)
				var_382_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_1.position).x, (manager.ui.mainCamera.transform.position - var_382_1.position).y, (manager.ui.mainCamera.transform.position - var_382_1.position).z)
				var_382_1.localEulerAngles.z = 0
				var_382_1.localEulerAngles.x = 0
				var_382_1.localEulerAngles = var_382_1.localEulerAngles
			end

			if 0.034000001847744 < arg_379_1.time_ and arg_379_1.time_ <= 0.034000001847744 + arg_382_0 then
				arg_379_1:AudioAction("play", "effect", "se_story_143", "se_story_143_knock02", "")
			end

			local var_382_4 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_379_1.time_ and arg_379_1.time_ <= 0.034000001847744 + arg_382_0 then
				arg_379_1.var_.shakeOldPos = var_382_4.localPosition
			end

			local var_382_5 = 0.799333331485589

			if 0.034000001847744 <= arg_379_1.time_ and arg_379_1.time_ < 0.034000001847744 + var_382_5 then
				local var_382_6, var_382_7 = math.modf((arg_379_1.time_ - 0.034000001847744) / 0.066)

				var_382_4.localPosition = Vector3.New(var_382_7 * 0.13, var_382_7 * 0.13, var_382_7 * 0.13) + arg_379_1.var_.shakeOldPos
			end

			if arg_379_1.time_ >= 0.034000001847744 + var_382_5 and arg_379_1.time_ < 0.034000001847744 + var_382_5 + arg_382_0 then
				var_382_4.localPosition = arg_379_1.var_.shakeOldPos
			end

			local var_382_8 = 0
			local var_382_9 = 0.7

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(421031094).content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_12 = 28 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_10) / 28)

				if (28 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_10) / 28)) > 0 and var_382_9 < var_382_12 then
					arg_379_1.talkMaxDuration = var_382_12

					if var_382_12 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_13 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_13 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_13

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_13 and arg_379_1.time_ < var_382_8 + var_382_13 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play421031095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 421031095
		arg_383_1.duration_ = 2.83

		local var_383_0 = {
			zh = 2.833,
			ja = 2.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play421031096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.25

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:GetWordFromCfg(421031095)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 10 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 10)

				if (10 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 10)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031095", "story_v_out_421031.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031095", "story_v_out_421031.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_421031", "421031095", "story_v_out_421031.awb")

						arg_383_1:RecordAudio("421031095", var_386_6)
						arg_383_1:RecordAudio("421031095", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_421031", "421031095", "story_v_out_421031.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_421031", "421031095", "story_v_out_421031.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play421031096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 421031096
		arg_387_1.duration_ = 3.17

		local var_387_0 = {
			zh = 2.233,
			ja = 3.166
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play421031097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10102ui_story = arg_387_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).z)
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles = arg_387_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_387_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["10102ui_story"].transform.position).z)
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["10102ui_story"].transform.localEulerAngles = arg_387_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["10102ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect10102ui_story == nil then
				arg_387_1.var_.characterEffect10102ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect10102ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect10102ui_story then
				arg_387_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.034000001847744 < arg_387_1.time_ and arg_387_1.time_ <= 0.034000001847744 + arg_390_0 then
				arg_387_1:AudioAction("play", "effect", "se_story_143", "se_story_143_door02", "")
			end

			local var_390_5 = 0
			local var_390_6 = 0.275

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_5 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_7 = arg_387_1:GetWordFromCfg(421031096)
				local var_390_8 = arg_387_1:FormatText(var_390_7.content)

				arg_387_1.text_.text = var_390_8

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_10 = 11 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 11)

				if (11 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 11)) > 0 and var_390_6 < var_390_10 then
					arg_387_1.talkMaxDuration = var_390_10

					if var_390_10 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_5
					end
				end

				arg_387_1.text_.text = var_390_8
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031096", "story_v_out_421031.awb") ~= 0 then
					local var_390_11 = manager.audio:GetVoiceLength("story_v_out_421031", "421031096", "story_v_out_421031.awb") / 1000

					if var_390_11 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_11 + var_390_5
					end

					if var_390_7.prefab_name ~= "" and arg_387_1.actors_[var_390_7.prefab_name] ~= nil then
						local var_390_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_7.prefab_name].transform, "story_v_out_421031", "421031096", "story_v_out_421031.awb")

						arg_387_1:RecordAudio("421031096", var_390_12)
						arg_387_1:RecordAudio("421031096", var_390_12)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_421031", "421031096", "story_v_out_421031.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_421031", "421031096", "story_v_out_421031.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_13 = math.max(var_390_6, arg_387_1.talkMaxDuration)

			if var_390_5 <= arg_387_1.time_ and arg_387_1.time_ < var_390_5 + var_390_13 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_5) / var_390_13

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_5 + var_390_13 and arg_387_1.time_ < var_390_5 + var_390_13 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play421031097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 421031097
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play421031098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10102ui_story = arg_391_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).z)
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles = arg_391_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["10102ui_story"].transform.position).z)
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["10102ui_story"].transform.localEulerAngles = arg_391_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["10102ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect10102ui_story == nil then
				arg_391_1.var_.characterEffect10102ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect10102ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_391_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_2)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect10102ui_story then
				arg_391_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_391_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_394_3 = 0
			local var_394_4 = 1.65

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_5 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(421031097).content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 66 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 66)

				if (66 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_5) / 66)) > 0 and var_394_4 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_3
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_4, arg_391_1.talkMaxDuration)

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_3) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_3 + var_394_8 and arg_391_1.time_ < var_394_3 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play421031098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 421031098
		arg_395_1.duration_ = 11.53

		local var_395_0 = {
			zh = 9.2,
			ja = 11.533
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play421031099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.175

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:GetWordFromCfg(421031098)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 47 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 47)

				if (47 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 47)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031098", "story_v_out_421031.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031098", "story_v_out_421031.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_421031", "421031098", "story_v_out_421031.awb")

						arg_395_1:RecordAudio("421031098", var_398_6)
						arg_395_1:RecordAudio("421031098", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_421031", "421031098", "story_v_out_421031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_421031", "421031098", "story_v_out_421031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play421031099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 421031099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play421031100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.475

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(421031099).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 19 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 19)

				if (19 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 19)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play421031100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 421031100
		arg_403_1.duration_ = 15.7

		local var_403_0 = {
			zh = 10,
			ja = 15.7
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
				arg_403_0:Play421031101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 1.15

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_1 = arg_403_1:GetWordFromCfg(421031100)
				local var_406_2 = arg_403_1:FormatText(var_406_1.content)

				arg_403_1.text_.text = var_406_2

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 46 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 46)

				if (46 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 46)) > 0 and var_406_0 < var_406_4 then
					arg_403_1.talkMaxDuration = var_406_4

					if var_406_4 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_4 + 0
					end
				end

				arg_403_1.text_.text = var_406_2
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031100", "story_v_out_421031.awb") ~= 0 then
					local var_406_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031100", "story_v_out_421031.awb") / 1000

					if var_406_5 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + 0
					end

					if var_406_1.prefab_name ~= "" and arg_403_1.actors_[var_406_1.prefab_name] ~= nil then
						local var_406_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_1.prefab_name].transform, "story_v_out_421031", "421031100", "story_v_out_421031.awb")

						arg_403_1:RecordAudio("421031100", var_406_6)
						arg_403_1:RecordAudio("421031100", var_406_6)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_421031", "421031100", "story_v_out_421031.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_421031", "421031100", "story_v_out_421031.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play421031101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 421031101
		arg_407_1.duration_ = 7.8

		local var_407_0 = {
			zh = 4.7,
			ja = 7.8
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
				arg_407_0:Play421031102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1047ui_story = arg_407_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).z)
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles = arg_407_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_407_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1047ui_story"].transform.position).z)
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1047ui_story"].transform.localEulerAngles = arg_407_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1047ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1047ui_story == nil then
				arg_407_1.var_.characterEffect1047ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect1047ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1047ui_story then
				arg_407_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_410_4 = 0
			local var_410_5 = 0.55

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_6 = arg_407_1:GetWordFromCfg(421031101)
				local var_410_7 = arg_407_1:FormatText(var_410_6.content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_9 = 22 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 22)

				if (22 <= 0 and var_410_5 or var_410_5 * (utf8.len(var_410_7) / 22)) > 0 and var_410_5 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_4
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031101", "story_v_out_421031.awb") ~= 0 then
					local var_410_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031101", "story_v_out_421031.awb") / 1000

					if var_410_10 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_4
					end

					if var_410_6.prefab_name ~= "" and arg_407_1.actors_[var_410_6.prefab_name] ~= nil then
						local var_410_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_6.prefab_name].transform, "story_v_out_421031", "421031101", "story_v_out_421031.awb")

						arg_407_1:RecordAudio("421031101", var_410_11)
						arg_407_1:RecordAudio("421031101", var_410_11)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_421031", "421031101", "story_v_out_421031.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_421031", "421031101", "story_v_out_421031.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_12 = math.max(var_410_5, arg_407_1.talkMaxDuration)

			if var_410_4 <= arg_407_1.time_ and arg_407_1.time_ < var_410_4 + var_410_12 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_4) / var_410_12

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_4 + var_410_12 and arg_407_1.time_ < var_410_4 + var_410_12 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play421031102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 421031102
		arg_411_1.duration_ = 11.97

		local var_411_0 = {
			zh = 9.333,
			ja = 11.966
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play421031103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1047ui_story"]) and arg_411_1.var_.characterEffect1047ui_story == nil then
				arg_411_1.var_.characterEffect1047ui_story = arg_411_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1047ui_story"]) then
				if arg_411_1.var_.characterEffect1047ui_story and not isNil(arg_411_1.actors_["1047ui_story"]) then
					arg_411_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1047ui_story"]) and arg_411_1.var_.characterEffect1047ui_story then
				arg_411_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 1.025

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:GetWordFromCfg(421031102)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_6 = 41 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_4) / 41)

				if (41 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_4) / 41)) > 0 and var_414_2 < var_414_6 then
					arg_411_1.talkMaxDuration = var_414_6

					if var_414_6 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031102", "story_v_out_421031.awb") ~= 0 then
					local var_414_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031102", "story_v_out_421031.awb") / 1000

					if var_414_7 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_1
					end

					if var_414_3.prefab_name ~= "" and arg_411_1.actors_[var_414_3.prefab_name] ~= nil then
						local var_414_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_3.prefab_name].transform, "story_v_out_421031", "421031102", "story_v_out_421031.awb")

						arg_411_1:RecordAudio("421031102", var_414_8)
						arg_411_1:RecordAudio("421031102", var_414_8)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_421031", "421031102", "story_v_out_421031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_421031", "421031102", "story_v_out_421031.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_9 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_9 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_9

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_9 and arg_411_1.time_ < var_414_1 + var_414_9 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play421031103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 421031103
		arg_415_1.duration_ = 6

		local var_415_0 = {
			zh = 3.7,
			ja = 6
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play421031104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1047ui_story = arg_415_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).z)
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles = arg_415_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_415_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1047ui_story"].transform.position).z)
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1047ui_story"].transform.localEulerAngles = arg_415_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1047ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1047ui_story == nil then
				arg_415_1.var_.characterEffect1047ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1047ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1047ui_story then
				arg_415_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_418_4 = 0
			local var_418_5 = 0.35

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(421031103)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 14 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 14)

				if (14 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 14)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031103", "story_v_out_421031.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031103", "story_v_out_421031.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_out_421031", "421031103", "story_v_out_421031.awb")

						arg_415_1:RecordAudio("421031103", var_418_11)
						arg_415_1:RecordAudio("421031103", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_421031", "421031103", "story_v_out_421031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_421031", "421031103", "story_v_out_421031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play421031104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 421031104
		arg_419_1.duration_ = 9.57

		local var_419_0 = {
			zh = 6.033,
			ja = 9.566
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play421031105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.675

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:GetWordFromCfg(421031104)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)

				if (27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031104", "story_v_out_421031.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031104", "story_v_out_421031.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_421031", "421031104", "story_v_out_421031.awb")

						arg_419_1:RecordAudio("421031104", var_422_6)
						arg_419_1:RecordAudio("421031104", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_421031", "421031104", "story_v_out_421031.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_421031", "421031104", "story_v_out_421031.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play421031105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 421031105
		arg_423_1.duration_ = 5.73

		local var_423_0 = {
			zh = 3.533,
			ja = 5.733
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play421031106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1047ui_story = arg_423_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).z)
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles = arg_423_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_423_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1047ui_story"].transform.position).z)
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1047ui_story"].transform.localEulerAngles = arg_423_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1047ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1047ui_story == nil then
				arg_423_1.var_.characterEffect1047ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1047ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1047ui_story then
				arg_423_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_426_4 = 0
			local var_426_5 = 0.4

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(421031105)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)

				if (16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031105", "story_v_out_421031.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031105", "story_v_out_421031.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_out_421031", "421031105", "story_v_out_421031.awb")

						arg_423_1:RecordAudio("421031105", var_426_11)
						arg_423_1:RecordAudio("421031105", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_421031", "421031105", "story_v_out_421031.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_421031", "421031105", "story_v_out_421031.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 421031106
		arg_427_1.duration_ = 14.4

		local var_427_0 = {
			zh = 8.566,
			ja = 14.4
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
				arg_427_0:Play421031107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1047ui_story"]) and arg_427_1.var_.characterEffect1047ui_story == nil then
				arg_427_1.var_.characterEffect1047ui_story = arg_427_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1047ui_story"]) then
				if arg_427_1.var_.characterEffect1047ui_story and not isNil(arg_427_1.actors_["1047ui_story"]) then
					arg_427_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1047ui_story"]) and arg_427_1.var_.characterEffect1047ui_story then
				arg_427_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 1

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(421031106)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_6 = 40 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_4) / 40)

				if (40 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_4) / 40)) > 0 and var_430_2 < var_430_6 then
					arg_427_1.talkMaxDuration = var_430_6

					if var_430_6 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_6 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031106", "story_v_out_421031.awb") ~= 0 then
					local var_430_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031106", "story_v_out_421031.awb") / 1000

					if var_430_7 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_1
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_421031", "421031106", "story_v_out_421031.awb")

						arg_427_1:RecordAudio("421031106", var_430_8)
						arg_427_1:RecordAudio("421031106", var_430_8)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_421031", "421031106", "story_v_out_421031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_421031", "421031106", "story_v_out_421031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_9 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_9 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_9

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_9 and arg_427_1.time_ < var_430_1 + var_430_9 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play421031107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 421031107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play421031108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1047ui_story = arg_431_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).z)
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles = arg_431_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1047ui_story"].transform.position).z)
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1047ui_story"].transform.localEulerAngles = arg_431_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_434_1 = 0
			local var_434_2 = 0.5

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(421031107).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 20 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 20)

				if (20 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 20)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play421031108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 421031108
		arg_435_1.duration_ = 5.03

		local var_435_0 = {
			zh = 2.566,
			ja = 5.033
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play421031109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.25

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:GetWordFromCfg(421031108)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 10 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 10)

				if (10 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 10)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031108", "story_v_out_421031.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031108", "story_v_out_421031.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_out_421031", "421031108", "story_v_out_421031.awb")

						arg_435_1:RecordAudio("421031108", var_438_6)
						arg_435_1:RecordAudio("421031108", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_421031", "421031108", "story_v_out_421031.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_421031", "421031108", "story_v_out_421031.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play421031109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 421031109
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play421031110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 1.525

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(421031109).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 61 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 61)

				if (61 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 61)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play421031110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 421031110
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play421031111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.7

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(421031110).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 28 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 28)

				if (28 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 28)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play421031111 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 421031111
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play421031112(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 1.175

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(421031111).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 47 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 47)

				if (47 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 47)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play421031112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 421031112
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play421031113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.9

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(421031112).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 36 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 36)

				if (36 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 36)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play421031113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 421031113
		arg_455_1.duration_ = 4.97

		local var_455_0 = {
			zh = 2.566,
			ja = 4.966
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play421031114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.325

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_1 = arg_455_1:GetWordFromCfg(421031113)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 13 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 13)

				if (13 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 13)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031113", "story_v_out_421031.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031113", "story_v_out_421031.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_out_421031", "421031113", "story_v_out_421031.awb")

						arg_455_1:RecordAudio("421031113", var_458_6)
						arg_455_1:RecordAudio("421031113", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_421031", "421031113", "story_v_out_421031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_421031", "421031113", "story_v_out_421031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play421031114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 421031114
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play421031115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.525

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(421031114).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 21 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 21)

				if (21 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 21)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play421031115 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 421031115
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play421031116(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1.25

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(421031115).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 50 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 50)

				if (50 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 50)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play421031116 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 421031116
		arg_467_1.duration_ = 5.53

		local var_467_0 = {
			zh = 5.533,
			ja = 5.5
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play421031117(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.625

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:GetWordFromCfg(421031116)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 25 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 25)

				if (25 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 25)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031116", "story_v_out_421031.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031116", "story_v_out_421031.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_421031", "421031116", "story_v_out_421031.awb")

						arg_467_1:RecordAudio("421031116", var_470_6)
						arg_467_1:RecordAudio("421031116", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_421031", "421031116", "story_v_out_421031.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_421031", "421031116", "story_v_out_421031.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_7 and arg_467_1.time_ < 0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play421031117 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 421031117
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play421031118(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.15

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_1 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(421031117).content)

				arg_471_1.text_.text = var_474_1

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_3 = 6 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 6)

				if (6 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 6)) > 0 and var_474_0 < var_474_3 then
					arg_471_1.talkMaxDuration = var_474_3

					if var_474_3 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_3 + 0
					end
				end

				arg_471_1.text_.text = var_474_1
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_4 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_4 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_4

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_4 and arg_471_1.time_ < 0 + var_474_4 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play421031118 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 421031118
		arg_475_1.duration_ = 3.63

		local var_475_0 = {
			zh = 2.566,
			ja = 3.633
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play421031119(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.2

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_1 = arg_475_1:GetWordFromCfg(421031118)
				local var_478_2 = arg_475_1:FormatText(var_478_1.content)

				arg_475_1.text_.text = var_478_2

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 8 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 8)

				if (8 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 8)) > 0 and var_478_0 < var_478_4 then
					arg_475_1.talkMaxDuration = var_478_4

					if var_478_4 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_4 + 0
					end
				end

				arg_475_1.text_.text = var_478_2
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031118", "story_v_out_421031.awb") ~= 0 then
					local var_478_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031118", "story_v_out_421031.awb") / 1000

					if var_478_5 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + 0
					end

					if var_478_1.prefab_name ~= "" and arg_475_1.actors_[var_478_1.prefab_name] ~= nil then
						local var_478_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_1.prefab_name].transform, "story_v_out_421031", "421031118", "story_v_out_421031.awb")

						arg_475_1:RecordAudio("421031118", var_478_6)
						arg_475_1:RecordAudio("421031118", var_478_6)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_421031", "421031118", "story_v_out_421031.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_421031", "421031118", "story_v_out_421031.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play421031119 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 421031119
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play421031120(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0.1 < arg_479_1.time_ and arg_479_1.time_ <= 0.1 + arg_482_0 then
				arg_479_1:AudioAction("play", "effect", "se_story_143", "se_story_143_walk08", "")
			end

			local var_482_1 = 0
			local var_482_2 = 0.825

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_3 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(421031119).content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 33 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 33)

				if (33 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 33)) > 0 and var_482_2 < var_482_5 then
					arg_479_1.talkMaxDuration = var_482_5

					if var_482_5 + var_482_1 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + var_482_1
					end
				end

				arg_479_1.text_.text = var_482_3
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_6 = math.max(var_482_2, arg_479_1.talkMaxDuration)

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_6 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_1) / var_482_6

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_1 + var_482_6 and arg_479_1.time_ < var_482_1 + var_482_6 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play421031120 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 421031120
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play421031121(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.8

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(421031120).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 32 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 32)

				if (32 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 32)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play421031121 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 421031121
		arg_487_1.duration_ = 4.17

		local var_487_0 = {
			zh = 3.533,
			ja = 4.166
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
				arg_487_0:Play421031122(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1047ui_story = arg_487_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).z)
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles = arg_487_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_487_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1047ui_story"].transform.position).z)
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1047ui_story"].transform.localEulerAngles = arg_487_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_490_1 = arg_487_1.actors_["1047ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1047ui_story == nil then
				arg_487_1.var_.characterEffect1047ui_story = var_490_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 and not isNil(var_490_1) then
				if arg_487_1.var_.characterEffect1047ui_story and not isNil(var_490_1) then
					arg_487_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1047ui_story then
				arg_487_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_490_4 = 0
			local var_490_5 = 0.35

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_6 = arg_487_1:GetWordFromCfg(421031121)
				local var_490_7 = arg_487_1:FormatText(var_490_6.content)

				arg_487_1.text_.text = var_490_7

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_9 = 14 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 14)

				if (14 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_7) / 14)) > 0 and var_490_5 < var_490_9 then
					arg_487_1.talkMaxDuration = var_490_9

					if var_490_9 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_9 + var_490_4
					end
				end

				arg_487_1.text_.text = var_490_7
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031121", "story_v_out_421031.awb") ~= 0 then
					local var_490_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031121", "story_v_out_421031.awb") / 1000

					if var_490_10 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_4
					end

					if var_490_6.prefab_name ~= "" and arg_487_1.actors_[var_490_6.prefab_name] ~= nil then
						local var_490_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_6.prefab_name].transform, "story_v_out_421031", "421031121", "story_v_out_421031.awb")

						arg_487_1:RecordAudio("421031121", var_490_11)
						arg_487_1:RecordAudio("421031121", var_490_11)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_421031", "421031121", "story_v_out_421031.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_421031", "421031121", "story_v_out_421031.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_12 = math.max(var_490_5, arg_487_1.talkMaxDuration)

			if var_490_4 <= arg_487_1.time_ and arg_487_1.time_ < var_490_4 + var_490_12 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_4) / var_490_12

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_4 + var_490_12 and arg_487_1.time_ < var_490_4 + var_490_12 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031122 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 421031122
		arg_491_1.duration_ = 12.77

		local var_491_0 = {
			zh = 9.233,
			ja = 12.766
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
				arg_491_0:Play421031123(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10102ui_story = arg_491_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).z)
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles = arg_491_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_491_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10102ui_story"].transform.position).z)
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10102ui_story"].transform.localEulerAngles = arg_491_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1047ui_story"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1047ui_story = var_494_1.localPosition
			end

			local var_494_2 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 then
				var_494_1.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_491_1.time_ - 0) / var_494_2)
				var_494_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_1.position).x, (manager.ui.mainCamera.transform.position - var_494_1.position).y, (manager.ui.mainCamera.transform.position - var_494_1.position).z)
				var_494_1.localEulerAngles.z = 0
				var_494_1.localEulerAngles.x = 0
				var_494_1.localEulerAngles = var_494_1.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 then
				var_494_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_494_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_494_1.position).x, (manager.ui.mainCamera.transform.position - var_494_1.position).y, (manager.ui.mainCamera.transform.position - var_494_1.position).z)
				var_494_1.localEulerAngles.z = 0
				var_494_1.localEulerAngles.x = 0
				var_494_1.localEulerAngles = var_494_1.localEulerAngles
			end

			local var_494_3 = arg_491_1.actors_["10102ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_3) and arg_491_1.var_.characterEffect10102ui_story == nil then
				arg_491_1.var_.characterEffect10102ui_story = var_494_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_4 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 and not isNil(var_494_3) then
				if arg_491_1.var_.characterEffect10102ui_story and not isNil(var_494_3) then
					arg_491_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 and not isNil(var_494_3) and arg_491_1.var_.characterEffect10102ui_story then
				arg_491_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_494_6 = arg_491_1.actors_["1047ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_6) and arg_491_1.var_.characterEffect1047ui_story == nil then
				arg_491_1.var_.characterEffect1047ui_story = var_494_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_7 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 and not isNil(var_494_6) then
				if arg_491_1.var_.characterEffect1047ui_story and not isNil(var_494_6) then
					arg_491_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_491_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_491_1.time_ - 0) / var_494_7)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 and not isNil(var_494_6) and arg_491_1.var_.characterEffect1047ui_story then
				arg_491_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_491_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_494_8 = 0
			local var_494_9 = 1.25

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_10 = arg_491_1:GetWordFromCfg(421031122)
				local var_494_11 = arg_491_1:FormatText(var_494_10.content)

				arg_491_1.text_.text = var_494_11

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_13 = 50 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 50)

				if (50 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 50)) > 0 and var_494_9 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_8
					end
				end

				arg_491_1.text_.text = var_494_11
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031122", "story_v_out_421031.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031122", "story_v_out_421031.awb") / 1000

					if var_494_14 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_8
					end

					if var_494_10.prefab_name ~= "" and arg_491_1.actors_[var_494_10.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_10.prefab_name].transform, "story_v_out_421031", "421031122", "story_v_out_421031.awb")

						arg_491_1:RecordAudio("421031122", var_494_15)
						arg_491_1:RecordAudio("421031122", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_421031", "421031122", "story_v_out_421031.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_421031", "421031122", "story_v_out_421031.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031123 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 421031123
		arg_495_1.duration_ = 9.9

		local var_495_0 = {
			zh = 7.1,
			ja = 9.9
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
				arg_495_0:Play421031124(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1047ui_story = arg_495_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).z)
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles = arg_495_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_495_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1047ui_story"].transform.position).z)
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1047ui_story"].transform.localEulerAngles = arg_495_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1047ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1047ui_story == nil then
				arg_495_1.var_.characterEffect1047ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1047ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1047ui_story then
				arg_495_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_498_4 = arg_495_1.actors_["10102ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_4) and arg_495_1.var_.characterEffect10102ui_story == nil then
				arg_495_1.var_.characterEffect10102ui_story = var_498_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_5 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_5 and not isNil(var_498_4) then
				if arg_495_1.var_.characterEffect10102ui_story and not isNil(var_498_4) then
					arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_5)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_5 and arg_495_1.time_ < 0 + var_498_5 + arg_498_0 and not isNil(var_498_4) and arg_495_1.var_.characterEffect10102ui_story then
				arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_498_6 = 0
			local var_498_7 = 0.75

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_8 = arg_495_1:GetWordFromCfg(421031123)
				local var_498_9 = arg_495_1:FormatText(var_498_8.content)

				arg_495_1.text_.text = var_498_9

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 30 <= 0 and var_498_7 or var_498_7 * (utf8.len(var_498_9) / 30)

				if (30 <= 0 and var_498_7 or var_498_7 * (utf8.len(var_498_9) / 30)) > 0 and var_498_7 < var_498_11 then
					arg_495_1.talkMaxDuration = var_498_11

					if var_498_11 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_11 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_9
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031123", "story_v_out_421031.awb") ~= 0 then
					local var_498_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031123", "story_v_out_421031.awb") / 1000

					if var_498_12 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_12 + var_498_6
					end

					if var_498_8.prefab_name ~= "" and arg_495_1.actors_[var_498_8.prefab_name] ~= nil then
						local var_498_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_8.prefab_name].transform, "story_v_out_421031", "421031123", "story_v_out_421031.awb")

						arg_495_1:RecordAudio("421031123", var_498_13)
						arg_495_1:RecordAudio("421031123", var_498_13)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_421031", "421031123", "story_v_out_421031.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_421031", "421031123", "story_v_out_421031.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_14 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_14 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_6) / var_498_14

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_6 + var_498_14 and arg_495_1.time_ < var_498_6 + var_498_14 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play421031124 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 421031124
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play421031125(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1047ui_story = arg_499_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).z)
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles = arg_499_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_499_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1047ui_story"].transform.position).z)
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1047ui_story"].transform.localEulerAngles = arg_499_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["10102ui_story"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10102ui_story = var_502_1.localPosition
			end

			local var_502_2 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 then
				var_502_1.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 0) / var_502_2)
				var_502_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_1.position).x, (manager.ui.mainCamera.transform.position - var_502_1.position).y, (manager.ui.mainCamera.transform.position - var_502_1.position).z)
				var_502_1.localEulerAngles.z = 0
				var_502_1.localEulerAngles.x = 0
				var_502_1.localEulerAngles = var_502_1.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 then
				var_502_1.localPosition = Vector3.New(0, 100, 0)
				var_502_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_1.position).x, (manager.ui.mainCamera.transform.position - var_502_1.position).y, (manager.ui.mainCamera.transform.position - var_502_1.position).z)
				var_502_1.localEulerAngles.z = 0
				var_502_1.localEulerAngles.x = 0
				var_502_1.localEulerAngles = var_502_1.localEulerAngles
			end

			local var_502_3 = 0
			local var_502_4 = 0.775

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_3 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_5 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(421031124).content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 31 <= 0 and var_502_4 or var_502_4 * (utf8.len(var_502_5) / 31)

				if (31 <= 0 and var_502_4 or var_502_4 * (utf8.len(var_502_5) / 31)) > 0 and var_502_4 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_3 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_3
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_8 = math.max(var_502_4, arg_499_1.talkMaxDuration)

			if var_502_3 <= arg_499_1.time_ and arg_499_1.time_ < var_502_3 + var_502_8 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_3) / var_502_8

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_3 + var_502_8 and arg_499_1.time_ < var_502_3 + var_502_8 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421031125 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 421031125
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play421031126(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 1.65

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(421031125).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 66 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 66)

				if (66 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 66)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play421031126 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 421031126
		arg_507_1.duration_ = 6.8

		local var_507_0 = {
			zh = 5,
			ja = 6.8
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
				arg_507_0:Play421031127(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1047ui_story = arg_507_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).z)
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles = arg_507_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_507_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1047ui_story"].transform.position).z)
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1047ui_story"].transform.localEulerAngles = arg_507_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["1047ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1047ui_story == nil then
				arg_507_1.var_.characterEffect1047ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect1047ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect1047ui_story then
				arg_507_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_510_4 = 0
			local var_510_5 = 0.425

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_6 = arg_507_1:GetWordFromCfg(421031126)
				local var_510_7 = arg_507_1:FormatText(var_510_6.content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_9 = 17 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 17)

				if (17 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 17)) > 0 and var_510_5 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9

					if var_510_9 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031126", "story_v_out_421031.awb") ~= 0 then
					local var_510_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031126", "story_v_out_421031.awb") / 1000

					if var_510_10 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_4
					end

					if var_510_6.prefab_name ~= "" and arg_507_1.actors_[var_510_6.prefab_name] ~= nil then
						local var_510_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_6.prefab_name].transform, "story_v_out_421031", "421031126", "story_v_out_421031.awb")

						arg_507_1:RecordAudio("421031126", var_510_11)
						arg_507_1:RecordAudio("421031126", var_510_11)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_421031", "421031126", "story_v_out_421031.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_421031", "421031126", "story_v_out_421031.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_12 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 <= arg_507_1.time_ and arg_507_1.time_ < var_510_4 + var_510_12 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_4) / var_510_12

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_4 + var_510_12 and arg_507_1.time_ < var_510_4 + var_510_12 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031127 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 421031127
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play421031128(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1047ui_story"]) and arg_511_1.var_.characterEffect1047ui_story == nil then
				arg_511_1.var_.characterEffect1047ui_story = arg_511_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1047ui_story"]) then
				if arg_511_1.var_.characterEffect1047ui_story and not isNil(arg_511_1.actors_["1047ui_story"]) then
					arg_511_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_0)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1047ui_story"]) and arg_511_1.var_.characterEffect1047ui_story then
				arg_511_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_514_1 = 0
			local var_514_2 = 0.325

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(421031127).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 13 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 13)

				if (13 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 13)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play421031128 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 421031128
		arg_515_1.duration_ = 7.03

		local var_515_0 = {
			zh = 5.5,
			ja = 7.033
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
				arg_515_0:Play421031129(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10102ui_story = arg_515_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).z)
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles = arg_515_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_515_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["10102ui_story"].transform.position).z)
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["10102ui_story"].transform.localEulerAngles = arg_515_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1047ui_story"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1047ui_story = var_518_1.localPosition
			end

			local var_518_2 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 then
				var_518_1.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_515_1.time_ - 0) / var_518_2)
				var_518_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_1.position).x, (manager.ui.mainCamera.transform.position - var_518_1.position).y, (manager.ui.mainCamera.transform.position - var_518_1.position).z)
				var_518_1.localEulerAngles.z = 0
				var_518_1.localEulerAngles.x = 0
				var_518_1.localEulerAngles = var_518_1.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 then
				var_518_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_518_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_1.position).x, (manager.ui.mainCamera.transform.position - var_518_1.position).y, (manager.ui.mainCamera.transform.position - var_518_1.position).z)
				var_518_1.localEulerAngles.z = 0
				var_518_1.localEulerAngles.x = 0
				var_518_1.localEulerAngles = var_518_1.localEulerAngles
			end

			local var_518_3 = arg_515_1.actors_["10102ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_3) and arg_515_1.var_.characterEffect10102ui_story == nil then
				arg_515_1.var_.characterEffect10102ui_story = var_518_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_4 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 and not isNil(var_518_3) then
				if arg_515_1.var_.characterEffect10102ui_story and not isNil(var_518_3) then
					arg_515_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 and not isNil(var_518_3) and arg_515_1.var_.characterEffect10102ui_story then
				arg_515_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_518_6 = 0
			local var_518_7 = 0.725

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_8 = arg_515_1:GetWordFromCfg(421031128)
				local var_518_9 = arg_515_1:FormatText(var_518_8.content)

				arg_515_1.text_.text = var_518_9

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 30 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 30)

				if (30 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 30)) > 0 and var_518_7 < var_518_11 then
					arg_515_1.talkMaxDuration = var_518_11

					if var_518_11 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_9
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031128", "story_v_out_421031.awb") ~= 0 then
					local var_518_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031128", "story_v_out_421031.awb") / 1000

					if var_518_12 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_6
					end

					if var_518_8.prefab_name ~= "" and arg_515_1.actors_[var_518_8.prefab_name] ~= nil then
						local var_518_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_8.prefab_name].transform, "story_v_out_421031", "421031128", "story_v_out_421031.awb")

						arg_515_1:RecordAudio("421031128", var_518_13)
						arg_515_1:RecordAudio("421031128", var_518_13)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_421031", "421031128", "story_v_out_421031.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_421031", "421031128", "story_v_out_421031.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play421031129 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 421031129
		arg_519_1.duration_ = 12

		local var_519_0 = {
			zh = 5.5,
			ja = 12
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
				arg_519_0:Play421031130(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1047ui_story = arg_519_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).z)
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles = arg_519_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_519_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1047ui_story"].transform.position).z)
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1047ui_story"].transform.localEulerAngles = arg_519_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1047ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1047ui_story == nil then
				arg_519_1.var_.characterEffect1047ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1047ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1047ui_story then
				arg_519_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_522_4 = arg_519_1.actors_["10102ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect10102ui_story == nil then
				arg_519_1.var_.characterEffect10102ui_story = var_522_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_5 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_5 and not isNil(var_522_4) then
				if arg_519_1.var_.characterEffect10102ui_story and not isNil(var_522_4) then
					arg_519_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_519_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_5)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_5 and arg_519_1.time_ < 0 + var_522_5 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect10102ui_story then
				arg_519_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_519_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_522_6 = 0
			local var_522_7 = 0.65

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_8 = arg_519_1:GetWordFromCfg(421031129)
				local var_522_9 = arg_519_1:FormatText(var_522_8.content)

				arg_519_1.text_.text = var_522_9

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 26 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 26)

				if (26 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 26)) > 0 and var_522_7 < var_522_11 then
					arg_519_1.talkMaxDuration = var_522_11

					if var_522_11 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_11 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_9
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031129", "story_v_out_421031.awb") ~= 0 then
					local var_522_12 = manager.audio:GetVoiceLength("story_v_out_421031", "421031129", "story_v_out_421031.awb") / 1000

					if var_522_12 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_6
					end

					if var_522_8.prefab_name ~= "" and arg_519_1.actors_[var_522_8.prefab_name] ~= nil then
						local var_522_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_8.prefab_name].transform, "story_v_out_421031", "421031129", "story_v_out_421031.awb")

						arg_519_1:RecordAudio("421031129", var_522_13)
						arg_519_1:RecordAudio("421031129", var_522_13)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_421031", "421031129", "story_v_out_421031.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_421031", "421031129", "story_v_out_421031.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_14 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_14 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_14

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_14 and arg_519_1.time_ < var_522_6 + var_522_14 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421031130 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 421031130
		arg_523_1.duration_ = 9

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play421031131(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if arg_523_1.bgs_.I11i == nil then
				local var_526_0 = Object.Instantiate(arg_523_1.paintGo_)

				var_526_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_526_0.name = "I11i"
				var_526_0.transform.parent = arg_523_1.stage_.transform
				var_526_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_523_1.bgs_.I11i = var_526_0
			end

			if 2 < arg_523_1.time_ and arg_523_1.time_ <= 2 + arg_526_0 then
				local var_526_1 = arg_523_1.bgs_.I11i

				arg_523_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_526_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_526_2 = var_526_1:GetComponent("SpriteRenderer")

				if var_526_2 and var_526_2.sprite then
					local var_526_3 = 2 * (var_526_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_526_1.transform.localScale = Vector3.New(var_526_3 / var_526_2.sprite.bounds.size.y < var_526_3 * manager.ui.mainCameraCom_.aspect / var_526_2.sprite.bounds.size.x and var_526_3 * manager.ui.mainCameraCom_.aspect / var_526_2.sprite.bounds.size.x or var_526_3 / var_526_2.sprite.bounds.size.y, var_526_3 / var_526_2.sprite.bounds.size.y < var_526_3 * manager.ui.mainCameraCom_.aspect / var_526_2.sprite.bounds.size.x and var_526_3 * manager.ui.mainCameraCom_.aspect / var_526_2.sprite.bounds.size.x or var_526_3 / var_526_2.sprite.bounds.size.y, 0)
				end

				for iter_526_0, iter_526_1 in pairs(arg_523_1.bgs_) do
					if iter_526_0 ~= "I11i" then
						iter_526_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_526_4 = 4

			if 4 < arg_523_1.time_ and arg_523_1.time_ <= var_526_4 + arg_526_0 then
				arg_523_1.allBtn_.enabled = false
			end

			if arg_523_1.time_ >= var_526_4 + 0.3 and arg_523_1.time_ < var_526_4 + 0.3 + arg_526_0 then
				arg_523_1.allBtn_.enabled = true
			end

			local var_526_5 = 0

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_5 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_6 = 2

			if var_526_5 <= arg_523_1.time_ and arg_523_1.time_ < var_526_5 + var_526_6 then
				local var_526_7 = Color.New(0, 0, 0)

				var_526_7.a = Mathf.Lerp(0, 1, (arg_523_1.time_ - var_526_5) / var_526_6)
				arg_523_1.mask_.color = var_526_7
			end

			if arg_523_1.time_ >= var_526_5 + var_526_6 and arg_523_1.time_ < var_526_5 + var_526_6 + arg_526_0 then
				local var_526_8 = Color.New(0, 0, 0)

				var_526_8.a = 1
				arg_523_1.mask_.color = var_526_8
			end

			local var_526_9 = 2

			if 2 < arg_523_1.time_ and arg_523_1.time_ <= var_526_9 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_10 = 2

			if var_526_9 <= arg_523_1.time_ and arg_523_1.time_ < var_526_9 + var_526_10 then
				local var_526_11 = Color.New(0, 0, 0)

				var_526_11.a = Mathf.Lerp(1, 0, (arg_523_1.time_ - var_526_9) / var_526_10)
				arg_523_1.mask_.color = var_526_11
			end

			if arg_523_1.time_ >= var_526_9 + var_526_10 and arg_523_1.time_ < var_526_9 + var_526_10 + arg_526_0 then
				local var_526_12 = Color.New(0, 0, 0)

				arg_523_1.mask_.enabled = false
				var_526_12.a = 0
				arg_523_1.mask_.color = var_526_12
			end

			local var_526_13 = arg_523_1.actors_["1047ui_story"].transform

			if 2 < arg_523_1.time_ and arg_523_1.time_ <= 2 + arg_526_0 then
				arg_523_1.var_.moveOldPos1047ui_story = var_526_13.localPosition
			end

			local var_526_14 = 0.001

			if 2 <= arg_523_1.time_ and arg_523_1.time_ < 2 + var_526_14 then
				var_526_13.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 2) / var_526_14)
				var_526_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_13.position).x, (manager.ui.mainCamera.transform.position - var_526_13.position).y, (manager.ui.mainCamera.transform.position - var_526_13.position).z)
				var_526_13.localEulerAngles.z = 0
				var_526_13.localEulerAngles.x = 0
				var_526_13.localEulerAngles = var_526_13.localEulerAngles
			end

			if arg_523_1.time_ >= 2 + var_526_14 and arg_523_1.time_ < 2 + var_526_14 + arg_526_0 then
				var_526_13.localPosition = Vector3.New(0, 100, 0)
				var_526_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_13.position).x, (manager.ui.mainCamera.transform.position - var_526_13.position).y, (manager.ui.mainCamera.transform.position - var_526_13.position).z)
				var_526_13.localEulerAngles.z = 0
				var_526_13.localEulerAngles.x = 0
				var_526_13.localEulerAngles = var_526_13.localEulerAngles
			end

			local var_526_15 = arg_523_1.actors_["10102ui_story"].transform

			if 2 < arg_523_1.time_ and arg_523_1.time_ <= 2 + arg_526_0 then
				arg_523_1.var_.moveOldPos10102ui_story = var_526_15.localPosition
			end

			local var_526_16 = 0.001

			if 2 <= arg_523_1.time_ and arg_523_1.time_ < 2 + var_526_16 then
				var_526_15.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 2) / var_526_16)
				var_526_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_15.position).x, (manager.ui.mainCamera.transform.position - var_526_15.position).y, (manager.ui.mainCamera.transform.position - var_526_15.position).z)
				var_526_15.localEulerAngles.z = 0
				var_526_15.localEulerAngles.x = 0
				var_526_15.localEulerAngles = var_526_15.localEulerAngles
			end

			if arg_523_1.time_ >= 2 + var_526_16 and arg_523_1.time_ < 2 + var_526_16 + arg_526_0 then
				var_526_15.localPosition = Vector3.New(0, 100, 0)
				var_526_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_15.position).x, (manager.ui.mainCamera.transform.position - var_526_15.position).y, (manager.ui.mainCamera.transform.position - var_526_15.position).z)
				var_526_15.localEulerAngles.z = 0
				var_526_15.localEulerAngles.x = 0
				var_526_15.localEulerAngles = var_526_15.localEulerAngles
			end

			if 0.1 < arg_523_1.time_ and arg_523_1.time_ <= 0.1 + arg_526_0 then
				arg_523_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1.6 < arg_523_1.time_ and arg_523_1.time_ <= 1.6 + arg_526_0 then
				arg_523_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_523_1.frameCnt_ <= 1 then
				arg_523_1.dialog_:SetActive(false)
			end

			local var_526_19 = 4
			local var_526_20 = 1.05

			if 4 < arg_523_1.time_ and arg_523_1.time_ <= var_526_19 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0

				arg_523_1.dialog_:SetActive(true)

				arg_523_1.dialogCg_.alpha = 0

				local var_526_21 = LeanTween.value(arg_523_1.dialog_, 0, 1, 0.3)

				var_526_21:setOnUpdate(LuaHelper.FloatAction(function(arg_527_0)
					arg_523_1.dialogCg_.alpha = arg_527_0
				end))
				var_526_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_523_1.dialog_)
					var_526_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_523_1.duration_ = arg_523_1.duration_ + 0.3

				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_22 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(421031130).content)

				arg_523_1.text_.text = var_526_22

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_24 = 43 <= 0 and var_526_20 or var_526_20 * (utf8.len(var_526_22) / 43)

				if (43 <= 0 and var_526_20 or var_526_20 * (utf8.len(var_526_22) / 43)) > 0 and var_526_20 < var_526_24 then
					arg_523_1.talkMaxDuration = var_526_24
					var_526_19 = var_526_19 + 0.3

					if var_526_24 + var_526_19 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_24 + var_526_19
					end
				end

				arg_523_1.text_.text = var_526_22
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_25 = var_526_19 + 0.3
			local var_526_26 = math.max(var_526_20, arg_523_1.talkMaxDuration)

			if var_526_19 + 0.3 <= arg_523_1.time_ and arg_523_1.time_ < var_526_25 + var_526_26 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_25) / var_526_26

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_25 + var_526_26 and arg_523_1.time_ < var_526_25 + var_526_26 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play421031131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 421031131
		arg_529_1.duration_ = 3.5

		local var_529_0 = {
			zh = 2.033,
			ja = 3.5
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play421031132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos10102ui_story = arg_529_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_532_0 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 then
				arg_529_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_529_1.time_ - 0) / var_532_0)
				arg_529_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).z)
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles = arg_529_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 then
				arg_529_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_529_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10102ui_story"].transform.position).z)
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["10102ui_story"].transform.localEulerAngles = arg_529_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_532_1 = arg_529_1.actors_["10102ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect10102ui_story == nil then
				arg_529_1.var_.characterEffect10102ui_story = var_532_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_2 and not isNil(var_532_1) then
				if arg_529_1.var_.characterEffect10102ui_story and not isNil(var_532_1) then
					arg_529_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_2 and arg_529_1.time_ < 0 + var_532_2 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect10102ui_story then
				arg_529_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_532_4 = 0
			local var_532_5 = 0.225

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_6 = arg_529_1:GetWordFromCfg(421031131)
				local var_532_7 = arg_529_1:FormatText(var_532_6.content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 9 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 9)

				if (9 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 9)) > 0 and var_532_5 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_4
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031131", "story_v_out_421031.awb") ~= 0 then
					local var_532_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031131", "story_v_out_421031.awb") / 1000

					if var_532_10 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_10 + var_532_4
					end

					if var_532_6.prefab_name ~= "" and arg_529_1.actors_[var_532_6.prefab_name] ~= nil then
						local var_532_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_6.prefab_name].transform, "story_v_out_421031", "421031131", "story_v_out_421031.awb")

						arg_529_1:RecordAudio("421031131", var_532_11)
						arg_529_1:RecordAudio("421031131", var_532_11)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_421031", "421031131", "story_v_out_421031.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_421031", "421031131", "story_v_out_421031.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_12 = math.max(var_532_5, arg_529_1.talkMaxDuration)

			if var_532_4 <= arg_529_1.time_ and arg_529_1.time_ < var_532_4 + var_532_12 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_4) / var_532_12

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_4 + var_532_12 and arg_529_1.time_ < var_532_4 + var_532_12 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play421031132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 421031132
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play421031133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["10102ui_story"]) and arg_533_1.var_.characterEffect10102ui_story == nil then
				arg_533_1.var_.characterEffect10102ui_story = arg_533_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["10102ui_story"]) then
				if arg_533_1.var_.characterEffect10102ui_story and not isNil(arg_533_1.actors_["10102ui_story"]) then
					arg_533_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_533_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_0)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["10102ui_story"]) and arg_533_1.var_.characterEffect10102ui_story then
				arg_533_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_533_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_536_1 = 0
			local var_536_2 = 0.45

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(421031132).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 18 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 18)

				if (18 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 18)) > 0 and var_536_2 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_6 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_6 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_6

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_6 and arg_533_1.time_ < var_536_1 + var_536_6 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play421031133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 421031133
		arg_537_1.duration_ = 7.23

		local var_537_0 = {
			zh = 4.833,
			ja = 7.233
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play421031134(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos10102ui_story = arg_537_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).z)
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles = arg_537_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_537_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10102ui_story"].transform.position).z)
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["10102ui_story"].transform.localEulerAngles = arg_537_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.actors_["10102ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect10102ui_story == nil then
				arg_537_1.var_.characterEffect10102ui_story = var_540_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 and not isNil(var_540_1) then
				if arg_537_1.var_.characterEffect10102ui_story and not isNil(var_540_1) then
					arg_537_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect10102ui_story then
				arg_537_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_4 = 0
			local var_540_5 = 0.575

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_6 = arg_537_1:GetWordFromCfg(421031133)
				local var_540_7 = arg_537_1:FormatText(var_540_6.content)

				arg_537_1.text_.text = var_540_7

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_9 = 23 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 23)

				if (23 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 23)) > 0 and var_540_5 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_4
					end
				end

				arg_537_1.text_.text = var_540_7
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031133", "story_v_out_421031.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031133", "story_v_out_421031.awb") / 1000

					if var_540_10 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_4
					end

					if var_540_6.prefab_name ~= "" and arg_537_1.actors_[var_540_6.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_6.prefab_name].transform, "story_v_out_421031", "421031133", "story_v_out_421031.awb")

						arg_537_1:RecordAudio("421031133", var_540_11)
						arg_537_1:RecordAudio("421031133", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_421031", "421031133", "story_v_out_421031.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_421031", "421031133", "story_v_out_421031.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_5, arg_537_1.talkMaxDuration)

			if var_540_4 <= arg_537_1.time_ and arg_537_1.time_ < var_540_4 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_4) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_4 + var_540_12 and arg_537_1.time_ < var_540_4 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play421031134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 421031134
		arg_541_1.duration_ = 6.63

		local var_541_0 = {
			zh = 5.233,
			ja = 6.633
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play421031135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1047ui_story = arg_541_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).z)
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles = arg_541_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_541_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).z)
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles = arg_541_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_544_1 = arg_541_1.actors_["10102ui_story"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10102ui_story = var_544_1.localPosition
			end

			local var_544_2 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_2 then
				var_544_1.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_541_1.time_ - 0) / var_544_2)
				var_544_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_544_1.position).x, (manager.ui.mainCamera.transform.position - var_544_1.position).y, (manager.ui.mainCamera.transform.position - var_544_1.position).z)
				var_544_1.localEulerAngles.z = 0
				var_544_1.localEulerAngles.x = 0
				var_544_1.localEulerAngles = var_544_1.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_2 and arg_541_1.time_ < 0 + var_544_2 + arg_544_0 then
				var_544_1.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_544_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_544_1.position).x, (manager.ui.mainCamera.transform.position - var_544_1.position).y, (manager.ui.mainCamera.transform.position - var_544_1.position).z)
				var_544_1.localEulerAngles.z = 0
				var_544_1.localEulerAngles.x = 0
				var_544_1.localEulerAngles = var_544_1.localEulerAngles
			end

			local var_544_3 = arg_541_1.actors_["1047ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_3) and arg_541_1.var_.characterEffect1047ui_story == nil then
				arg_541_1.var_.characterEffect1047ui_story = var_544_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_4 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 and not isNil(var_544_3) then
				if arg_541_1.var_.characterEffect1047ui_story and not isNil(var_544_3) then
					arg_541_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 and not isNil(var_544_3) and arg_541_1.var_.characterEffect1047ui_story then
				arg_541_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_544_6 = arg_541_1.actors_["10102ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_6) and arg_541_1.var_.characterEffect10102ui_story == nil then
				arg_541_1.var_.characterEffect10102ui_story = var_544_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_7 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 and not isNil(var_544_6) then
				if arg_541_1.var_.characterEffect10102ui_story and not isNil(var_544_6) then
					arg_541_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_541_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_7)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 and not isNil(var_544_6) and arg_541_1.var_.characterEffect10102ui_story then
				arg_541_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_541_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_544_8 = 0
			local var_544_9 = 0.55

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_8 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_10 = arg_541_1:GetWordFromCfg(421031134)
				local var_544_11 = arg_541_1:FormatText(var_544_10.content)

				arg_541_1.text_.text = var_544_11

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_13 = 22 <= 0 and var_544_9 or var_544_9 * (utf8.len(var_544_11) / 22)

				if (22 <= 0 and var_544_9 or var_544_9 * (utf8.len(var_544_11) / 22)) > 0 and var_544_9 < var_544_13 then
					arg_541_1.talkMaxDuration = var_544_13

					if var_544_13 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_13 + var_544_8
					end
				end

				arg_541_1.text_.text = var_544_11
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031134", "story_v_out_421031.awb") ~= 0 then
					local var_544_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031134", "story_v_out_421031.awb") / 1000

					if var_544_14 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_14 + var_544_8
					end

					if var_544_10.prefab_name ~= "" and arg_541_1.actors_[var_544_10.prefab_name] ~= nil then
						local var_544_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_10.prefab_name].transform, "story_v_out_421031", "421031134", "story_v_out_421031.awb")

						arg_541_1:RecordAudio("421031134", var_544_15)
						arg_541_1:RecordAudio("421031134", var_544_15)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_421031", "421031134", "story_v_out_421031.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_421031", "421031134", "story_v_out_421031.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_16 = math.max(var_544_9, arg_541_1.talkMaxDuration)

			if var_544_8 <= arg_541_1.time_ and arg_541_1.time_ < var_544_8 + var_544_16 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_8) / var_544_16

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_8 + var_544_16 and arg_541_1.time_ < var_544_8 + var_544_16 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play421031135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 421031135
		arg_545_1.duration_ = 6.53

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play421031136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1047ui_story = arg_545_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).z)
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles = arg_545_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_545_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1047ui_story"].transform.position).z)
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1047ui_story"].transform.localEulerAngles = arg_545_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["10102ui_story"].transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos10102ui_story = var_548_1.localPosition
			end

			local var_548_2 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 then
				var_548_1.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_545_1.time_ - 0) / var_548_2)
				var_548_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_1.position).x, (manager.ui.mainCamera.transform.position - var_548_1.position).y, (manager.ui.mainCamera.transform.position - var_548_1.position).z)
				var_548_1.localEulerAngles.z = 0
				var_548_1.localEulerAngles.x = 0
				var_548_1.localEulerAngles = var_548_1.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 then
				var_548_1.localPosition = Vector3.New(0, 100, 0)
				var_548_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_1.position).x, (manager.ui.mainCamera.transform.position - var_548_1.position).y, (manager.ui.mainCamera.transform.position - var_548_1.position).z)
				var_548_1.localEulerAngles.z = 0
				var_548_1.localEulerAngles.x = 0
				var_548_1.localEulerAngles = var_548_1.localEulerAngles
			end

			local var_548_3 = manager.ui.mainCamera.transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				local var_548_4 = arg_545_1.var_.effect1135

				if not arg_545_1.var_.effect1135 then
					var_548_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_548_3)
					var_548_4.name = "1135"
					arg_545_1.var_.effect1135 = var_548_4
				else
					var_548_4.transform:SetParent(var_548_3)
				end

				var_548_4.transform.localPosition = Vector3.New(-0.28, 0, -4.73)
				var_548_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_548_6 = 0

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.var_.shakeOldPos = var_548_3.localPosition
			end

			local var_548_7 = 1

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_7 then
				local var_548_8, var_548_9 = math.modf((arg_545_1.time_ - var_548_6) / 0.066)

				var_548_3.localPosition = Vector3.New(var_548_9 * 0.13, var_548_9 * 0.13, var_548_9 * 0.13) + arg_545_1.var_.shakeOldPos
			end

			if arg_545_1.time_ >= var_548_6 + var_548_7 and arg_545_1.time_ < var_548_6 + var_548_7 + arg_548_0 then
				var_548_3.localPosition = arg_545_1.var_.shakeOldPos
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			if arg_545_1.frameCnt_ <= 1 then
				arg_545_1.dialog_:SetActive(false)
			end

			local var_548_11 = 1.53333333333333
			local var_548_12 = 1

			if 1.53333333333333 < arg_545_1.time_ and arg_545_1.time_ <= var_548_11 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0

				arg_545_1.dialog_:SetActive(true)

				arg_545_1.dialogCg_.alpha = 0

				local var_548_13 = LeanTween.value(arg_545_1.dialog_, 0, 1, 0.3)

				var_548_13:setOnUpdate(LuaHelper.FloatAction(function(arg_549_0)
					arg_545_1.dialogCg_.alpha = arg_549_0
				end))
				var_548_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_545_1.dialog_)
					var_548_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_545_1.duration_ = arg_545_1.duration_ + 0.3

				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_14 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(421031135).content)

				arg_545_1.text_.text = var_548_14

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_16 = 40 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 40)

				if (40 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 40)) > 0 and var_548_12 < var_548_16 then
					arg_545_1.talkMaxDuration = var_548_16
					var_548_11 = var_548_11 + 0.3

					if var_548_16 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_16 + var_548_11
					end
				end

				arg_545_1.text_.text = var_548_14
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_17 = var_548_11 + 0.3
			local var_548_18 = math.max(var_548_12, arg_545_1.talkMaxDuration)

			if var_548_11 + 0.3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_17 + var_548_18 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_17) / var_548_18

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_17 + var_548_18 and arg_545_1.time_ < var_548_17 + var_548_18 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play421031136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 421031136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play421031137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				if arg_551_1.var_.effect1135 then
					Object.Destroy(arg_551_1.var_.effect1135)

					arg_551_1.var_.effect1135 = nil
				end
			end

			local var_554_1 = 0
			local var_554_2 = 0.3

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(421031136).content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 12 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 12)

				if (12 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 12)) > 0 and var_554_2 < var_554_5 then
					arg_551_1.talkMaxDuration = var_554_5

					if var_554_5 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_6 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_6 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_6

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_6 and arg_551_1.time_ < var_554_1 + var_554_6 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play421031137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 421031137
		arg_555_1.duration_ = 2

		local var_555_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play421031138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1047ui_story = arg_555_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).z)
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles = arg_555_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_555_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1047ui_story"].transform.position).z)
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1047ui_story"].transform.localEulerAngles = arg_555_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["1047ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1047ui_story == nil then
				arg_555_1.var_.characterEffect1047ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect1047ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1047ui_story then
				arg_555_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_558_4 = 0
			local var_558_5 = 0.1

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:GetWordFromCfg(421031137)
				local var_558_7 = arg_555_1:FormatText(var_558_6.content)

				arg_555_1.text_.text = var_558_7

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_9 = 4 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 4)

				if (4 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 4)) > 0 and var_558_5 < var_558_9 then
					arg_555_1.talkMaxDuration = var_558_9

					if var_558_9 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_9 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_7
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031137", "story_v_out_421031.awb") ~= 0 then
					local var_558_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031137", "story_v_out_421031.awb") / 1000

					if var_558_10 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_4
					end

					if var_558_6.prefab_name ~= "" and arg_555_1.actors_[var_558_6.prefab_name] ~= nil then
						local var_558_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_6.prefab_name].transform, "story_v_out_421031", "421031137", "story_v_out_421031.awb")

						arg_555_1:RecordAudio("421031137", var_558_11)
						arg_555_1:RecordAudio("421031137", var_558_11)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_421031", "421031137", "story_v_out_421031.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_421031", "421031137", "story_v_out_421031.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_12 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_12 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_12

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_12 and arg_555_1.time_ < var_558_4 + var_558_12 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play421031138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 421031138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play421031139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.var_.moveOldPos1047ui_story = arg_559_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_562_0 = 0.001

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 then
				arg_559_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_559_1.time_ - 0) / var_562_0)
				arg_559_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).z)
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles = arg_559_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 then
				arg_559_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_559_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1047ui_story"].transform.position).z)
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1047ui_story"].transform.localEulerAngles = arg_559_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_562_1 = arg_559_1.actors_["1138"]

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				local var_562_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_562_2 then
					var_562_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_562_2.radialBlurScale = 0
					var_562_2.radialBlurGradient = 1
					var_562_2.radialBlurIntensity = 1

					if var_562_1 then
						var_562_2.radialBlurTarget = var_562_1.transform
					end
				end
			end

			local var_562_3 = 2.03333333333333

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_3 then
				local var_562_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_562_4 then
					var_562_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_562_4.radialBlurScale = Mathf.Lerp(0, 1, (arg_559_1.time_ - 0) / var_562_3)
					var_562_4.radialBlurGradient = Mathf.Lerp(1, 1, (arg_559_1.time_ - 0) / var_562_3)
					var_562_4.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_559_1.time_ - 0) / var_562_3)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_3 and arg_559_1.time_ < 0 + var_562_3 + arg_562_0 then
				local var_562_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_562_5 then
					var_562_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_562_5.radialBlurScale = 1
					var_562_5.radialBlurGradient = 1
					var_562_5.radialBlurIntensity = 1
				end
			end

			if 0.266666666666667 < arg_559_1.time_ and arg_559_1.time_ <= 0.266666666666667 + arg_562_0 then
				arg_559_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_562_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_559_1.bgmTxt_.text ~= var_562_9 and arg_559_1.bgmTxt_.text ~= "" then
						if arg_559_1.bgmTxt2_.text ~= "" then
							arg_559_1.bgmTxt_.text = arg_559_1.bgmTxt2_.text
						end

						arg_559_1.bgmTxt2_.text = var_562_9

						arg_559_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_559_1.bgmTxt_.text = var_562_9
						arg_559_1.bgmTxt2_.text = var_562_9
					end

					if arg_559_1.bgmTimer then
						arg_559_1.bgmTimer:Stop()

						arg_559_1.bgmTimer = nil
					end

					if arg_559_1.settingData.show_music_name == 1 then
						arg_559_1.musicController:SetSelectedState("show")
						arg_559_1.musicAnimator_:Play("open", 0, 0)

						if arg_559_1.settingData.music_time ~= 0 then
							arg_559_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_559_1.settingData.music_time), function()
								if arg_559_1 == nil or isNil(arg_559_1.bgmTxt_) then
									return
								end

								arg_559_1.musicController:SetSelectedState("hide")
								arg_559_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_562_10 = 0
			local var_562_11 = 1.875

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_10 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_12 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(421031138).content)

				arg_559_1.text_.text = var_562_12

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_14 = 75 <= 0 and var_562_11 or var_562_11 * (utf8.len(var_562_12) / 75)

				if (75 <= 0 and var_562_11 or var_562_11 * (utf8.len(var_562_12) / 75)) > 0 and var_562_11 < var_562_14 then
					arg_559_1.talkMaxDuration = var_562_14

					if var_562_14 + var_562_10 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_14 + var_562_10
					end
				end

				arg_559_1.text_.text = var_562_12
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_15 = math.max(var_562_11, arg_559_1.talkMaxDuration)

			if var_562_10 <= arg_559_1.time_ and arg_559_1.time_ < var_562_10 + var_562_15 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_10) / var_562_15

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_10 + var_562_15 and arg_559_1.time_ < var_562_10 + var_562_15 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play421031139 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 421031139
		arg_564_1.duration_ = 7.87

		local var_564_0 = {
			zh = 7.566,
			ja = 7.866
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play421031140(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if arg_564_1.bgs_.I11o == nil then
				local var_567_0 = Object.Instantiate(arg_564_1.paintGo_)

				var_567_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_567_0.name = "I11o"
				var_567_0.transform.parent = arg_564_1.stage_.transform
				var_567_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_564_1.bgs_.I11o = var_567_0
			end

			if 2 < arg_564_1.time_ and arg_564_1.time_ <= 2 + arg_567_0 then
				local var_567_1 = arg_564_1.bgs_.I11o

				arg_564_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_567_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_567_2 = var_567_1:GetComponent("SpriteRenderer")

				if var_567_2 and var_567_2.sprite then
					local var_567_3 = 2 * (var_567_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_567_1.transform.localScale = Vector3.New(var_567_3 / var_567_2.sprite.bounds.size.y < var_567_3 * manager.ui.mainCameraCom_.aspect / var_567_2.sprite.bounds.size.x and var_567_3 * manager.ui.mainCameraCom_.aspect / var_567_2.sprite.bounds.size.x or var_567_3 / var_567_2.sprite.bounds.size.y, var_567_3 / var_567_2.sprite.bounds.size.y < var_567_3 * manager.ui.mainCameraCom_.aspect / var_567_2.sprite.bounds.size.x and var_567_3 * manager.ui.mainCameraCom_.aspect / var_567_2.sprite.bounds.size.x or var_567_3 / var_567_2.sprite.bounds.size.y, 0)
				end

				for iter_567_0, iter_567_1 in pairs(arg_564_1.bgs_) do
					if iter_567_0 ~= "I11o" then
						iter_567_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_567_4 = 4

			if 4 < arg_564_1.time_ and arg_564_1.time_ <= var_567_4 + arg_567_0 then
				arg_564_1.allBtn_.enabled = false
			end

			if arg_564_1.time_ >= var_567_4 + 0.0999999999999996 and arg_564_1.time_ < var_567_4 + 0.0999999999999996 + arg_567_0 then
				arg_564_1.allBtn_.enabled = true
			end

			local var_567_5 = 0

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_5 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_6 = 2

			if var_567_5 <= arg_564_1.time_ and arg_564_1.time_ < var_567_5 + var_567_6 then
				local var_567_7 = Color.New(0, 0, 0)

				var_567_7.a = Mathf.Lerp(0, 1, (arg_564_1.time_ - var_567_5) / var_567_6)
				arg_564_1.mask_.color = var_567_7
			end

			if arg_564_1.time_ >= var_567_5 + var_567_6 and arg_564_1.time_ < var_567_5 + var_567_6 + arg_567_0 then
				local var_567_8 = Color.New(0, 0, 0)

				var_567_8.a = 1
				arg_564_1.mask_.color = var_567_8
			end

			local var_567_9 = 2

			if 2 < arg_564_1.time_ and arg_564_1.time_ <= var_567_9 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_10 = 2

			if var_567_9 <= arg_564_1.time_ and arg_564_1.time_ < var_567_9 + var_567_10 then
				local var_567_11 = Color.New(0, 0, 0)

				var_567_11.a = Mathf.Lerp(1, 0, (arg_564_1.time_ - var_567_9) / var_567_10)
				arg_564_1.mask_.color = var_567_11
			end

			if arg_564_1.time_ >= var_567_9 + var_567_10 and arg_564_1.time_ < var_567_9 + var_567_10 + arg_567_0 then
				local var_567_12 = Color.New(0, 0, 0)

				arg_564_1.mask_.enabled = false
				var_567_12.a = 0
				arg_564_1.mask_.color = var_567_12
			end

			local var_567_13

			if 1.98333333333333 < arg_564_1.time_ and arg_564_1.time_ <= 1.98333333333333 + arg_567_0 then
				local var_567_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_567_14 then
					var_567_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_567_14.radialBlurScale = 1
					var_567_14.radialBlurGradient = 1
					var_567_14.radialBlurIntensity = 1

					if var_567_13 then
						var_567_14.radialBlurTarget = var_567_13.transform
					end
				end
			end

			local var_567_15 = 0.0166666666666666

			if 1.98333333333333 <= arg_564_1.time_ and arg_564_1.time_ < 1.98333333333333 + var_567_15 then
				local var_567_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_567_16 then
					var_567_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_567_16.radialBlurScale = Mathf.Lerp(1, 0, (arg_564_1.time_ - 1.98333333333333) / var_567_15)
					var_567_16.radialBlurGradient = Mathf.Lerp(1, 1, (arg_564_1.time_ - 1.98333333333333) / var_567_15)
					var_567_16.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_564_1.time_ - 1.98333333333333) / var_567_15)
				end
			end

			if arg_564_1.time_ >= 1.98333333333333 + var_567_15 and arg_564_1.time_ < 1.98333333333333 + var_567_15 + arg_567_0 then
				local var_567_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_567_17 then
					var_567_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_567_17.radialBlurScale = 0
					var_567_17.radialBlurGradient = 1
					var_567_17.radialBlurIntensity = 1
				end
			end

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_567_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_564_1.bgmTxt_.text ~= var_567_20 and arg_564_1.bgmTxt_.text ~= "" then
						if arg_564_1.bgmTxt2_.text ~= "" then
							arg_564_1.bgmTxt_.text = arg_564_1.bgmTxt2_.text
						end

						arg_564_1.bgmTxt2_.text = var_567_20

						arg_564_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_564_1.bgmTxt_.text = var_567_20
						arg_564_1.bgmTxt2_.text = var_567_20
					end

					if arg_564_1.bgmTimer then
						arg_564_1.bgmTimer:Stop()

						arg_564_1.bgmTimer = nil
					end

					if arg_564_1.settingData.show_music_name == 1 then
						arg_564_1.musicController:SetSelectedState("show")
						arg_564_1.musicAnimator_:Play("open", 0, 0)

						if arg_564_1.settingData.music_time ~= 0 then
							arg_564_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_564_1.settingData.music_time), function()
								if arg_564_1 == nil or isNil(arg_564_1.bgmTxt_) then
									return
								end

								arg_564_1.musicController:SetSelectedState("hide")
								arg_564_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.5 < arg_564_1.time_ and arg_564_1.time_ <= 0.5 + arg_567_0 then
				arg_564_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_567_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_564_1.bgmTxt_.text ~= var_567_23 and arg_564_1.bgmTxt_.text ~= "" then
						if arg_564_1.bgmTxt2_.text ~= "" then
							arg_564_1.bgmTxt_.text = arg_564_1.bgmTxt2_.text
						end

						arg_564_1.bgmTxt2_.text = var_567_23

						arg_564_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_564_1.bgmTxt_.text = var_567_23
						arg_564_1.bgmTxt2_.text = var_567_23
					end

					if arg_564_1.bgmTimer then
						arg_564_1.bgmTimer:Stop()

						arg_564_1.bgmTimer = nil
					end

					if arg_564_1.settingData.show_music_name == 1 then
						arg_564_1.musicController:SetSelectedState("show")
						arg_564_1.musicAnimator_:Play("open", 0, 0)

						if arg_564_1.settingData.music_time ~= 0 then
							arg_564_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_564_1.settingData.music_time), function()
								if arg_564_1 == nil or isNil(arg_564_1.bgmTxt_) then
									return
								end

								arg_564_1.musicController:SetSelectedState("hide")
								arg_564_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_564_1.time_ and arg_564_1.time_ <= 0.3 + arg_567_0 then
				arg_564_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.6 < arg_564_1.time_ and arg_564_1.time_ <= 1.6 + arg_567_0 then
				arg_564_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 2.23333333333333 < arg_564_1.time_ and arg_564_1.time_ <= 2.23333333333333 + arg_567_0 then
				arg_564_1:AudioAction("play", "effect", "se_story_143", "se_story_143_battle", "")
			end

			if arg_564_1.frameCnt_ <= 1 then
				arg_564_1.dialog_:SetActive(false)
			end

			local var_567_27 = 4
			local var_567_28 = 0.25

			if 4 < arg_564_1.time_ and arg_564_1.time_ <= var_567_27 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				arg_564_1.dialog_:SetActive(true)

				arg_564_1.dialogCg_.alpha = 0

				local var_567_29 = LeanTween.value(arg_564_1.dialog_, 0, 1, 0.3)

				var_567_29:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_564_1.dialogCg_.alpha = arg_570_0
				end))
				var_567_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_564_1.dialog_)
					var_567_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_564_1.duration_ = arg_564_1.duration_ + 0.3

				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[1312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_30 = arg_564_1:GetWordFromCfg(421031139)
				local var_567_31 = arg_564_1:FormatText(var_567_30.content)

				arg_564_1.text_.text = var_567_31

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_33 = 10 <= 0 and var_567_28 or var_567_28 * (utf8.len(var_567_31) / 10)

				if (10 <= 0 and var_567_28 or var_567_28 * (utf8.len(var_567_31) / 10)) > 0 and var_567_28 < var_567_33 then
					arg_564_1.talkMaxDuration = var_567_33
					var_567_27 = var_567_27 + 0.3

					if var_567_33 + var_567_27 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_33 + var_567_27
					end
				end

				arg_564_1.text_.text = var_567_31
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031139", "story_v_out_421031.awb") ~= 0 then
					local var_567_34 = manager.audio:GetVoiceLength("story_v_out_421031", "421031139", "story_v_out_421031.awb") / 1000

					if var_567_34 + var_567_27 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_34 + var_567_27
					end

					if var_567_30.prefab_name ~= "" and arg_564_1.actors_[var_567_30.prefab_name] ~= nil then
						local var_567_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_30.prefab_name].transform, "story_v_out_421031", "421031139", "story_v_out_421031.awb")

						arg_564_1:RecordAudio("421031139", var_567_35)
						arg_564_1:RecordAudio("421031139", var_567_35)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_421031", "421031139", "story_v_out_421031.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_421031", "421031139", "story_v_out_421031.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_36 = var_567_27 + 0.3
			local var_567_37 = math.max(var_567_28, arg_564_1.talkMaxDuration)

			if var_567_27 + 0.3 <= arg_564_1.time_ and arg_564_1.time_ < var_567_36 + var_567_37 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_36) / var_567_37

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_36 + var_567_37 and arg_564_1.time_ < var_567_36 + var_567_37 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play421031140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 421031140
		arg_572_1.duration_ = 5.47

		local var_572_0 = {
			zh = 4.666,
			ja = 5.466
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play421031141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if arg_572_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_575_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_572_1.stage_.transform)

				var_575_0.name = "10145ui_story"
				var_575_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_572_1.actors_["10145ui_story"] = var_575_0

				local var_575_1 = var_575_0:GetComponentInChildren(typeof(CharacterEffect))

				var_575_1.enabled = true

				local var_575_2 = GameObjectTools.GetOrAddComponent(var_575_0, typeof(DynamicBoneHelper))

				if var_575_2 then
					var_575_2:EnableDynamicBone(false)
				end

				arg_572_1:ShowWeapon(var_575_1.transform, false)

				arg_572_1.var_["10145ui_story" .. "Animator"] = var_575_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_572_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_572_1.var_["10145ui_story" .. "LipSync"] = var_575_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_575_3 = arg_572_1.actors_["10145ui_story"].transform

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.var_.moveOldPos10145ui_story = var_575_3.localPosition
			end

			local var_575_4 = 0.001

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				var_575_3.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_572_1.time_ - 0) / var_575_4)
				var_575_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_575_3.position).x, (manager.ui.mainCamera.transform.position - var_575_3.position).y, (manager.ui.mainCamera.transform.position - var_575_3.position).z)
				var_575_3.localEulerAngles.z = 0
				var_575_3.localEulerAngles.x = 0
				var_575_3.localEulerAngles = var_575_3.localEulerAngles
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				var_575_3.localPosition = Vector3.New(0, -1, -6.2)
				var_575_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_575_3.position).x, (manager.ui.mainCamera.transform.position - var_575_3.position).y, (manager.ui.mainCamera.transform.position - var_575_3.position).z)
				var_575_3.localEulerAngles.z = 0
				var_575_3.localEulerAngles.x = 0
				var_575_3.localEulerAngles = var_575_3.localEulerAngles
			end

			local var_575_5 = arg_572_1.actors_["10145ui_story"]

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(var_575_5) and arg_572_1.var_.characterEffect10145ui_story == nil then
				arg_572_1.var_.characterEffect10145ui_story = var_575_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_6 = 0.200000002980232

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_6 and not isNil(var_575_5) then
				if arg_572_1.var_.characterEffect10145ui_story and not isNil(var_575_5) then
					arg_572_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= 0 + var_575_6 and arg_572_1.time_ < 0 + var_575_6 + arg_575_0 and not isNil(var_575_5) and arg_572_1.var_.characterEffect10145ui_story then
				arg_572_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_575_8 = 0
			local var_575_9 = 0.5

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_8 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_10 = arg_572_1:GetWordFromCfg(421031140)
				local var_575_11 = arg_572_1:FormatText(var_575_10.content)

				arg_572_1.text_.text = var_575_11

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_13 = 20 <= 0 and var_575_9 or var_575_9 * (utf8.len(var_575_11) / 20)

				if (20 <= 0 and var_575_9 or var_575_9 * (utf8.len(var_575_11) / 20)) > 0 and var_575_9 < var_575_13 then
					arg_572_1.talkMaxDuration = var_575_13

					if var_575_13 + var_575_8 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_13 + var_575_8
					end
				end

				arg_572_1.text_.text = var_575_11
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031140", "story_v_out_421031.awb") ~= 0 then
					local var_575_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031140", "story_v_out_421031.awb") / 1000

					if var_575_14 + var_575_8 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_14 + var_575_8
					end

					if var_575_10.prefab_name ~= "" and arg_572_1.actors_[var_575_10.prefab_name] ~= nil then
						local var_575_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_10.prefab_name].transform, "story_v_out_421031", "421031140", "story_v_out_421031.awb")

						arg_572_1:RecordAudio("421031140", var_575_15)
						arg_572_1:RecordAudio("421031140", var_575_15)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_421031", "421031140", "story_v_out_421031.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_421031", "421031140", "story_v_out_421031.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_16 = math.max(var_575_9, arg_572_1.talkMaxDuration)

			if var_575_8 <= arg_572_1.time_ and arg_572_1.time_ < var_575_8 + var_575_16 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_8) / var_575_16

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_8 + var_575_16 and arg_572_1.time_ < var_575_8 + var_575_16 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play421031141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 421031141
		arg_576_1.duration_ = 5.53

		local var_576_0 = {
			zh = 4.6,
			ja = 5.533
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play421031142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.var_.moveOldPos10145ui_story = arg_576_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_579_0 = 0.001

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 then
				arg_576_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_576_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_576_1.time_ - 0) / var_579_0)
				arg_576_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).z)
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles = arg_576_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 then
				arg_576_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_576_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_576_1.actors_["10145ui_story"].transform.position).z)
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_576_1.actors_["10145ui_story"].transform.localEulerAngles = arg_576_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_579_1 = "10143ui_story"

			if arg_576_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_579_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_576_1.stage_.transform)

				var_579_2.name = var_579_1
				var_579_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_576_1.actors_[var_579_1] = var_579_2

				local var_579_3 = var_579_2:GetComponentInChildren(typeof(CharacterEffect))

				var_579_3.enabled = true

				local var_579_4 = GameObjectTools.GetOrAddComponent(var_579_2, typeof(DynamicBoneHelper))

				if var_579_4 then
					var_579_4:EnableDynamicBone(false)
				end

				arg_576_1:ShowWeapon(var_579_3.transform, false)

				arg_576_1.var_[var_579_1 .. "Animator"] = var_579_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_576_1.var_[var_579_1 .. "Animator"].applyRootMotion = true
				arg_576_1.var_[var_579_1 .. "LipSync"] = var_579_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_579_5 = arg_576_1.actors_["10143ui_story"].transform

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.var_.moveOldPos10143ui_story = var_579_5.localPosition
			end

			local var_579_6 = 0.001

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_6 then
				var_579_5.localPosition = Vector3.Lerp(arg_576_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_576_1.time_ - 0) / var_579_6)
				var_579_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_579_5.position).x, (manager.ui.mainCamera.transform.position - var_579_5.position).y, (manager.ui.mainCamera.transform.position - var_579_5.position).z)
				var_579_5.localEulerAngles.z = 0
				var_579_5.localEulerAngles.x = 0
				var_579_5.localEulerAngles = var_579_5.localEulerAngles
			end

			if arg_576_1.time_ >= 0 + var_579_6 and arg_576_1.time_ < 0 + var_579_6 + arg_579_0 then
				var_579_5.localPosition = Vector3.New(0, -1.06, -6)
				var_579_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_579_5.position).x, (manager.ui.mainCamera.transform.position - var_579_5.position).y, (manager.ui.mainCamera.transform.position - var_579_5.position).z)
				var_579_5.localEulerAngles.z = 0
				var_579_5.localEulerAngles.x = 0
				var_579_5.localEulerAngles = var_579_5.localEulerAngles
			end

			local var_579_7 = arg_576_1.actors_["10143ui_story"]

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(var_579_7) and arg_576_1.var_.characterEffect10143ui_story == nil then
				arg_576_1.var_.characterEffect10143ui_story = var_579_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_8 = 0.200000002980232

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_8 and not isNil(var_579_7) then
				if arg_576_1.var_.characterEffect10143ui_story and not isNil(var_579_7) then
					arg_576_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_576_1.time_ >= 0 + var_579_8 and arg_576_1.time_ < 0 + var_579_8 + arg_579_0 and not isNil(var_579_7) and arg_576_1.var_.characterEffect10143ui_story then
				arg_576_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_579_10 = arg_576_1.actors_["10145ui_story"]

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(var_579_10) and arg_576_1.var_.characterEffect10145ui_story == nil then
				arg_576_1.var_.characterEffect10145ui_story = var_579_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_11 = 0.200000002980232

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_11 and not isNil(var_579_10) then
				if arg_576_1.var_.characterEffect10145ui_story and not isNil(var_579_10) then
					arg_576_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_576_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_576_1.time_ - 0) / var_579_11)
				end
			end

			if arg_576_1.time_ >= 0 + var_579_11 and arg_576_1.time_ < 0 + var_579_11 + arg_579_0 and not isNil(var_579_10) and arg_576_1.var_.characterEffect10145ui_story then
				arg_576_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_576_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_579_12 = 0
			local var_579_13 = 0.525

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_12 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_14 = arg_576_1:GetWordFromCfg(421031141)
				local var_579_15 = arg_576_1:FormatText(var_579_14.content)

				arg_576_1.text_.text = var_579_15

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_17 = 21 <= 0 and var_579_13 or var_579_13 * (utf8.len(var_579_15) / 21)

				if (21 <= 0 and var_579_13 or var_579_13 * (utf8.len(var_579_15) / 21)) > 0 and var_579_13 < var_579_17 then
					arg_576_1.talkMaxDuration = var_579_17

					if var_579_17 + var_579_12 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_17 + var_579_12
					end
				end

				arg_576_1.text_.text = var_579_15
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031141", "story_v_out_421031.awb") ~= 0 then
					local var_579_18 = manager.audio:GetVoiceLength("story_v_out_421031", "421031141", "story_v_out_421031.awb") / 1000

					if var_579_18 + var_579_12 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_18 + var_579_12
					end

					if var_579_14.prefab_name ~= "" and arg_576_1.actors_[var_579_14.prefab_name] ~= nil then
						local var_579_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_14.prefab_name].transform, "story_v_out_421031", "421031141", "story_v_out_421031.awb")

						arg_576_1:RecordAudio("421031141", var_579_19)
						arg_576_1:RecordAudio("421031141", var_579_19)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_421031", "421031141", "story_v_out_421031.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_421031", "421031141", "story_v_out_421031.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_20 = math.max(var_579_13, arg_576_1.talkMaxDuration)

			if var_579_12 <= arg_576_1.time_ and arg_576_1.time_ < var_579_12 + var_579_20 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_12) / var_579_20

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_12 + var_579_20 and arg_576_1.time_ < var_579_12 + var_579_20 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_576_1:InitPlayNodeList()
	end,
	Play421031142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 421031142
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play421031143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.var_.moveOldPos10143ui_story = arg_580_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_583_0 = 0.001

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 then
				arg_580_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_580_1.time_ - 0) / var_583_0)
				arg_580_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).z)
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles = arg_580_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 then
				arg_580_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_580_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["10143ui_story"].transform.position).z)
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["10143ui_story"].transform.localEulerAngles = arg_580_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_583_1 = arg_580_1.actors_["10143ui_story"]

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(var_583_1) and arg_580_1.var_.characterEffect10143ui_story == nil then
				arg_580_1.var_.characterEffect10143ui_story = var_583_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_2 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_2 and not isNil(var_583_1) then
				if arg_580_1.var_.characterEffect10143ui_story and not isNil(var_583_1) then
					arg_580_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_580_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_580_1.time_ - 0) / var_583_2)
				end
			end

			if arg_580_1.time_ >= 0 + var_583_2 and arg_580_1.time_ < 0 + var_583_2 + arg_583_0 and not isNil(var_583_1) and arg_580_1.var_.characterEffect10143ui_story then
				arg_580_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_580_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_583_3 = 0
			local var_583_4 = 1.1

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_3 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_5 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(421031142).content)

				arg_580_1.text_.text = var_583_5

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_7 = 44 <= 0 and var_583_4 or var_583_4 * (utf8.len(var_583_5) / 44)

				if (44 <= 0 and var_583_4 or var_583_4 * (utf8.len(var_583_5) / 44)) > 0 and var_583_4 < var_583_7 then
					arg_580_1.talkMaxDuration = var_583_7

					if var_583_7 + var_583_3 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_3
					end
				end

				arg_580_1.text_.text = var_583_5
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_8 = math.max(var_583_4, arg_580_1.talkMaxDuration)

			if var_583_3 <= arg_580_1.time_ and arg_580_1.time_ < var_583_3 + var_583_8 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_3) / var_583_8

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_3 + var_583_8 and arg_580_1.time_ < var_583_3 + var_583_8 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	Play421031143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 421031143
		arg_584_1.duration_ = 3.03

		local var_584_0 = {
			zh = 3.033,
			ja = 2.466
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play421031144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.var_.moveOldPos10143ui_story = arg_584_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_587_0 = 0.001

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 then
				arg_584_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_584_1.time_ - 0) / var_587_0)
				arg_584_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).z)
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles = arg_584_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 then
				arg_584_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_584_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["10143ui_story"].transform.position).z)
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_584_1.actors_["10143ui_story"].transform.localEulerAngles = arg_584_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_587_1 = arg_584_1.actors_["10143ui_story"]

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect10143ui_story == nil then
				arg_584_1.var_.characterEffect10143ui_story = var_587_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_2 = 0.200000002980232

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_2 and not isNil(var_587_1) then
				if arg_584_1.var_.characterEffect10143ui_story and not isNil(var_587_1) then
					arg_584_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= 0 + var_587_2 and arg_584_1.time_ < 0 + var_587_2 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect10143ui_story then
				arg_584_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_587_4 = 0
			local var_587_5 = 0.325

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_4 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_6 = arg_584_1:GetWordFromCfg(421031143)
				local var_587_7 = arg_584_1:FormatText(var_587_6.content)

				arg_584_1.text_.text = var_587_7

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_9 = 13 <= 0 and var_587_5 or var_587_5 * (utf8.len(var_587_7) / 13)

				if (13 <= 0 and var_587_5 or var_587_5 * (utf8.len(var_587_7) / 13)) > 0 and var_587_5 < var_587_9 then
					arg_584_1.talkMaxDuration = var_587_9

					if var_587_9 + var_587_4 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_9 + var_587_4
					end
				end

				arg_584_1.text_.text = var_587_7
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031143", "story_v_out_421031.awb") ~= 0 then
					local var_587_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031143", "story_v_out_421031.awb") / 1000

					if var_587_10 + var_587_4 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_10 + var_587_4
					end

					if var_587_6.prefab_name ~= "" and arg_584_1.actors_[var_587_6.prefab_name] ~= nil then
						local var_587_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_6.prefab_name].transform, "story_v_out_421031", "421031143", "story_v_out_421031.awb")

						arg_584_1:RecordAudio("421031143", var_587_11)
						arg_584_1:RecordAudio("421031143", var_587_11)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_421031", "421031143", "story_v_out_421031.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_421031", "421031143", "story_v_out_421031.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_12 = math.max(var_587_5, arg_584_1.talkMaxDuration)

			if var_587_4 <= arg_584_1.time_ and arg_584_1.time_ < var_587_4 + var_587_12 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_4) / var_587_12

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_4 + var_587_12 and arg_584_1.time_ < var_587_4 + var_587_12 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_584_1:InitPlayNodeList()
	end,
	Play421031144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 421031144
		arg_588_1.duration_ = 6.53

		local var_588_0 = {
			zh = 6.3,
			ja = 6.533
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play421031145(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0.7

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_1 = arg_588_1:GetWordFromCfg(421031144)
				local var_591_2 = arg_588_1:FormatText(var_591_1.content)

				arg_588_1.text_.text = var_591_2

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_4 = 28 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_2) / 28)

				if (28 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_2) / 28)) > 0 and var_591_0 < var_591_4 then
					arg_588_1.talkMaxDuration = var_591_4

					if var_591_4 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_4 + 0
					end
				end

				arg_588_1.text_.text = var_591_2
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031144", "story_v_out_421031.awb") ~= 0 then
					local var_591_5 = manager.audio:GetVoiceLength("story_v_out_421031", "421031144", "story_v_out_421031.awb") / 1000

					if var_591_5 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + 0
					end

					if var_591_1.prefab_name ~= "" and arg_588_1.actors_[var_591_1.prefab_name] ~= nil then
						local var_591_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_1.prefab_name].transform, "story_v_out_421031", "421031144", "story_v_out_421031.awb")

						arg_588_1:RecordAudio("421031144", var_591_6)
						arg_588_1:RecordAudio("421031144", var_591_6)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_421031", "421031144", "story_v_out_421031.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_421031", "421031144", "story_v_out_421031.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_7 = math.max(var_591_0, arg_588_1.talkMaxDuration)

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_7 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - 0) / var_591_7

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= 0 + var_591_7 and arg_588_1.time_ < 0 + var_591_7 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play421031145 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 421031145
		arg_592_1.duration_ = 6.97

		local var_592_0 = {
			zh = 4.433,
			ja = 6.966
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play421031146(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.var_.moveOldPos10145ui_story = arg_592_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_595_0 = 0.001

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_0 then
				arg_592_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_592_1.time_ - 0) / var_595_0)
				arg_592_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).z)
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles = arg_592_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_592_1.time_ >= 0 + var_595_0 and arg_592_1.time_ < 0 + var_595_0 + arg_595_0 then
				arg_592_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_592_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_592_1.actors_["10145ui_story"].transform.position).z)
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_592_1.actors_["10145ui_story"].transform.localEulerAngles = arg_592_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_595_1 = arg_592_1.actors_["10143ui_story"].transform

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.var_.moveOldPos10143ui_story = var_595_1.localPosition
			end

			local var_595_2 = 0.001

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_2 then
				var_595_1.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_592_1.time_ - 0) / var_595_2)
				var_595_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_1.position).x, (manager.ui.mainCamera.transform.position - var_595_1.position).y, (manager.ui.mainCamera.transform.position - var_595_1.position).z)
				var_595_1.localEulerAngles.z = 0
				var_595_1.localEulerAngles.x = 0
				var_595_1.localEulerAngles = var_595_1.localEulerAngles
			end

			if arg_592_1.time_ >= 0 + var_595_2 and arg_592_1.time_ < 0 + var_595_2 + arg_595_0 then
				var_595_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_595_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_1.position).x, (manager.ui.mainCamera.transform.position - var_595_1.position).y, (manager.ui.mainCamera.transform.position - var_595_1.position).z)
				var_595_1.localEulerAngles.z = 0
				var_595_1.localEulerAngles.x = 0
				var_595_1.localEulerAngles = var_595_1.localEulerAngles
			end

			local var_595_3 = arg_592_1.actors_["10145ui_story"]

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(var_595_3) and arg_592_1.var_.characterEffect10145ui_story == nil then
				arg_592_1.var_.characterEffect10145ui_story = var_595_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_4 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_4 and not isNil(var_595_3) then
				if arg_592_1.var_.characterEffect10145ui_story and not isNil(var_595_3) then
					arg_592_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= 0 + var_595_4 and arg_592_1.time_ < 0 + var_595_4 + arg_595_0 and not isNil(var_595_3) and arg_592_1.var_.characterEffect10145ui_story then
				arg_592_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_595_6 = arg_592_1.actors_["10143ui_story"]

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(var_595_6) and arg_592_1.var_.characterEffect10143ui_story == nil then
				arg_592_1.var_.characterEffect10143ui_story = var_595_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_7 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_7 and not isNil(var_595_6) then
				if arg_592_1.var_.characterEffect10143ui_story and not isNil(var_595_6) then
					arg_592_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_592_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_592_1.time_ - 0) / var_595_7)
				end
			end

			if arg_592_1.time_ >= 0 + var_595_7 and arg_592_1.time_ < 0 + var_595_7 + arg_595_0 and not isNil(var_595_6) and arg_592_1.var_.characterEffect10143ui_story then
				arg_592_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_592_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action5_1")
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_595_8 = 0
			local var_595_9 = 0.55

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_8 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_10 = arg_592_1:GetWordFromCfg(421031145)
				local var_595_11 = arg_592_1:FormatText(var_595_10.content)

				arg_592_1.text_.text = var_595_11

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_13 = 22 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 22)

				if (22 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 22)) > 0 and var_595_9 < var_595_13 then
					arg_592_1.talkMaxDuration = var_595_13

					if var_595_13 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_13 + var_595_8
					end
				end

				arg_592_1.text_.text = var_595_11
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031145", "story_v_out_421031.awb") ~= 0 then
					local var_595_14 = manager.audio:GetVoiceLength("story_v_out_421031", "421031145", "story_v_out_421031.awb") / 1000

					if var_595_14 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_14 + var_595_8
					end

					if var_595_10.prefab_name ~= "" and arg_592_1.actors_[var_595_10.prefab_name] ~= nil then
						local var_595_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_10.prefab_name].transform, "story_v_out_421031", "421031145", "story_v_out_421031.awb")

						arg_592_1:RecordAudio("421031145", var_595_15)
						arg_592_1:RecordAudio("421031145", var_595_15)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_421031", "421031145", "story_v_out_421031.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_421031", "421031145", "story_v_out_421031.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_16 = math.max(var_595_9, arg_592_1.talkMaxDuration)

			if var_595_8 <= arg_592_1.time_ and arg_592_1.time_ < var_595_8 + var_595_16 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_8) / var_595_16

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_8 + var_595_16 and arg_592_1.time_ < var_595_8 + var_595_16 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_592_1:InitPlayNodeList()
	end,
	Play421031146 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 421031146
		arg_596_1.duration_ = 5.87

		local var_596_0 = {
			zh = 4.833,
			ja = 5.866
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play421031147(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 and not isNil(arg_596_1.actors_["10145ui_story"]) and arg_596_1.var_.characterEffect10145ui_story == nil then
				arg_596_1.var_.characterEffect10145ui_story = arg_596_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_0 = 0.200000002980232

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_0 and not isNil(arg_596_1.actors_["10145ui_story"]) then
				if arg_596_1.var_.characterEffect10145ui_story and not isNil(arg_596_1.actors_["10145ui_story"]) then
					arg_596_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_596_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_596_1.time_ - 0) / var_599_0)
				end
			end

			if arg_596_1.time_ >= 0 + var_599_0 and arg_596_1.time_ < 0 + var_599_0 + arg_599_0 and not isNil(arg_596_1.actors_["10145ui_story"]) and arg_596_1.var_.characterEffect10145ui_story then
				arg_596_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_596_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_599_1 = 0
			local var_599_2 = 0.525

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_3 = arg_596_1:GetWordFromCfg(421031146)
				local var_599_4 = arg_596_1:FormatText(var_599_3.content)

				arg_596_1.text_.text = var_599_4

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_6 = 21 <= 0 and var_599_2 or var_599_2 * (utf8.len(var_599_4) / 21)

				if (21 <= 0 and var_599_2 or var_599_2 * (utf8.len(var_599_4) / 21)) > 0 and var_599_2 < var_599_6 then
					arg_596_1.talkMaxDuration = var_599_6

					if var_599_6 + var_599_1 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_6 + var_599_1
					end
				end

				arg_596_1.text_.text = var_599_4
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031146", "story_v_out_421031.awb") ~= 0 then
					local var_599_7 = manager.audio:GetVoiceLength("story_v_out_421031", "421031146", "story_v_out_421031.awb") / 1000

					if var_599_7 + var_599_1 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_1
					end

					if var_599_3.prefab_name ~= "" and arg_596_1.actors_[var_599_3.prefab_name] ~= nil then
						local var_599_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_3.prefab_name].transform, "story_v_out_421031", "421031146", "story_v_out_421031.awb")

						arg_596_1:RecordAudio("421031146", var_599_8)
						arg_596_1:RecordAudio("421031146", var_599_8)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_421031", "421031146", "story_v_out_421031.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_421031", "421031146", "story_v_out_421031.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_9 = math.max(var_599_2, arg_596_1.talkMaxDuration)

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_9 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_1) / var_599_9

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_1 + var_599_9 and arg_596_1.time_ < var_599_1 + var_599_9 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play421031147 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 421031147
		arg_600_1.duration_ = 5.63

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play421031148(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.var_.moveOldPos10145ui_story = arg_600_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_603_0 = 0.001

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 then
				arg_600_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_600_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_600_1.time_ - 0) / var_603_0)
				arg_600_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).z)
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles = arg_600_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 then
				arg_600_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_600_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_600_1.actors_["10145ui_story"].transform.position).z)
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_600_1.actors_["10145ui_story"].transform.localEulerAngles = arg_600_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_603_1 = arg_600_1.actors_["10143ui_story"].transform

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.var_.moveOldPos10143ui_story = var_603_1.localPosition
			end

			local var_603_2 = 0.001

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_2 then
				var_603_1.localPosition = Vector3.Lerp(arg_600_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_600_1.time_ - 0) / var_603_2)
				var_603_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_603_1.position).x, (manager.ui.mainCamera.transform.position - var_603_1.position).y, (manager.ui.mainCamera.transform.position - var_603_1.position).z)
				var_603_1.localEulerAngles.z = 0
				var_603_1.localEulerAngles.x = 0
				var_603_1.localEulerAngles = var_603_1.localEulerAngles
			end

			if arg_600_1.time_ >= 0 + var_603_2 and arg_600_1.time_ < 0 + var_603_2 + arg_603_0 then
				var_603_1.localPosition = Vector3.New(0, 100, 0)
				var_603_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_603_1.position).x, (manager.ui.mainCamera.transform.position - var_603_1.position).y, (manager.ui.mainCamera.transform.position - var_603_1.position).z)
				var_603_1.localEulerAngles.z = 0
				var_603_1.localEulerAngles.x = 0
				var_603_1.localEulerAngles = var_603_1.localEulerAngles
			end

			local var_603_3 = manager.ui.mainCamera.transform

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.var_.shakeOldPos = var_603_3.localPosition
			end

			local var_603_4 = 0.633333333333333

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_4 then
				local var_603_5, var_603_6 = math.modf((arg_600_1.time_ - 0) / 0.066)

				var_603_3.localPosition = Vector3.New(var_603_6 * 0.13, var_603_6 * 0.13, var_603_6 * 0.13) + arg_600_1.var_.shakeOldPos
			end

			if arg_600_1.time_ >= 0 + var_603_4 and arg_600_1.time_ < 0 + var_603_4 + arg_603_0 then
				var_603_3.localPosition = arg_600_1.var_.shakeOldPos
			end

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			local var_603_8 = 0.633333333333333
			local var_603_9 = 1

			if 0.633333333333333 < arg_600_1.time_ and arg_600_1.time_ <= var_603_8 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_10 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(421031147).content)

				arg_600_1.text_.text = var_603_10

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_12 = 40 <= 0 and var_603_9 or var_603_9 * (utf8.len(var_603_10) / 40)

				if (40 <= 0 and var_603_9 or var_603_9 * (utf8.len(var_603_10) / 40)) > 0 and var_603_9 < var_603_12 then
					arg_600_1.talkMaxDuration = var_603_12

					if var_603_12 + var_603_8 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_12 + var_603_8
					end
				end

				arg_600_1.text_.text = var_603_10
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_13 = math.max(var_603_9, arg_600_1.talkMaxDuration)

			if var_603_8 <= arg_600_1.time_ and arg_600_1.time_ < var_603_8 + var_603_13 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_8) / var_603_13

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_8 + var_603_13 and arg_600_1.time_ < var_603_8 + var_603_13 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_600_1:InitPlayNodeList()
	end,
	Play421031148 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 421031148
		arg_604_1.duration_ = 3.73

		local var_604_0 = {
			zh = 2.4,
			ja = 3.733
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
			arg_604_1.auto_ = false
		end

		function arg_604_1.playNext_(arg_606_0)
			arg_604_1.onStoryFinished_()
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.var_.moveOldPos1047ui_story = arg_604_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_607_0 = 0.001

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 then
				arg_604_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_604_1.time_ - 0) / var_607_0)
				arg_604_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).z)
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles = arg_604_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 then
				arg_604_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_604_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1047ui_story"].transform.position).z)
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_604_1.actors_["1047ui_story"].transform.localEulerAngles = arg_604_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_607_1 = arg_604_1.actors_["1047ui_story"]

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(var_607_1) and arg_604_1.var_.characterEffect1047ui_story == nil then
				arg_604_1.var_.characterEffect1047ui_story = var_607_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_2 and not isNil(var_607_1) then
				if arg_604_1.var_.characterEffect1047ui_story and not isNil(var_607_1) then
					arg_604_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_2 and arg_604_1.time_ < 0 + var_607_2 + arg_607_0 and not isNil(var_607_1) and arg_604_1.var_.characterEffect1047ui_story then
				arg_604_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_607_4 = 0
			local var_607_5 = 0.275

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_6 = arg_604_1:GetWordFromCfg(421031148)
				local var_607_7 = arg_604_1:FormatText(var_607_6.content)

				arg_604_1.text_.text = var_607_7

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_9 = 11 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 11)

				if (11 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 11)) > 0 and var_607_5 < var_607_9 then
					arg_604_1.talkMaxDuration = var_607_9

					if var_607_9 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_9 + var_607_4
					end
				end

				arg_604_1.text_.text = var_607_7
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421031", "421031148", "story_v_out_421031.awb") ~= 0 then
					local var_607_10 = manager.audio:GetVoiceLength("story_v_out_421031", "421031148", "story_v_out_421031.awb") / 1000

					if var_607_10 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_10 + var_607_4
					end

					if var_607_6.prefab_name ~= "" and arg_604_1.actors_[var_607_6.prefab_name] ~= nil then
						local var_607_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_6.prefab_name].transform, "story_v_out_421031", "421031148", "story_v_out_421031.awb")

						arg_604_1:RecordAudio("421031148", var_607_11)
						arg_604_1:RecordAudio("421031148", var_607_11)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_421031", "421031148", "story_v_out_421031.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_421031", "421031148", "story_v_out_421031.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_12 = math.max(var_607_5, arg_604_1.talkMaxDuration)

			if var_607_4 <= arg_604_1.time_ and arg_604_1.time_ < var_607_4 + var_607_12 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_4) / var_607_12

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_4 + var_607_12 and arg_604_1.time_ < var_607_4 + var_607_12 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0601",
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/I11o"
	},
	voices = {
		"story_v_out_421031.awb"
	}
}
