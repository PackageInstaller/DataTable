return {
	Play1108106001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108106001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108106002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0402a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0402a")
				var_4_0.name = "ST0402a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0402a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0402a

				arg_1_1.bgs_.ST0402a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0402a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_6 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_6

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_6
						arg_1_1.bgmTxt2_.text = var_4_6
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_wind02", "")
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 2

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.775

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1108106001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)

				if (31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108106002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108106002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108106003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1108106002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)) > 0 and var_12_0 < var_12_3 then
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
	Play1108106003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108106003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1108106004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.025

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1108106003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 41 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 41)

				if (41 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 41)) > 0 and var_16_0 < var_16_3 then
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
	Play1108106004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108106004
		arg_17_1.duration_ = 4.73

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108106005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1081ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1081ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1081ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1081ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_20_3 = arg_17_1.actors_["1081ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1081ui_story = var_20_3.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1081ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1081ui_story == nil then
				arg_17_1.var_.characterEffect1081ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1081ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1081ui_story then
				arg_17_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1108106004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)

				if (3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")

						arg_17_1:RecordAudio("1108106004", var_20_15)
						arg_17_1:RecordAudio("1108106004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1108106005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108106005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1108106006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1081ui_story"]) and arg_21_1.var_.characterEffect1081ui_story == nil then
				arg_21_1.var_.characterEffect1081ui_story = arg_21_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1081ui_story"]) then
				if arg_21_1.var_.characterEffect1081ui_story and not isNil(arg_21_1.actors_["1081ui_story"]) then
					arg_21_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1081ui_story"]) and arg_21_1.var_.characterEffect1081ui_story then
				arg_21_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1108106005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 53)

				if (53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 53)) > 0 and var_24_2 < var_24_5 then
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
	Play1108106006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108106006
		arg_25_1.duration_ = 3.83

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1108106007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1081ui_story"]) and arg_25_1.var_.characterEffect1081ui_story == nil then
				arg_25_1.var_.characterEffect1081ui_story = arg_25_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1081ui_story"]) then
				if arg_25_1.var_.characterEffect1081ui_story and not isNil(arg_25_1.actors_["1081ui_story"]) then
					arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1081ui_story"]) and arg_25_1.var_.characterEffect1081ui_story then
				arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_2 = 0
			local var_28_3 = 0.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(1108106006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 14 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 14)

				if (14 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 14)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")

						arg_25_1:RecordAudio("1108106006", var_28_9)
						arg_25_1:RecordAudio("1108106006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1108106007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108106007
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"

			SetActive(arg_29_1.choicesGo_, true)

			for iter_30_0, iter_30_1 in ipairs(arg_29_1.choices_) do
				SetActive(iter_30_1.go, iter_30_0 <= 2)
			end

			arg_29_1.choices_[1].txt.text = arg_29_1:FormatText(StoryChoiceCfg[979].name)
			arg_29_1.choices_[2].txt.text = arg_29_1:FormatText(StoryChoiceCfg[980].name)
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1108106008(arg_29_1)
			end

			if arg_31_0 == 2 then
				arg_29_0:Play1108106009(arg_29_1)
			end

			arg_29_1:RecordChoiceLog(1108106007, 979, 980)
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1081ui_story"]) and arg_29_1.var_.characterEffect1081ui_story == nil then
				arg_29_1.var_.characterEffect1081ui_story = arg_29_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1081ui_story"]) then
				if arg_29_1.var_.characterEffect1081ui_story and not isNil(arg_29_1.actors_["1081ui_story"]) then
					arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1081ui_story"]) and arg_29_1.var_.characterEffect1081ui_story then
				arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1108106008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108106008
		arg_33_1.duration_ = 10.3

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1108106010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_36_0 = arg_33_1.actors_["1081ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1081ui_story == nil then
				arg_33_1.var_.characterEffect1081ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_1 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(var_36_0) then
				if arg_33_1.var_.characterEffect1081ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1081ui_story then
				arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_36_3 = 0
			local var_36_4 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(1108106008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 31 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 31)

				if (31 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 31)) > 0 and var_36_4 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb") / 1000

					if var_36_9 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_3
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")

						arg_33_1:RecordAudio("1108106008", var_36_10)
						arg_33_1:RecordAudio("1108106008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_11 and arg_33_1.time_ < var_36_3 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1108106010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108106010
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108106011(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1081ui_story"]) and arg_37_1.var_.characterEffect1081ui_story == nil then
				arg_37_1.var_.characterEffect1081ui_story = arg_37_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1081ui_story"]) then
				if arg_37_1.var_.characterEffect1081ui_story and not isNil(arg_37_1.actors_["1081ui_story"]) then
					arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1081ui_story"]) and arg_37_1.var_.characterEffect1081ui_story then
				arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_40_1 = 0
			local var_40_2 = 1.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1108106010).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 47 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 47)

				if (47 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 47)) > 0 and var_40_2 < var_40_5 then
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
	Play1108106011 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108106011
		arg_41_1.duration_ = 2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1108106012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1081ui_story"]) and arg_41_1.var_.characterEffect1081ui_story == nil then
				arg_41_1.var_.characterEffect1081ui_story = arg_41_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1081ui_story"]) then
				if arg_41_1.var_.characterEffect1081ui_story and not isNil(arg_41_1.actors_["1081ui_story"]) then
					arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1081ui_story"]) and arg_41_1.var_.characterEffect1081ui_story then
				arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.2

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(1108106011)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 8 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 8)

				if (8 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 8)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")

						arg_41_1:RecordAudio("1108106011", var_44_9)
						arg_41_1:RecordAudio("1108106011", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1108106012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108106012
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108106013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1081ui_story"]) and arg_45_1.var_.characterEffect1081ui_story == nil then
				arg_45_1.var_.characterEffect1081ui_story = arg_45_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.0666666666666667

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1081ui_story"]) then
				if arg_45_1.var_.characterEffect1081ui_story and not isNil(arg_45_1.actors_["1081ui_story"]) then
					arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1081ui_story"]) and arg_45_1.var_.characterEffect1081ui_story then
				arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.875

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1108106012).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 35 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 35)

				if (35 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 35)) > 0 and var_48_2 < var_48_5 then
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
	Play1108106013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108106013
		arg_49_1.duration_ = 4.53

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108106014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_0 = arg_49_1.actors_["1081ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1081ui_story == nil then
				arg_49_1.var_.characterEffect1081ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect1081ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1081ui_story then
				arg_49_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_52_3 = 0
			local var_52_4 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(1108106013)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 18 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 18)

				if (18 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 18)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")

						arg_49_1:RecordAudio("1108106013", var_52_10)
						arg_49_1:RecordAudio("1108106013", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1108106014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108106014
		arg_53_1.duration_ = 5.57

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1108106015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(1108106014)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)

				if (25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")

						arg_53_1:RecordAudio("1108106014", var_56_6)
						arg_53_1:RecordAudio("1108106014", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1108106015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108106015
		arg_57_1.duration_ = 6.5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1108106016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_0 = 0
			local var_60_1 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(1108106015)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 23 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 23)

				if (23 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 23)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")

						arg_57_1:RecordAudio("1108106015", var_60_7)
						arg_57_1:RecordAudio("1108106015", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1108106016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108106016
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"

			SetActive(arg_61_1.choicesGo_, true)

			for iter_62_0, iter_62_1 in ipairs(arg_61_1.choices_) do
				SetActive(iter_62_1.go, iter_62_0 <= 1)
			end

			arg_61_1.choices_[1].txt.text = arg_61_1:FormatText(StoryChoiceCfg[981].name)
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108106017(arg_61_1)
			end

			arg_61_1:RecordChoiceLog(1108106016, 981)
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1081ui_story"]) and arg_61_1.var_.characterEffect1081ui_story == nil then
				arg_61_1.var_.characterEffect1081ui_story = arg_61_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1081ui_story"]) then
				if arg_61_1.var_.characterEffect1081ui_story and not isNil(arg_61_1.actors_["1081ui_story"]) then
					arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1081ui_story"]) and arg_61_1.var_.characterEffect1081ui_story then
				arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1108106017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108106017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1108106018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1108106017).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 13)) > 0 and var_68_0 < var_68_3 then
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
	Play1108106018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108106018
		arg_69_1.duration_ = 4.8

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1108106019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_72_0 = arg_69_1.actors_["1081ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1081ui_story == nil then
				arg_69_1.var_.characterEffect1081ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_1 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 and not isNil(var_72_0) then
				if arg_69_1.var_.characterEffect1081ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1081ui_story then
				arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_3 = 1
			local var_72_4 = 0.525

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_5 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_5:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1108106018)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 21 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_7) / 21)

				if (21 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_7) / 21)) > 0 and var_72_4 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9
					var_72_3 = var_72_3 + 0.3

					if var_72_9 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb") / 1000

					if var_72_10 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_3
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")

						arg_69_1:RecordAudio("1108106018", var_72_11)
						arg_69_1:RecordAudio("1108106018", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = var_72_3 + 0.3
			local var_72_13 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1108106019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1108106019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1108106020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1081ui_story"]) and arg_75_1.var_.characterEffect1081ui_story == nil then
				arg_75_1.var_.characterEffect1081ui_story = arg_75_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.0166666666666667

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1081ui_story"]) then
				if arg_75_1.var_.characterEffect1081ui_story and not isNil(arg_75_1.actors_["1081ui_story"]) then
					arg_75_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1081ui_story"]) and arg_75_1.var_.characterEffect1081ui_story then
				arg_75_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.35

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1108106019).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 54 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 54)

				if (54 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 54)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1108106020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1108106020
		arg_79_1.duration_ = 10.8

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1108106021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_0 = arg_79_1.actors_["1081ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1081ui_story == nil then
				arg_79_1.var_.characterEffect1081ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect1081ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1081ui_story then
				arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_82_3 = 0
			local var_82_4 = 0.9

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:GetWordFromCfg(1108106020)
				local var_82_6 = arg_79_1:FormatText(var_82_5.content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 36 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 36)

				if (36 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 36)) > 0 and var_82_4 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb") / 1000

					if var_82_9 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_3
					end

					if var_82_5.prefab_name ~= "" and arg_79_1.actors_[var_82_5.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_5.prefab_name].transform, "story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")

						arg_79_1:RecordAudio("1108106020", var_82_10)
						arg_79_1:RecordAudio("1108106020", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_11 and arg_79_1.time_ < var_82_3 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1108106021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1108106021
		arg_83_1.duration_ = 5.13

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1108106022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_86_0 = 0
			local var_86_1 = 0.425

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(1108106021)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 17 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 17)

				if (17 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 17)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")

						arg_83_1:RecordAudio("1108106021", var_86_7)
						arg_83_1:RecordAudio("1108106021", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1108106022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1108106022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1108106023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081ui_story = arg_87_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).z)
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles = arg_87_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1081ui_story"].transform.position).z)
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1081ui_story"].transform.localEulerAngles = arg_87_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 1.075

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1108106022).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 43 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 43)

				if (43 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 43)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play1108106023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1108106023
		arg_91_1.duration_ = 5.23

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1108106024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.075

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(1108106023)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 13 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 13)

				if (13 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 13)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")

						arg_91_1:RecordAudio("1108106023", var_94_6)
						arg_91_1:RecordAudio("1108106023", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1108106024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1108106024
		arg_95_1.duration_ = 1

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"

			SetActive(arg_95_1.choicesGo_, true)

			for iter_96_0, iter_96_1 in ipairs(arg_95_1.choices_) do
				SetActive(iter_96_1.go, iter_96_0 <= 1)
			end

			arg_95_1.choices_[1].txt.text = arg_95_1:FormatText(StoryChoiceCfg[982].name)
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1108106025(arg_95_1)
			end

			arg_95_1:RecordChoiceLog(1108106024, 982)
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			return
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1108106025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1108106025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1108106026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1108106025).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 64 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 64)

				if (64 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 64)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1108106026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1108106026
		arg_103_1.duration_ = 9

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1108106027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 4 < arg_103_1.time_ and arg_103_1.time_ <= 4 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= 4 + 0.5 and arg_103_1.time_ < 4 + 0.5 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_0 = "ST0401"

			if arg_103_1.bgs_.ST0401 == nil then
				local var_106_1 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_106_0)
				var_106_1.name = var_106_0
				var_106_1.transform.parent = arg_103_1.stage_.transform
				var_106_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_[var_106_0] = var_106_1
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_2 = arg_103_1.bgs_.ST0401

				arg_103_1.bgs_.ST0401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_3 = var_106_2:GetComponent("SpriteRenderer")

				if var_106_3 and var_106_3.sprite then
					local var_106_4 = 2 * (var_106_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_2.transform.localScale = Vector3.New(var_106_4 / var_106_3.sprite.bounds.size.y < var_106_4 * manager.ui.mainCameraCom_.aspect / var_106_3.sprite.bounds.size.x and var_106_4 * manager.ui.mainCameraCom_.aspect / var_106_3.sprite.bounds.size.x or var_106_4 / var_106_3.sprite.bounds.size.y, var_106_4 / var_106_3.sprite.bounds.size.y < var_106_4 * manager.ui.mainCameraCom_.aspect / var_106_3.sprite.bounds.size.x and var_106_4 * manager.ui.mainCameraCom_.aspect / var_106_3.sprite.bounds.size.x or var_106_4 / var_106_3.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "ST0401" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_5 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_6 = 2

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = Color.New(1, 1, 1)

				var_106_7.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_5) / var_106_6)
				arg_103_1.mask_.color = var_106_7
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				local var_106_8 = Color.New(1, 1, 1)

				var_106_8.a = 1
				arg_103_1.mask_.color = var_106_8
			end

			local var_106_9 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_10 = 2

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 then
				local var_106_11 = Color.New(1, 1, 1)

				var_106_11.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_9) / var_106_10)
				arg_103_1.mask_.color = var_106_11
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 then
				local var_106_12 = Color.New(1, 1, 1)

				arg_103_1.mask_.enabled = false
				var_106_12.a = 0
				arg_103_1.mask_.color = var_106_12
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_14 = 4
			local var_106_15 = 1.3

			if 4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_16 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_16:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_17 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1108106026).content)

				arg_103_1.text_.text = var_106_17

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_19 = 52 <= 0 and var_106_15 or var_106_15 * (utf8.len(var_106_17) / 52)

				if (52 <= 0 and var_106_15 or var_106_15 * (utf8.len(var_106_17) / 52)) > 0 and var_106_15 < var_106_19 then
					arg_103_1.talkMaxDuration = var_106_19
					var_106_14 = var_106_14 + 0.3

					if var_106_19 + var_106_14 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_14
					end
				end

				arg_103_1.text_.text = var_106_17
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_20 = var_106_14 + 0.3
			local var_106_21 = math.max(var_106_15, arg_103_1.talkMaxDuration)

			if var_106_14 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_20 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_20) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_20 + var_106_21 and arg_103_1.time_ < var_106_20 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1108106027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108106027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108106028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			if arg_109_1.time_ >= 0 + 0.5 and arg_109_1.time_ < 0 + 0.5 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_0 = 0
			local var_112_1 = 1.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1108106027).content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 57 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_2) / 57)

				if (57 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_2) / 57)) > 0 and var_112_1 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_5 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_5 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_5

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_5 and arg_109_1.time_ < var_112_0 + var_112_5 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1108106028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108106028
		arg_113_1.duration_ = 1

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"

			SetActive(arg_113_1.choicesGo_, true)

			for iter_114_0, iter_114_1 in ipairs(arg_113_1.choices_) do
				SetActive(iter_114_1.go, iter_114_0 <= 1)
			end

			arg_113_1.choices_[1].txt.text = arg_113_1:FormatText(StoryChoiceCfg[983].name)
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1108106029(arg_113_1)
			end

			arg_113_1:RecordChoiceLog(1108106028, 983)
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= 0 + 0.5 and arg_113_1.time_ < 0 + 0.5 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1108106029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108106029
		arg_117_1.duration_ = 6.5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1108106030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_120_0 = arg_117_1.actors_["1081ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1081ui_story == nil then
				arg_117_1.var_.characterEffect1081ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_1 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 and not isNil(var_120_0) then
				if arg_117_1.var_.characterEffect1081ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1081ui_story then
				arg_117_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_120_3 = arg_117_1.actors_["1081ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1081ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = 0
			local var_120_6 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(1108106029)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 23 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 23)

				if (23 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 23)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")

						arg_117_1:RecordAudio("1108106029", var_120_12)
						arg_117_1:RecordAudio("1108106029", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108106030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108106030
		arg_121_1.duration_ = 3.8

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108106031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_0 = 0.666666666666667
			local var_124_1 = 0.15

			if 0.666666666666667 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_2 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_2:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(1108106030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 6 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_4) / 6)

				if (6 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_4) / 6)) > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6
					var_124_0 = var_124_0 + 0.3

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb") / 1000

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")

						arg_121_1:RecordAudio("1108106030", var_124_8)
						arg_121_1:RecordAudio("1108106030", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = var_124_0 + 0.3
			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1108106031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1108106031
		arg_127_1.duration_ = 4.2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1108106032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(1108106031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)

				if (19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")

						arg_127_1:RecordAudio("1108106031", var_130_6)
						arg_127_1:RecordAudio("1108106031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1108106032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1108106032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1108106033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1081ui_story = arg_131_1.actors_["1081ui_story"].transform.localPosition

				arg_131_1:ShowWeapon(arg_131_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).z)
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles = arg_131_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1081ui_story"].transform.position).z)
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1081ui_story"].transform.localEulerAngles = arg_131_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_134_1 = 0
			local var_134_2 = 1.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1108106032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 45 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 45)

				if (45 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 45)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1108106033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1108106033
		arg_135_1.duration_ = 5.1

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1108106034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) and arg_135_1.var_.characterEffect1081ui_story == nil then
				arg_135_1.var_.characterEffect1081ui_story = arg_135_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) then
				if arg_135_1.var_.characterEffect1081ui_story and not isNil(arg_135_1.actors_["1081ui_story"]) then
					arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1081ui_story"]) and arg_135_1.var_.characterEffect1081ui_story then
				arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_138_2 = arg_135_1.actors_["1081ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1081ui_story = var_138_2.localPosition

				arg_135_1:ShowWeapon(arg_135_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_138_3 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_135_1.time_ - 0) / var_138_3)
				var_138_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_2.position).x, (manager.ui.mainCamera.transform.position - var_138_2.position).y, (manager.ui.mainCamera.transform.position - var_138_2.position).z)
				var_138_2.localEulerAngles.z = 0
				var_138_2.localEulerAngles.x = 0
				var_138_2.localEulerAngles = var_138_2.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(0, -0.92, -5.8)
				var_138_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_2.position).x, (manager.ui.mainCamera.transform.position - var_138_2.position).y, (manager.ui.mainCamera.transform.position - var_138_2.position).z)
				var_138_2.localEulerAngles.z = 0
				var_138_2.localEulerAngles.x = 0
				var_138_2.localEulerAngles = var_138_2.localEulerAngles
			end

			local var_138_4 = 0
			local var_138_5 = 0.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(1108106033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 20 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 20)

				if (20 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 20)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")

						arg_135_1:RecordAudio("1108106033", var_138_11)
						arg_135_1:RecordAudio("1108106033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play1108106034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1108106034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1108106035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) and arg_139_1.var_.characterEffect1081ui_story == nil then
				arg_139_1.var_.characterEffect1081ui_story = arg_139_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) then
				if arg_139_1.var_.characterEffect1081ui_story and not isNil(arg_139_1.actors_["1081ui_story"]) then
					arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1081ui_story"]) and arg_139_1.var_.characterEffect1081ui_story then
				arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.55

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1108106034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 22 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 22)

				if (22 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 22)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1108106035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108106035
		arg_143_1.duration_ = 3

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1108106036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) and arg_143_1.var_.characterEffect1081ui_story == nil then
				arg_143_1.var_.characterEffect1081ui_story = arg_143_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) then
				if arg_143_1.var_.characterEffect1081ui_story and not isNil(arg_143_1.actors_["1081ui_story"]) then
					arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1081ui_story"]) and arg_143_1.var_.characterEffect1081ui_story then
				arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_2 = 0
			local var_146_3 = 0.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1108106035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 15 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 15)

				if (15 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 15)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")

						arg_143_1:RecordAudio("1108106035", var_146_9)
						arg_143_1:RecordAudio("1108106035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1108106036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1108106036
		arg_147_1.duration_ = 6

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1108106037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0.999999998152256 < arg_147_1.time_ and arg_147_1.time_ <= 0.999999998152256 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= 0.999999998152256 + 0.3 and arg_147_1.time_ < 0.999999998152256 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			if 0.999999998152256 < arg_147_1.time_ and arg_147_1.time_ <= 0.999999998152256 + arg_150_0 then
				local var_150_0 = arg_147_1.bgs_.ST0401

				arg_147_1.bgs_.ST0401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_1 = var_150_0:GetComponent("SpriteRenderer")

				if var_150_1 and var_150_1.sprite then
					local var_150_2 = 2 * (var_150_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_0.transform.localScale = Vector3.New(var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST0401" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_3 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_4 = 1

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_4 then
				local var_150_5 = Color.New(0, 0, 0)

				var_150_5.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_3) / var_150_4)
				arg_147_1.mask_.color = var_150_5
			end

			if arg_147_1.time_ >= var_150_3 + var_150_4 and arg_147_1.time_ < var_150_3 + var_150_4 + arg_150_0 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = 1
				arg_147_1.mask_.color = var_150_6
			end

			local var_150_7 = 1

			if 1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_8 = 1

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 then
				local var_150_9 = Color.New(0, 0, 0)

				var_150_9.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_7) / var_150_8)
				arg_147_1.mask_.color = var_150_9
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 then
				local var_150_10 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_10.a = 0
				arg_147_1.mask_.color = var_150_10
			end

			local var_150_11 = arg_147_1.actors_["1081ui_story"].transform

			if 0.983333331485589 < arg_147_1.time_ and arg_147_1.time_ <= 0.983333331485589 + arg_150_0 then
				arg_147_1.var_.moveOldPos1081ui_story = var_150_11.localPosition
			end

			local var_150_12 = 0.001

			if 0.983333331485589 <= arg_147_1.time_ and arg_147_1.time_ < 0.983333331485589 + var_150_12 then
				var_150_11.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0.983333331485589) / var_150_12)
				var_150_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_11.position).x, (manager.ui.mainCamera.transform.position - var_150_11.position).y, (manager.ui.mainCamera.transform.position - var_150_11.position).z)
				var_150_11.localEulerAngles.z = 0
				var_150_11.localEulerAngles.x = 0
				var_150_11.localEulerAngles = var_150_11.localEulerAngles
			end

			if arg_147_1.time_ >= 0.983333331485589 + var_150_12 and arg_147_1.time_ < 0.983333331485589 + var_150_12 + arg_150_0 then
				var_150_11.localPosition = Vector3.New(0, 100, 0)
				var_150_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_11.position).x, (manager.ui.mainCamera.transform.position - var_150_11.position).y, (manager.ui.mainCamera.transform.position - var_150_11.position).z)
				var_150_11.localEulerAngles.z = 0
				var_150_11.localEulerAngles.x = 0
				var_150_11.localEulerAngles = var_150_11.localEulerAngles
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_13 = 0.999999998152256
			local var_150_14 = 1.425

			if 0.999999998152256 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_15 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_15:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_16 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1108106036).content)

				arg_147_1.text_.text = var_150_16

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_18 = 57 <= 0 and var_150_14 or var_150_14 * (utf8.len(var_150_16) / 57)

				if (57 <= 0 and var_150_14 or var_150_14 * (utf8.len(var_150_16) / 57)) > 0 and var_150_14 < var_150_18 then
					arg_147_1.talkMaxDuration = var_150_18
					var_150_13 = var_150_13 + 0.3

					if var_150_18 + var_150_13 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_13
					end
				end

				arg_147_1.text_.text = var_150_16
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_19 = var_150_13 + 0.3
			local var_150_20 = math.max(var_150_14, arg_147_1.talkMaxDuration)

			if var_150_13 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_19 + var_150_20 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_19) / var_150_20

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_19 + var_150_20 and arg_147_1.time_ < var_150_19 + var_150_20 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.983333331485589,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1108106037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108106037
		arg_153_1.duration_ = 3.93

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1108106038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1081ui_story = arg_153_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1081ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story == nil then
				arg_153_1.var_.characterEffect1081ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1081ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story then
				arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.725

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(1108106037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 21 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 21)

				if (21 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 21)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")

						arg_153_1:RecordAudio("1108106037", var_156_11)
						arg_153_1:RecordAudio("1108106037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")
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

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1108106038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108106038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1108106039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1081ui_story"]) and arg_157_1.var_.characterEffect1081ui_story == nil then
				arg_157_1.var_.characterEffect1081ui_story = arg_157_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1081ui_story"]) then
				if arg_157_1.var_.characterEffect1081ui_story and not isNil(arg_157_1.actors_["1081ui_story"]) then
					arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1081ui_story"]) and arg_157_1.var_.characterEffect1081ui_story then
				arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
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

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1108106038).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 10 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 10)

				if (10 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 10)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1108106039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108106039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1108106040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1081ui_story = arg_161_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1081ui_story"].transform.position).z)
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1081ui_story"].transform.localEulerAngles = arg_161_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_164_1 = 0
			local var_164_2 = 1.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1108106039).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 52 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 52)

				if (52 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 52)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108106040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108106040
		arg_165_1.duration_ = 2.4

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1108106041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1081ui_story = arg_165_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).z)
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles = arg_165_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).z)
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles = arg_165_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_168_1 = 0
			local var_168_2 = 0.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(1108106040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 6 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_4) / 6)

				if (6 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_4) / 6)) > 0 and var_168_2 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb") ~= 0 then
					local var_168_7 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb") / 1000

					if var_168_7 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_1
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")

						arg_165_1:RecordAudio("1108106040", var_168_8)
						arg_165_1:RecordAudio("1108106040", var_168_8)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_9 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_9 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_9

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_9 and arg_165_1.time_ < var_168_1 + var_168_9 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108106041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108106041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1108106042(arg_169_1)
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

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1108106041).content)

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
	Play1108106042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108106042
		arg_173_1.duration_ = 1

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				SetActive(iter_174_1.go, iter_174_0 <= 1)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[984].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108106043(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(1108106042, 984)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= 0 + 0.5 and arg_173_1.time_ < 0 + 0.5 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108106043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108106043
		arg_177_1.duration_ = 2.13

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1108106044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_180_0 = 0.466666666666667

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				local var_180_1, var_180_2 = math.modf((arg_177_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_180_2 * 0.13, var_180_2 * 0.13, var_180_2 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				manager.ui.mainCamera.transform.localPosition = arg_177_1.var_.shakeOldPos
			end

			local var_180_3 = 0
			local var_180_4 = 0.05

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_5 = arg_177_1:GetWordFromCfg(1108106043)
				local var_180_6 = arg_177_1:FormatText(var_180_5.content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_8 = 2 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 2)

				if (2 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 2)) > 0 and var_180_4 < var_180_8 then
					arg_177_1.talkMaxDuration = var_180_8

					if var_180_8 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_3
					end
				end

				arg_177_1.text_.text = var_180_6
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb") ~= 0 then
					local var_180_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb") / 1000

					if var_180_9 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_3
					end

					if var_180_5.prefab_name ~= "" and arg_177_1.actors_[var_180_5.prefab_name] ~= nil then
						local var_180_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_5.prefab_name].transform, "story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")

						arg_177_1:RecordAudio("1108106043", var_180_10)
						arg_177_1:RecordAudio("1108106043", var_180_10)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_4, arg_177_1.talkMaxDuration)

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_3) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_3 + var_180_11 and arg_177_1.time_ < var_180_3 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1108106044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108106044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1108106045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.375

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1108106044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 55 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 55)

				if (55 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 55)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108106045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108106045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1108106046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.225

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1108106045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 49 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 49)

				if (49 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 49)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108106046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108106046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108106047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= 0 + 0.5 and arg_189_1.time_ < 0 + 0.5 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_0 = 0
			local var_192_1 = 0.75

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1108106046).content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 30 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 30)

				if (30 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 30)) > 0 and var_192_1 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_5 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_5 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_5

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_5 and arg_189_1.time_ < var_192_0 + var_192_5 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1108106047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108106047
		arg_193_1.duration_ = 7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1108106048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= 2 + 0.3 and arg_193_1.time_ < 2 + 0.3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_0 = "ST10"

			if arg_193_1.bgs_.ST10 == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				local var_196_2 = arg_193_1.bgs_.ST10

				arg_193_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_3 = var_196_2:GetComponent("SpriteRenderer")

				if var_196_3 and var_196_3.sprite then
					local var_196_4 = 2 * (var_196_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_2.transform.localScale = Vector3.New(var_196_4 / var_196_3.sprite.bounds.size.y < var_196_4 * manager.ui.mainCameraCom_.aspect / var_196_3.sprite.bounds.size.x and var_196_4 * manager.ui.mainCameraCom_.aspect / var_196_3.sprite.bounds.size.x or var_196_4 / var_196_3.sprite.bounds.size.y, var_196_4 / var_196_3.sprite.bounds.size.y < var_196_4 * manager.ui.mainCameraCom_.aspect / var_196_3.sprite.bounds.size.x and var_196_4 * manager.ui.mainCameraCom_.aspect / var_196_3.sprite.bounds.size.x or var_196_4 / var_196_3.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST10" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_5 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_6 = 1

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_6 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_5) / var_196_6)
				arg_193_1.mask_.color = var_196_7
			end

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 then
				local var_196_8 = Color.New(0, 0, 0)

				var_196_8.a = 1
				arg_193_1.mask_.color = var_196_8
			end

			local var_196_9 = 1

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_10 = 1

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 then
				local var_196_11 = Color.New(0, 0, 0)

				var_196_11.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_9) / var_196_10)
				arg_193_1.mask_.color = var_196_11
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 then
				local var_196_12 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_12.a = 0
				arg_193_1.mask_.color = var_196_12
			end

			if 1.01666666666667 < arg_193_1.time_ and arg_193_1.time_ <= 1.01666666666667 + arg_196_0 then
				arg_193_1:AudioAction("stop", "music", "se_story_133", "se_story_133_sea", "")

				local var_196_15 = manager.audio:GetAudioName("se_story_133", "se_story_133_sea")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_15 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_15

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_15
						arg_193_1.bgmTxt2_.text = var_196_15
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_16 = 1

			arg_193_1.isInRecall_ = false

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.screenFilterGo_:SetActive(true)

				arg_193_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_196_2, iter_196_3 in pairs(arg_193_1.actors_) do
					for iter_196_4, iter_196_5 in ipairs((iter_196_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_196_5.color = iter_196_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_196_17 = 0.0166666666666667

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				arg_193_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_16) / var_196_17)
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				arg_193_1.screenFilterEffect_.weight = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_18 = 2
			local var_196_19 = 1.1

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_18 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_20 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_20:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_193_1.dialogCg_.alpha = arg_198_0
				end))
				var_196_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_21 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1108106047).content)

				arg_193_1.text_.text = var_196_21

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_23 = 19 <= 0 and var_196_19 or var_196_19 * (utf8.len(var_196_21) / 19)

				if (19 <= 0 and var_196_19 or var_196_19 * (utf8.len(var_196_21) / 19)) > 0 and var_196_19 < var_196_23 then
					arg_193_1.talkMaxDuration = var_196_23
					var_196_18 = var_196_18 + 0.3

					if var_196_23 + var_196_18 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_18
					end
				end

				arg_193_1.text_.text = var_196_21
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_24 = var_196_18 + 0.3
			local var_196_25 = math.max(var_196_19, arg_193_1.talkMaxDuration)

			if var_196_18 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_24 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_24) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_24 + var_196_25 and arg_193_1.time_ < var_196_24 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1108106048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108106048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108106049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1108106048).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 16 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 16)

				if (16 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 16)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1108106049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108106049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108106050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.5

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(1108106049).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 20 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 20)

				if (20 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 20)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1108106050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108106050
		arg_208_1.duration_ = 7

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108106051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 2 < arg_208_1.time_ and arg_208_1.time_ <= 2 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= 2 + 1 and arg_208_1.time_ < 2 + 1 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if 1 < arg_208_1.time_ and arg_208_1.time_ <= 1 + arg_211_0 then
				local var_211_0 = arg_208_1.bgs_.ST0401

				arg_208_1.bgs_.ST0401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_211_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_1 = var_211_0:GetComponent("SpriteRenderer")

				if var_211_1 and var_211_1.sprite then
					local var_211_2 = 2 * (var_211_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_211_0.transform.localScale = Vector3.New(var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST0401" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_3 = 1

			arg_208_1.isInRecall_ = false

			if var_211_3 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.screenFilterGo_:SetActive(false)

				for iter_211_2, iter_211_3 in pairs(arg_208_1.actors_) do
					for iter_211_4, iter_211_5 in ipairs((iter_211_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_211_5.color = iter_211_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_211_4 = 0.0166666666666667

			if var_211_3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_3 + var_211_4 then
				arg_208_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_3) / var_211_4)
			end

			if arg_208_1.time_ >= var_211_3 + var_211_4 and arg_208_1.time_ < var_211_3 + var_211_4 + arg_211_0 then
				arg_208_1.screenFilterEffect_.weight = 0
			end

			local var_211_5 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_6 = 1

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 then
				local var_211_7 = Color.New(0, 0, 0)

				var_211_7.a = Mathf.Lerp(0, 1, (arg_208_1.time_ - var_211_5) / var_211_6)
				arg_208_1.mask_.color = var_211_7
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 then
				local var_211_8 = Color.New(0, 0, 0)

				var_211_8.a = 1
				arg_208_1.mask_.color = var_211_8
			end

			local var_211_9 = 1

			if 1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_10 = 1

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_10 then
				local var_211_11 = Color.New(0, 0, 0)

				var_211_11.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_9) / var_211_10)
				arg_208_1.mask_.color = var_211_11
			end

			if arg_208_1.time_ >= var_211_9 + var_211_10 and arg_208_1.time_ < var_211_9 + var_211_10 + arg_211_0 then
				local var_211_12 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_12.a = 0
				arg_208_1.mask_.color = var_211_12
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			local var_211_14 = 0.983333333333333

			arg_208_1.isInRecall_ = false

			if var_211_14 < arg_208_1.time_ and arg_208_1.time_ <= var_211_14 + arg_211_0 then
				arg_208_1.screenFilterGo_:SetActive(false)

				for iter_211_6, iter_211_7 in pairs(arg_208_1.actors_) do
					for iter_211_8, iter_211_9 in ipairs((iter_211_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_211_9.color = iter_211_9.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_211_15 = 0.0166666666666667

			if var_211_14 <= arg_208_1.time_ and arg_208_1.time_ < var_211_14 + var_211_15 then
				arg_208_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_14) / var_211_15)
			end

			if arg_208_1.time_ >= var_211_14 + var_211_15 and arg_208_1.time_ < var_211_14 + var_211_15 + arg_211_0 then
				arg_208_1.screenFilterEffect_.weight = 0
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_16 = 2
			local var_211_17 = 1.4

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_18 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_18:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_19 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(1108106050).content)

				arg_208_1.text_.text = var_211_19

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_21 = 56 <= 0 and var_211_17 or var_211_17 * (utf8.len(var_211_19) / 56)

				if (56 <= 0 and var_211_17 or var_211_17 * (utf8.len(var_211_19) / 56)) > 0 and var_211_17 < var_211_21 then
					arg_208_1.talkMaxDuration = var_211_21
					var_211_16 = var_211_16 + 0.3

					if var_211_21 + var_211_16 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_21 + var_211_16
					end
				end

				arg_208_1.text_.text = var_211_19
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = var_211_16 + 0.3
			local var_211_23 = math.max(var_211_17, arg_208_1.talkMaxDuration)

			if var_211_16 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_22 + var_211_23 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_22) / var_211_23

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_22 + var_211_23 and arg_208_1.time_ < var_211_22 + var_211_23 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108106051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1108106051
		arg_214_1.duration_ = 1.47

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1108106052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_217_1 = 0
			local var_217_2 = 0.15

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(1108106051)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 6 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 6)

				if (6 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 6)) > 0 and var_217_2 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb") ~= 0 then
					local var_217_7 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb") / 1000

					if var_217_7 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_1
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")

						arg_214_1:RecordAudio("1108106051", var_217_8)
						arg_214_1:RecordAudio("1108106051", var_217_8)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_9 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_9

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_9 and arg_214_1.time_ < var_217_1 + var_217_9 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1108106052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1108106052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1108106053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.85

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1108106052).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 34 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 34)

				if (34 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 34)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1108106053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108106053
		arg_222_1.duration_ = 4.52

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108106054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 1.75 < arg_222_1.time_ and arg_222_1.time_ <= 1.75 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= 1.75 + 0.0833333333333335 and arg_222_1.time_ < 1.75 + 0.0833333333333335 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_0 = "STblack"

			if arg_222_1.bgs_.STblack == nil then
				local var_225_1 = Object.Instantiate(arg_222_1.paintGo_)

				var_225_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_225_0)
				var_225_1.name = var_225_0
				var_225_1.transform.parent = arg_222_1.stage_.transform
				var_225_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.bgs_[var_225_0] = var_225_1
			end

			if 1 < arg_222_1.time_ and arg_222_1.time_ <= 1 + arg_225_0 then
				local var_225_2 = arg_222_1.bgs_.STblack

				arg_222_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_225_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_3 = var_225_2:GetComponent("SpriteRenderer")

				if var_225_3 and var_225_3.sprite then
					local var_225_4 = 2 * (var_225_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_225_2.transform.localScale = Vector3.New(var_225_4 / var_225_3.sprite.bounds.size.y < var_225_4 * manager.ui.mainCameraCom_.aspect / var_225_3.sprite.bounds.size.x and var_225_4 * manager.ui.mainCameraCom_.aspect / var_225_3.sprite.bounds.size.x or var_225_4 / var_225_3.sprite.bounds.size.y, var_225_4 / var_225_3.sprite.bounds.size.y < var_225_4 * manager.ui.mainCameraCom_.aspect / var_225_3.sprite.bounds.size.x and var_225_4 * manager.ui.mainCameraCom_.aspect / var_225_3.sprite.bounds.size.x or var_225_4 / var_225_3.sprite.bounds.size.y, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "STblack" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_5 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_6 = 1

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_6 then
				local var_225_7 = Color.New(0, 0, 0)

				var_225_7.a = Mathf.Lerp(0, 1, (arg_222_1.time_ - var_225_5) / var_225_6)
				arg_222_1.mask_.color = var_225_7
			end

			if arg_222_1.time_ >= var_225_5 + var_225_6 and arg_222_1.time_ < var_225_5 + var_225_6 + arg_225_0 then
				local var_225_8 = Color.New(0, 0, 0)

				var_225_8.a = 1
				arg_222_1.mask_.color = var_225_8
			end

			local var_225_9 = 1

			if 1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_10 = 1

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 then
				local var_225_11 = Color.New(0, 0, 0)

				var_225_11.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - var_225_9) / var_225_10)
				arg_222_1.mask_.color = var_225_11
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 then
				local var_225_12 = Color.New(0, 0, 0)

				arg_222_1.mask_.enabled = false
				var_225_12.a = 0
				arg_222_1.mask_.color = var_225_12
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_13 = 1.75
			local var_225_14 = 0.25

			if 1.75 < arg_222_1.time_ and arg_222_1.time_ <= var_225_13 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_15 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_15:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_16 = arg_222_1:GetWordFromCfg(1108106053)
				local var_225_17 = arg_222_1:FormatText(var_225_16.content)

				arg_222_1.text_.text = var_225_17

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_19 = 10 <= 0 and var_225_14 or var_225_14 * (utf8.len(var_225_17) / 10)

				if (10 <= 0 and var_225_14 or var_225_14 * (utf8.len(var_225_17) / 10)) > 0 and var_225_14 < var_225_19 then
					arg_222_1.talkMaxDuration = var_225_19
					var_225_13 = var_225_13 + 0.3

					if var_225_19 + var_225_13 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_19 + var_225_13
					end
				end

				arg_222_1.text_.text = var_225_17
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb") ~= 0 then
					local var_225_20 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb") / 1000

					if var_225_20 + var_225_13 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_20 + var_225_13
					end

					if var_225_16.prefab_name ~= "" and arg_222_1.actors_[var_225_16.prefab_name] ~= nil then
						local var_225_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_16.prefab_name].transform, "story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")

						arg_222_1:RecordAudio("1108106053", var_225_21)
						arg_222_1:RecordAudio("1108106053", var_225_21)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = var_225_13 + 0.3
			local var_225_23 = math.max(var_225_14, arg_222_1.talkMaxDuration)

			if var_225_13 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_22 + var_225_23 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_22) / var_225_23

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_22 + var_225_23 and arg_222_1.time_ < var_225_22 + var_225_23 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108106054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1108106054
		arg_228_1.duration_ = 4.97

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1108106055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.45

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:GetWordFromCfg(1108106054)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 18)

				if (18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 18)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")

						arg_228_1:RecordAudio("1108106054", var_231_6)
						arg_228_1:RecordAudio("1108106054", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1108106055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1108106055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1108106056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_235_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_232_1.bgmTxt_.text ~= var_235_2 and arg_232_1.bgmTxt_.text ~= "" then
						if arg_232_1.bgmTxt2_.text ~= "" then
							arg_232_1.bgmTxt_.text = arg_232_1.bgmTxt2_.text
						end

						arg_232_1.bgmTxt2_.text = var_235_2

						arg_232_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_232_1.bgmTxt_.text = var_235_2
						arg_232_1.bgmTxt2_.text = var_235_2
					end

					if arg_232_1.bgmTimer then
						arg_232_1.bgmTimer:Stop()

						arg_232_1.bgmTimer = nil
					end

					if arg_232_1.settingData.show_music_name == 1 then
						arg_232_1.musicController:SetSelectedState("show")
						arg_232_1.musicAnimator_:Play("open", 0, 0)

						if arg_232_1.settingData.music_time ~= 0 then
							arg_232_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_232_1.settingData.music_time), function()
								if arg_232_1 == nil or isNil(arg_232_1.bgmTxt_) then
									return
								end

								arg_232_1.musicController:SetSelectedState("hide")
								arg_232_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_bubble", "")
			end

			if 0.425 < arg_232_1.time_ and arg_232_1.time_ <= 0.425 + arg_235_0 then
				arg_232_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			local var_235_5 = 0
			local var_235_6 = 0.575

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1108106055).content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 23 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_7) / 23)

				if (23 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_7) / 23)) > 0 and var_235_6 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_10 and arg_232_1.time_ < var_235_5 + var_235_10 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1108106056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108106056
		arg_237_1.duration_ = 1

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"

			SetActive(arg_237_1.choicesGo_, true)

			for iter_238_0, iter_238_1 in ipairs(arg_237_1.choices_) do
				SetActive(iter_238_1.go, iter_238_0 <= 1)
			end

			arg_237_1.choices_[1].txt.text = arg_237_1:FormatText(StoryChoiceCfg[985].name)
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108106057(arg_237_1)
			end

			arg_237_1:RecordChoiceLog(1108106056, 985)
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			return
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108106057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108106057
		arg_241_1.duration_ = 7.33

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1108106058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.4

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(1108106057)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 16 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 16)

				if (16 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 16)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")

						arg_241_1:RecordAudio("1108106057", var_244_6)
						arg_241_1:RecordAudio("1108106057", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1108106058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108106058
		arg_245_1.duration_ = 3.3

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108106059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.275

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(1108106058)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 11 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 11)

				if (11 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 11)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")

						arg_245_1:RecordAudio("1108106058", var_248_6)
						arg_245_1:RecordAudio("1108106058", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")
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
	Play1108106059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108106059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108106060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.125

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1108106059).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 5 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 5)

				if (5 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 5)) > 0 and var_252_0 < var_252_3 then
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
	Play1108106060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108106060
		arg_253_1.duration_ = 6.67

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1108106061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 1.66666666666667 < arg_253_1.time_ and arg_253_1.time_ <= 1.66666666666667 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= 1.66666666666667 + 0.3 and arg_253_1.time_ < 1.66666666666667 + 0.3 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_0 = "H01b"

			if arg_253_1.bgs_.H01b == nil then
				local var_256_1 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_256_0)
				var_256_1.name = var_256_0
				var_256_1.transform.parent = arg_253_1.stage_.transform
				var_256_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_[var_256_0] = var_256_1
			end

			if 1 < arg_253_1.time_ and arg_253_1.time_ <= 1 + arg_256_0 then
				local var_256_2 = arg_253_1.bgs_.H01b

				arg_253_1.bgs_.H01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_3 = var_256_2:GetComponent("SpriteRenderer")

				if var_256_3 and var_256_3.sprite then
					local var_256_4 = 2 * (var_256_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_2.transform.localScale = Vector3.New(var_256_4 / var_256_3.sprite.bounds.size.y < var_256_4 * manager.ui.mainCameraCom_.aspect / var_256_3.sprite.bounds.size.x and var_256_4 * manager.ui.mainCameraCom_.aspect / var_256_3.sprite.bounds.size.x or var_256_4 / var_256_3.sprite.bounds.size.y, var_256_4 / var_256_3.sprite.bounds.size.y < var_256_4 * manager.ui.mainCameraCom_.aspect / var_256_3.sprite.bounds.size.x and var_256_4 * manager.ui.mainCameraCom_.aspect / var_256_3.sprite.bounds.size.x or var_256_4 / var_256_3.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "H01b" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_5 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_6 = 1

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 then
				local var_256_7 = Color.New(0, 0, 0)

				var_256_7.a = Mathf.Lerp(0, 1, (arg_253_1.time_ - var_256_5) / var_256_6)
				arg_253_1.mask_.color = var_256_7
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 then
				local var_256_8 = Color.New(0, 0, 0)

				var_256_8.a = 1
				arg_253_1.mask_.color = var_256_8
			end

			local var_256_9 = 1

			if 1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_10 = 0.966666666666667

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 then
				local var_256_11 = Color.New(0, 0, 0)

				var_256_11.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_9) / var_256_10)
				arg_253_1.mask_.color = var_256_11
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 then
				local var_256_12 = Color.New(0, 0, 0)

				arg_253_1.mask_.enabled = false
				var_256_12.a = 0
				arg_253_1.mask_.color = var_256_12
			end

			local var_256_13 = arg_253_1.actors_["1081ui_story"].transform

			if 0.983333333333333 < arg_253_1.time_ and arg_253_1.time_ <= 0.983333333333333 + arg_256_0 then
				arg_253_1.var_.moveOldPos1081ui_story = var_256_13.localPosition
			end

			local var_256_14 = 0.001

			if 0.983333333333333 <= arg_253_1.time_ and arg_253_1.time_ < 0.983333333333333 + var_256_14 then
				var_256_13.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0.983333333333333) / var_256_14)
				var_256_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_13.position).x, (manager.ui.mainCamera.transform.position - var_256_13.position).y, (manager.ui.mainCamera.transform.position - var_256_13.position).z)
				var_256_13.localEulerAngles.z = 0
				var_256_13.localEulerAngles.x = 0
				var_256_13.localEulerAngles = var_256_13.localEulerAngles
			end

			if arg_253_1.time_ >= 0.983333333333333 + var_256_14 and arg_253_1.time_ < 0.983333333333333 + var_256_14 + arg_256_0 then
				var_256_13.localPosition = Vector3.New(0, 100, 0)
				var_256_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_13.position).x, (manager.ui.mainCamera.transform.position - var_256_13.position).y, (manager.ui.mainCamera.transform.position - var_256_13.position).z)
				var_256_13.localEulerAngles.z = 0
				var_256_13.localEulerAngles.x = 0
				var_256_13.localEulerAngles = var_256_13.localEulerAngles
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_256_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_17 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_17

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_17
						arg_253_1.bgmTxt2_.text = var_256_17
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_253_1.time_ and arg_253_1.time_ <= 0.3 + arg_256_0 then
				arg_253_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_256_20 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_20 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_20

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_20
						arg_253_1.bgmTxt2_.text = var_256_20
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_flame1", "")
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_22 = 1.66666666666667
			local var_256_23 = 1.65

			if 1.66666666666667 < arg_253_1.time_ and arg_253_1.time_ <= var_256_22 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_24 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_24:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_253_1.dialogCg_.alpha = arg_259_0
				end))
				var_256_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_25 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1108106060).content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_27 = 66 <= 0 and var_256_23 or var_256_23 * (utf8.len(var_256_25) / 66)

				if (66 <= 0 and var_256_23 or var_256_23 * (utf8.len(var_256_25) / 66)) > 0 and var_256_23 < var_256_27 then
					arg_253_1.talkMaxDuration = var_256_27
					var_256_22 = var_256_22 + 0.3

					if var_256_27 + var_256_22 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_27 + var_256_22
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_28 = var_256_22 + 0.3
			local var_256_29 = math.max(var_256_23, arg_253_1.talkMaxDuration)

			if var_256_22 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_28 + var_256_29 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_28) / var_256_29

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_28 + var_256_29 and arg_253_1.time_ < var_256_28 + var_256_29 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.983333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1108106061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108106061
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1108106062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.1

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1108106061).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 44 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 44)

				if (44 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 44)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1108106062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108106062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108106063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.275

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1108106062).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 51 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 51)

				if (51 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 51)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1108106063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108106063
		arg_269_1.duration_ = 5.57

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108106064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1081ui_story = arg_269_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1081ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story == nil then
				arg_269_1.var_.characterEffect1081ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1081ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story then
				arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.55

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(1108106063)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 22 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 22)

				if (22 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 22)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")

						arg_269_1:RecordAudio("1108106063", var_272_11)
						arg_269_1:RecordAudio("1108106063", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1108106064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108106064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108106065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) and arg_273_1.var_.characterEffect1081ui_story == nil then
				arg_273_1.var_.characterEffect1081ui_story = arg_273_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.0333333333333333

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) then
				if arg_273_1.var_.characterEffect1081ui_story and not isNil(arg_273_1.actors_["1081ui_story"]) then
					arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1081ui_story"]) and arg_273_1.var_.characterEffect1081ui_story then
				arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 1.2

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1108106064).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 48 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 48)

				if (48 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 48)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1108106065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108106065
		arg_277_1.duration_ = 4.8

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108106066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1081ui_story = arg_277_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).z)
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles = arg_277_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_277_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1081ui_story"].transform.position).z)
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1081ui_story"].transform.localEulerAngles = arg_277_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1081ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1081ui_story == nil then
				arg_277_1.var_.characterEffect1081ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1081ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1081ui_story then
				arg_277_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.55

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(1108106065)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 22 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 22)

				if (22 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 22)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")

						arg_277_1:RecordAudio("1108106065", var_280_11)
						arg_277_1:RecordAudio("1108106065", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108106066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1108106066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1108106067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) and arg_281_1.var_.characterEffect1081ui_story == nil then
				arg_281_1.var_.characterEffect1081ui_story = arg_281_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.0333333333333333

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) then
				if arg_281_1.var_.characterEffect1081ui_story and not isNil(arg_281_1.actors_["1081ui_story"]) then
					arg_281_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1081ui_story"]) and arg_281_1.var_.characterEffect1081ui_story then
				arg_281_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_284_1 = 0
			local var_284_2 = 0.1

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

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1108106066).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 4 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 4)

				if (4 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 4)) > 0 and var_284_2 < var_284_5 then
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
	Play1108106067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1108106067
		arg_285_1.duration_ = 4.83

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1108106068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_288_0 = arg_285_1.actors_["1081ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1081ui_story == nil then
				arg_285_1.var_.characterEffect1081ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_1 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 and not isNil(var_288_0) then
				if arg_285_1.var_.characterEffect1081ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1081ui_story then
				arg_285_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_288_3 = 0
			local var_288_4 = 0.55

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_5 = arg_285_1:GetWordFromCfg(1108106067)
				local var_288_6 = arg_285_1:FormatText(var_288_5.content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 22 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_6) / 22)

				if (22 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_6) / 22)) > 0 and var_288_4 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_3
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb") ~= 0 then
					local var_288_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb") / 1000

					if var_288_9 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_3
					end

					if var_288_5.prefab_name ~= "" and arg_285_1.actors_[var_288_5.prefab_name] ~= nil then
						local var_288_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_5.prefab_name].transform, "story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")

						arg_285_1:RecordAudio("1108106067", var_288_10)
						arg_285_1:RecordAudio("1108106067", var_288_10)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_11 = math.max(var_288_4, arg_285_1.talkMaxDuration)

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_11 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_3) / var_288_11

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_3 + var_288_11 and arg_285_1.time_ < var_288_3 + var_288_11 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1108106068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1108106068
		arg_289_1.duration_ = 1

		SetActive(arg_289_1.tipsGo_, true)

		arg_289_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"

			SetActive(arg_289_1.choicesGo_, true)

			for iter_290_0, iter_290_1 in ipairs(arg_289_1.choices_) do
				SetActive(iter_290_1.go, iter_290_0 <= 2)
			end

			arg_289_1.choices_[1].txt.text = arg_289_1:FormatText(StoryChoiceCfg[986].name)
			arg_289_1.choices_[2].txt.text = arg_289_1:FormatText(StoryChoiceCfg[987].name)
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1108106069(arg_289_1)
			end

			if arg_291_0 == 2 then
				PlayerAction.UseStoryTrigger(1081012, 210810106, 1108106068, 2)
				arg_289_0:Play1108106069(arg_289_1)
			end

			arg_289_1:RecordChoiceLog(1108106068, 986, 987)
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			return
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1108106069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108106069
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1108106070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1081ui_story"]) and arg_293_1.var_.characterEffect1081ui_story == nil then
				arg_293_1.var_.characterEffect1081ui_story = arg_293_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1081ui_story"]) then
				if arg_293_1.var_.characterEffect1081ui_story and not isNil(arg_293_1.actors_["1081ui_story"]) then
					arg_293_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1081ui_story"]) and arg_293_1.var_.characterEffect1081ui_story then
				arg_293_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.625

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1108106069).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 25 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 25)

				if (25 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 25)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1108106070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1108106070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1108106071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.475

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
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

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1108106070).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)

				if (19 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 19)) > 0 and var_300_0 < var_300_3 then
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
	Play1108106071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1108106071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1108106072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_304_0 = 0
			local var_304_1 = 0.525

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1108106071).content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 21 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_2) / 21)

				if (21 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_2) / 21)) > 0 and var_304_1 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_5 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_5 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_5

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_5 and arg_301_1.time_ < var_304_0 + var_304_5 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1108106072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1108106072
		arg_305_1.duration_ = 3.33

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1108106073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_308_0 = arg_305_1.actors_["1081ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1081ui_story == nil then
				arg_305_1.var_.characterEffect1081ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_1 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 and not isNil(var_308_0) then
				if arg_305_1.var_.characterEffect1081ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1081ui_story then
				arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_308_3 = 0
			local var_308_4 = 0.425

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:GetWordFromCfg(1108106072)
				local var_308_6 = arg_305_1:FormatText(var_308_5.content)

				arg_305_1.text_.text = var_308_6

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_8 = 17 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_6) / 17)

				if (17 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_6) / 17)) > 0 and var_308_4 < var_308_8 then
					arg_305_1.talkMaxDuration = var_308_8

					if var_308_8 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_3
					end
				end

				arg_305_1.text_.text = var_308_6
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb") ~= 0 then
					local var_308_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb") / 1000

					if var_308_9 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_3
					end

					if var_308_5.prefab_name ~= "" and arg_305_1.actors_[var_308_5.prefab_name] ~= nil then
						local var_308_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_5.prefab_name].transform, "story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")

						arg_305_1:RecordAudio("1108106072", var_308_10)
						arg_305_1:RecordAudio("1108106072", var_308_10)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_11 = math.max(var_308_4, arg_305_1.talkMaxDuration)

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_11 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_3) / var_308_11

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_3 + var_308_11 and arg_305_1.time_ < var_308_3 + var_308_11 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1108106073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1108106073
		arg_309_1.duration_ = 2.83

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1108106074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_312_0 = 0
			local var_312_1 = 0.35

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(1108106073)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 14 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_3) / 14)

				if (14 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_3) / 14)) > 0 and var_312_1 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb") ~= 0 then
					local var_312_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb") / 1000

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end

					if var_312_2.prefab_name ~= "" and arg_309_1.actors_[var_312_2.prefab_name] ~= nil then
						local var_312_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_2.prefab_name].transform, "story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")

						arg_309_1:RecordAudio("1108106073", var_312_7)
						arg_309_1:RecordAudio("1108106073", var_312_7)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1108106074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108106074
		arg_313_1.duration_ = 5.3

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1108106075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.525

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(1108106074)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 21 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 21)

				if (21 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 21)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")

						arg_313_1:RecordAudio("1108106074", var_316_6)
						arg_313_1:RecordAudio("1108106074", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1108106075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108106075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108106076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1081ui_story"]) and arg_317_1.var_.characterEffect1081ui_story == nil then
				arg_317_1.var_.characterEffect1081ui_story = arg_317_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.0333333333333333

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1081ui_story"]) then
				if arg_317_1.var_.characterEffect1081ui_story and not isNil(arg_317_1.actors_["1081ui_story"]) then
					arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1081ui_story"]) and arg_317_1.var_.characterEffect1081ui_story then
				arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 1.025

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1108106075).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 41 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 41)

				if (41 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 41)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1108106076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108106076
		arg_321_1.duration_ = 5.67

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108106077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1081ui_story"]) and arg_321_1.var_.characterEffect1081ui_story == nil then
				arg_321_1.var_.characterEffect1081ui_story = arg_321_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1081ui_story"]) then
				if arg_321_1.var_.characterEffect1081ui_story and not isNil(arg_321_1.actors_["1081ui_story"]) then
					arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1081ui_story"]) and arg_321_1.var_.characterEffect1081ui_story then
				arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_2 = 0
			local var_324_3 = 0.675

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(1108106076)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 27 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 27)

				if (27 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 27)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")

						arg_321_1:RecordAudio("1108106076", var_324_9)
						arg_321_1:RecordAudio("1108106076", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1108106077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108106077
		arg_325_1.duration_ = 1

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"

			SetActive(arg_325_1.choicesGo_, true)

			for iter_326_0, iter_326_1 in ipairs(arg_325_1.choices_) do
				SetActive(iter_326_1.go, iter_326_0 <= 1)
			end

			arg_325_1.choices_[1].txt.text = arg_325_1:FormatText(StoryChoiceCfg[988].name)
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108106078(arg_325_1)
			end

			arg_325_1:RecordChoiceLog(1108106077, 988)
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			return
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1108106078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108106078
		arg_329_1.duration_ = 6.97

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108106079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_332_0 = 0
			local var_332_1 = 0.95

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(1108106078)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 38 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 38)

				if (38 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 38)) > 0 and var_332_1 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb") ~= 0 then
					local var_332_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb") / 1000

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end

					if var_332_2.prefab_name ~= "" and arg_329_1.actors_[var_332_2.prefab_name] ~= nil then
						local var_332_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_2.prefab_name].transform, "story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")

						arg_329_1:RecordAudio("1108106078", var_332_7)
						arg_329_1:RecordAudio("1108106078", var_332_7)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108106079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108106079
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108106080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1081ui_story"]) and arg_333_1.var_.characterEffect1081ui_story == nil then
				arg_333_1.var_.characterEffect1081ui_story = arg_333_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.0333333333333333

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1081ui_story"]) then
				if arg_333_1.var_.characterEffect1081ui_story and not isNil(arg_333_1.actors_["1081ui_story"]) then
					arg_333_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1081ui_story"]) and arg_333_1.var_.characterEffect1081ui_story then
				arg_333_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.875

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1108106079).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)

				if (35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1108106080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108106080
		arg_337_1.duration_ = 1.3

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108106081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1081ui_story"]) and arg_337_1.var_.characterEffect1081ui_story == nil then
				arg_337_1.var_.characterEffect1081ui_story = arg_337_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1081ui_story"]) then
				if arg_337_1.var_.characterEffect1081ui_story and not isNil(arg_337_1.actors_["1081ui_story"]) then
					arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1081ui_story"]) and arg_337_1.var_.characterEffect1081ui_story then
				arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_340_2 = 0
			local var_340_3 = 0.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(1108106080)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 2 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 2)

				if (2 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 2)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")

						arg_337_1:RecordAudio("1108106080", var_340_9)
						arg_337_1:RecordAudio("1108106080", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108106081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108106081
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108106082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1081ui_story"]) and arg_341_1.var_.characterEffect1081ui_story == nil then
				arg_341_1.var_.characterEffect1081ui_story = arg_341_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1081ui_story"]) then
				if arg_341_1.var_.characterEffect1081ui_story and not isNil(arg_341_1.actors_["1081ui_story"]) then
					arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1081ui_story"]) and arg_341_1.var_.characterEffect1081ui_story then
				arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_344_1 = 0
			local var_344_2 = 0.425

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1108106081).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 17 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 17)

				if (17 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 17)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1108106082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108106082
		arg_345_1.duration_ = 2

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108106083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1081ui_story"]) and arg_345_1.var_.characterEffect1081ui_story == nil then
				arg_345_1.var_.characterEffect1081ui_story = arg_345_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1081ui_story"]) then
				if arg_345_1.var_.characterEffect1081ui_story and not isNil(arg_345_1.actors_["1081ui_story"]) then
					arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1081ui_story"]) and arg_345_1.var_.characterEffect1081ui_story then
				arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_348_2 = 0
			local var_348_3 = 0.175

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:GetWordFromCfg(1108106082)
				local var_348_5 = arg_345_1:FormatText(var_348_4.content)

				arg_345_1.text_.text = var_348_5

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 7 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 7)

				if (7 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 7)) > 0 and var_348_3 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_5
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb") / 1000

					if var_348_8 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_2
					end

					if var_348_4.prefab_name ~= "" and arg_345_1.actors_[var_348_4.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_4.prefab_name].transform, "story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")

						arg_345_1:RecordAudio("1108106082", var_348_9)
						arg_345_1:RecordAudio("1108106082", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_10 and arg_345_1.time_ < var_348_2 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108106083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108106083
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108106084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.allBtn_.enabled = false
			end

			if arg_349_1.time_ >= 0 + 0.3 and arg_349_1.time_ < 0 + 0.3 + arg_352_0 then
				arg_349_1.allBtn_.enabled = true
			end

			local var_352_0 = arg_349_1.actors_["1081ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1081ui_story = var_352_0.localPosition
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_1)
				var_352_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_0.position).x, (manager.ui.mainCamera.transform.position - var_352_0.position).y, (manager.ui.mainCamera.transform.position - var_352_0.position).z)
				var_352_0.localEulerAngles.z = 0
				var_352_0.localEulerAngles.x = 0
				var_352_0.localEulerAngles = var_352_0.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 100, 0)
				var_352_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_0.position).x, (manager.ui.mainCamera.transform.position - var_352_0.position).y, (manager.ui.mainCamera.transform.position - var_352_0.position).z)
				var_352_0.localEulerAngles.z = 0
				var_352_0.localEulerAngles.x = 0
				var_352_0.localEulerAngles = var_352_0.localEulerAngles
			end

			local var_352_2 = 0
			local var_352_3 = 0.725

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_4 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_4:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1108106083).content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 29 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 29)

				if (29 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 29)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7
					var_352_2 = var_352_2 + 0.3

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = var_352_2 + 0.3
			local var_352_9 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 + 0.3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_9 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_9

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_9 and arg_349_1.time_ < var_352_8 + var_352_9 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1108106084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1108106084
		arg_355_1.duration_ = 3.4

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1108106085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_0 = arg_355_1.actors_["1081ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1081ui_story == nil then
				arg_355_1.var_.characterEffect1081ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_1 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 and not isNil(var_358_0) then
				if arg_355_1.var_.characterEffect1081ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1081ui_story then
				arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_358_3 = arg_355_1.actors_["1081ui_story"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1081ui_story = var_358_3.localPosition

				arg_355_1:ShowWeapon(arg_355_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_358_4 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				var_358_3.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_355_1.time_ - 0) / var_358_4)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				var_358_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_358_5 = 0
			local var_358_6 = 0.275

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:GetWordFromCfg(1108106084)
				local var_358_8 = arg_355_1:FormatText(var_358_7.content)

				arg_355_1.text_.text = var_358_8

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_10 = 11 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 11)

				if (11 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 11)) > 0 and var_358_6 < var_358_10 then
					arg_355_1.talkMaxDuration = var_358_10

					if var_358_10 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_8
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb") ~= 0 then
					local var_358_11 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb") / 1000

					if var_358_11 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_5
					end

					if var_358_7.prefab_name ~= "" and arg_355_1.actors_[var_358_7.prefab_name] ~= nil then
						local var_358_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_7.prefab_name].transform, "story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")

						arg_355_1:RecordAudio("1108106084", var_358_12)
						arg_355_1:RecordAudio("1108106084", var_358_12)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_13 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_13 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_13

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_13 and arg_355_1.time_ < var_358_5 + var_358_13 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108106085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1108106085
		arg_359_1.duration_ = 4.7

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1108106086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.75

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(1108106085)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 30 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 30)

				if (30 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 30)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")

						arg_359_1:RecordAudio("1108106085", var_362_6)
						arg_359_1:RecordAudio("1108106085", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1108106086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1108106086
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1108106087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1081ui_story"]) and arg_363_1.var_.characterEffect1081ui_story == nil then
				arg_363_1.var_.characterEffect1081ui_story = arg_363_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1081ui_story"]) then
				if arg_363_1.var_.characterEffect1081ui_story and not isNil(arg_363_1.actors_["1081ui_story"]) then
					arg_363_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1081ui_story"]) and arg_363_1.var_.characterEffect1081ui_story then
				arg_363_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.325

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1108106086).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 13 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 13)

				if (13 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 13)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1108106087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1108106087
		arg_367_1.duration_ = 2.97

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1108106088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1081ui_story"]) and arg_367_1.var_.characterEffect1081ui_story == nil then
				arg_367_1.var_.characterEffect1081ui_story = arg_367_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1081ui_story"]) then
				if arg_367_1.var_.characterEffect1081ui_story and not isNil(arg_367_1.actors_["1081ui_story"]) then
					arg_367_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1081ui_story"]) and arg_367_1.var_.characterEffect1081ui_story then
				arg_367_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_2 = 0
			local var_370_3 = 0.35

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_4 = arg_367_1:GetWordFromCfg(1108106087)
				local var_370_5 = arg_367_1:FormatText(var_370_4.content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 14 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 14)

				if (14 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 14)) > 0 and var_370_3 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb") / 1000

					if var_370_8 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_2
					end

					if var_370_4.prefab_name ~= "" and arg_367_1.actors_[var_370_4.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_4.prefab_name].transform, "story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")

						arg_367_1:RecordAudio("1108106087", var_370_9)
						arg_367_1:RecordAudio("1108106087", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_3, arg_367_1.talkMaxDuration)

			if var_370_2 <= arg_367_1.time_ and arg_367_1.time_ < var_370_2 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_2) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_2 + var_370_10 and arg_367_1.time_ < var_370_2 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1108106088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1108106088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1108106089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1081ui_story"]) and arg_371_1.var_.characterEffect1081ui_story == nil then
				arg_371_1.var_.characterEffect1081ui_story = arg_371_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.075

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1081ui_story"]) then
				if arg_371_1.var_.characterEffect1081ui_story and not isNil(arg_371_1.actors_["1081ui_story"]) then
					arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1081ui_story"]) and arg_371_1.var_.characterEffect1081ui_story then
				arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.075

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
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

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1108106088).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 3 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 3)

				if (3 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 3)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_6 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_6

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_6 and arg_371_1.time_ < var_374_1 + var_374_6 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1108106089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1108106089
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1108106090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.825

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1108106089).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 33 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 33)

				if (33 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 33)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1108106090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1108106090
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1108106091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.825

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1108106090).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 33 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 33)

				if (33 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 33)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1108106091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1108106091
		arg_383_1.duration_ = 2.43

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1108106092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1081ui_story"]) and arg_383_1.var_.characterEffect1081ui_story == nil then
				arg_383_1.var_.characterEffect1081ui_story = arg_383_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1081ui_story"]) then
				if arg_383_1.var_.characterEffect1081ui_story and not isNil(arg_383_1.actors_["1081ui_story"]) then
					arg_383_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1081ui_story"]) and arg_383_1.var_.characterEffect1081ui_story then
				arg_383_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_386_2 = 0
			local var_386_3 = 0.05

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(1108106091)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 2 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 2)

				if (2 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 2)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")

						arg_383_1:RecordAudio("1108106091", var_386_9)
						arg_383_1:RecordAudio("1108106091", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1108106092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1108106092
		arg_387_1.duration_ = 2

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1108106093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_390_0 = 0
			local var_390_1 = 0.05

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(1108106092)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 2 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 2)

				if (2 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 2)) > 0 and var_390_1 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb") ~= 0 then
					local var_390_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb") / 1000

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end

					if var_390_2.prefab_name ~= "" and arg_387_1.actors_[var_390_2.prefab_name] ~= nil then
						local var_390_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_2.prefab_name].transform, "story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")

						arg_387_1:RecordAudio("1108106092", var_390_7)
						arg_387_1:RecordAudio("1108106092", var_390_7)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1108106093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1108106093
		arg_391_1.duration_ = 1.3

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"

			SetActive(arg_391_1.choicesGo_, true)

			for iter_392_0, iter_392_1 in ipairs(arg_391_1.choices_) do
				SetActive(iter_392_1.go, iter_392_0 <= 2)
			end

			arg_391_1.choices_[1].txt.text = arg_391_1:FormatText(StoryChoiceCfg[989].name)
			arg_391_1.choices_[2].txt.text = arg_391_1:FormatText(StoryChoiceCfg[990].name)
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1108106094(arg_391_1)
			end

			if arg_393_0 == 2 then
				arg_391_0:Play1108106094(arg_391_1)
			end

			arg_391_1:RecordChoiceLog(1108106093, 989, 990)
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1081ui_story"]) and arg_391_1.var_.characterEffect1081ui_story == nil then
				arg_391_1.var_.characterEffect1081ui_story = arg_391_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1081ui_story"]) then
				if arg_391_1.var_.characterEffect1081ui_story and not isNil(arg_391_1.actors_["1081ui_story"]) then
					arg_391_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1081ui_story"]) and arg_391_1.var_.characterEffect1081ui_story then
				arg_391_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1108106094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1108106094
		arg_395_1.duration_ = 4.2

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1108106095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1081ui_story"]) and arg_395_1.var_.characterEffect1081ui_story == nil then
				arg_395_1.var_.characterEffect1081ui_story = arg_395_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1081ui_story"]) then
				if arg_395_1.var_.characterEffect1081ui_story and not isNil(arg_395_1.actors_["1081ui_story"]) then
					arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1081ui_story"]) and arg_395_1.var_.characterEffect1081ui_story then
				arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_398_2 = "1081ui_story"

			if arg_395_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_398_3 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_395_1.stage_.transform)

				var_398_3.name = var_398_2
				var_398_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_[var_398_2] = var_398_3

				local var_398_4 = var_398_3:GetComponentInChildren(typeof(CharacterEffect))

				var_398_4.enabled = true

				local var_398_5 = GameObjectTools.GetOrAddComponent(var_398_3, typeof(DynamicBoneHelper))

				if var_398_5 then
					var_398_5:EnableDynamicBone(false)
				end

				arg_395_1:ShowWeapon(var_398_4.transform, false)

				arg_395_1.var_[var_398_2 .. "Animator"] = var_398_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_395_1.var_[var_398_2 .. "Animator"].applyRootMotion = true
				arg_395_1.var_[var_398_2 .. "LipSync"] = var_398_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_398_6 = 0
			local var_398_7 = 0.325

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_8 = arg_395_1:GetWordFromCfg(1108106094)
				local var_398_9 = arg_395_1:FormatText(var_398_8.content)

				arg_395_1.text_.text = var_398_9

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_11 = 13 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_9) / 13)

				if (13 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_9) / 13)) > 0 and var_398_7 < var_398_11 then
					arg_395_1.talkMaxDuration = var_398_11

					if var_398_11 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_9
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb") ~= 0 then
					local var_398_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb") / 1000

					if var_398_12 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_6
					end

					if var_398_8.prefab_name ~= "" and arg_395_1.actors_[var_398_8.prefab_name] ~= nil then
						local var_398_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_8.prefab_name].transform, "story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")

						arg_395_1:RecordAudio("1108106094", var_398_13)
						arg_395_1:RecordAudio("1108106094", var_398_13)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_14 and arg_395_1.time_ < var_398_6 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1108106095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1108106095
		arg_399_1.duration_ = 6.5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1108106096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action463")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_0 = 0
			local var_402_1 = 0.8

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_2 = arg_399_1:GetWordFromCfg(1108106095)
				local var_402_3 = arg_399_1:FormatText(var_402_2.content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 32 <= 0 and var_402_1 or var_402_1 * (utf8.len(var_402_3) / 32)

				if (32 <= 0 and var_402_1 or var_402_1 * (utf8.len(var_402_3) / 32)) > 0 and var_402_1 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb") ~= 0 then
					local var_402_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb") / 1000

					if var_402_6 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_0
					end

					if var_402_2.prefab_name ~= "" and arg_399_1.actors_[var_402_2.prefab_name] ~= nil then
						local var_402_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_2.prefab_name].transform, "story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")

						arg_399_1:RecordAudio("1108106095", var_402_7)
						arg_399_1:RecordAudio("1108106095", var_402_7)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_8 and arg_399_1.time_ < var_402_0 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1108106096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108106096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108106097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1081ui_story"]) and arg_403_1.var_.characterEffect1081ui_story == nil then
				arg_403_1.var_.characterEffect1081ui_story = arg_403_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1081ui_story"]) then
				if arg_403_1.var_.characterEffect1081ui_story and not isNil(arg_403_1.actors_["1081ui_story"]) then
					arg_403_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1081ui_story"]) and arg_403_1.var_.characterEffect1081ui_story then
				arg_403_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 0.225

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1108106096).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 9 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 9)

				if (9 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 9)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108106097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1108106097
		arg_407_1.duration_ = 5.33

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1108106098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1081ui_story"]) and arg_407_1.var_.characterEffect1081ui_story == nil then
				arg_407_1.var_.characterEffect1081ui_story = arg_407_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1081ui_story"]) then
				if arg_407_1.var_.characterEffect1081ui_story and not isNil(arg_407_1.actors_["1081ui_story"]) then
					arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1081ui_story"]) and arg_407_1.var_.characterEffect1081ui_story then
				arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_2 = 0
			local var_410_3 = 0.75

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(1108106097)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 30 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 30)

				if (30 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 30)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")

						arg_407_1:RecordAudio("1108106097", var_410_9)
						arg_407_1:RecordAudio("1108106097", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1108106098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1108106098
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1108106099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1081ui_story"]) and arg_411_1.var_.characterEffect1081ui_story == nil then
				arg_411_1.var_.characterEffect1081ui_story = arg_411_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.075

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1081ui_story"]) then
				if arg_411_1.var_.characterEffect1081ui_story and not isNil(arg_411_1.actors_["1081ui_story"]) then
					arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1081ui_story"]) and arg_411_1.var_.characterEffect1081ui_story then
				arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 0.075

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1108106098).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 3 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 3)

				if (3 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 3)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1108106099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1108106099
		arg_415_1.duration_ = 2.43

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1108106100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1081ui_story"]) and arg_415_1.var_.characterEffect1081ui_story == nil then
				arg_415_1.var_.characterEffect1081ui_story = arg_415_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1081ui_story"]) then
				if arg_415_1.var_.characterEffect1081ui_story and not isNil(arg_415_1.actors_["1081ui_story"]) then
					arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1081ui_story"]) and arg_415_1.var_.characterEffect1081ui_story then
				arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action437")
			end

			local var_418_2 = 0
			local var_418_3 = 0.175

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(1108106099)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 7 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 7)

				if (7 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 7)) > 0 and var_418_3 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_2
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb") / 1000

					if var_418_8 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_2
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")

						arg_415_1:RecordAudio("1108106099", var_418_9)
						arg_415_1:RecordAudio("1108106099", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_3, arg_415_1.talkMaxDuration)

			if var_418_2 <= arg_415_1.time_ and arg_415_1.time_ < var_418_2 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_2) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_2 + var_418_10 and arg_415_1.time_ < var_418_2 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1108106100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1108106100
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1108106101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1081ui_story = arg_419_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).z)
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles = arg_419_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1081ui_story"].transform.position).z)
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1081ui_story"].transform.localEulerAngles = arg_419_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_422_1 = 0
			local var_422_2 = 0.9

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(1108106100).content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 36 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 36)

				if (36 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 36)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_6 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_6 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_6

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_6 and arg_419_1.time_ < var_422_1 + var_422_6 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1108106101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1108106101
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1108106102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.225

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1108106101).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 9 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 9)

				if (9 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 9)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1108106102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1108106102
		arg_427_1.duration_ = 5.23

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1108106103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1081ui_story = arg_427_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).z)
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles = arg_427_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_427_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1081ui_story"].transform.position).z)
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1081ui_story"].transform.localEulerAngles = arg_427_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1081ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1081ui_story == nil then
				arg_427_1.var_.characterEffect1081ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1081ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1081ui_story then
				arg_427_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_4 = 0
			local var_430_5 = 0.475

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(1108106102)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 19 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 19)

				if (19 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 19)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")

						arg_427_1:RecordAudio("1108106102", var_430_11)
						arg_427_1:RecordAudio("1108106102", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play1108106103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108106103
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108106104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1081ui_story"]) and arg_431_1.var_.characterEffect1081ui_story == nil then
				arg_431_1.var_.characterEffect1081ui_story = arg_431_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1081ui_story"]) then
				if arg_431_1.var_.characterEffect1081ui_story and not isNil(arg_431_1.actors_["1081ui_story"]) then
					arg_431_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1081ui_story"]) and arg_431_1.var_.characterEffect1081ui_story then
				arg_431_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.525

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

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1108106103).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 21)

				if (21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 21)) > 0 and var_434_2 < var_434_5 then
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

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108106104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108106104
		arg_435_1.duration_ = 4.6

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108106105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1081ui_story"]) and arg_435_1.var_.characterEffect1081ui_story == nil then
				arg_435_1.var_.characterEffect1081ui_story = arg_435_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.034000001847744

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1081ui_story"]) then
				if arg_435_1.var_.characterEffect1081ui_story and not isNil(arg_435_1.actors_["1081ui_story"]) then
					arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1081ui_story"]) and arg_435_1.var_.characterEffect1081ui_story then
				arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_2 = 0
			local var_438_3 = 0.525

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(1108106104)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 21 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 21)

				if (21 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 21)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")

						arg_435_1:RecordAudio("1108106104", var_438_9)
						arg_435_1:RecordAudio("1108106104", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108106105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108106105
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108106106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1081ui_story"]) and arg_439_1.var_.characterEffect1081ui_story == nil then
				arg_439_1.var_.characterEffect1081ui_story = arg_439_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1081ui_story"]) then
				if arg_439_1.var_.characterEffect1081ui_story and not isNil(arg_439_1.actors_["1081ui_story"]) then
					arg_439_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1081ui_story"]) and arg_439_1.var_.characterEffect1081ui_story then
				arg_439_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.75

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
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

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1108106105).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 30 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 30)

				if (30 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 30)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108106106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108106106
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108106107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.65

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1108106106).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 26 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 26)

				if (26 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 26)) > 0 and var_446_0 < var_446_3 then
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
	Play1108106107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108106107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108106108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.325

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

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1108106107).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 13 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 13)

				if (13 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 13)) > 0 and var_450_0 < var_450_3 then
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
	Play1108106108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1108106108
		arg_451_1.duration_ = 2

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1108106109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1081ui_story"]) and arg_451_1.var_.characterEffect1081ui_story == nil then
				arg_451_1.var_.characterEffect1081ui_story = arg_451_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1081ui_story"]) then
				if arg_451_1.var_.characterEffect1081ui_story and not isNil(arg_451_1.actors_["1081ui_story"]) then
					arg_451_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1081ui_story"]) and arg_451_1.var_.characterEffect1081ui_story then
				arg_451_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_454_2 = 0
			local var_454_3 = 0.075

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_4 = arg_451_1:GetWordFromCfg(1108106108)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 3 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 3)

				if (3 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 3)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb") / 1000

					if var_454_8 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_2
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")

						arg_451_1:RecordAudio("1108106108", var_454_9)
						arg_451_1:RecordAudio("1108106108", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_10 and arg_451_1.time_ < var_454_2 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1108106109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1108106109
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1108106110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1081ui_story"]) and arg_455_1.var_.characterEffect1081ui_story == nil then
				arg_455_1.var_.characterEffect1081ui_story = arg_455_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1081ui_story"]) then
				if arg_455_1.var_.characterEffect1081ui_story and not isNil(arg_455_1.actors_["1081ui_story"]) then
					arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_0)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1081ui_story"]) and arg_455_1.var_.characterEffect1081ui_story then
				arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_458_1 = 0
			local var_458_2 = 1.15

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(1108106109).content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 46 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 46)

				if (46 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 46)) > 0 and var_458_2 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_6 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_6 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_6

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_6 and arg_455_1.time_ < var_458_1 + var_458_6 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1108106110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1108106110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1108106111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.65

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

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1108106110).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 26 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 26)

				if (26 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 26)) > 0 and var_462_0 < var_462_3 then
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
	Play1108106111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1108106111
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1108106112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.825

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1108106111).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 33 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 33)

				if (33 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 33)) > 0 and var_466_0 < var_466_3 then
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
	Play1108106112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108106112
		arg_467_1.duration_ = 1

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"

			SetActive(arg_467_1.choicesGo_, true)

			for iter_468_0, iter_468_1 in ipairs(arg_467_1.choices_) do
				SetActive(iter_468_1.go, iter_468_0 <= 1)
			end

			arg_467_1.choices_[1].txt.text = arg_467_1:FormatText(StoryChoiceCfg[991].name)
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108106113(arg_467_1)
			end

			arg_467_1:RecordChoiceLog(1108106112, 991)
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			return
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108106113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108106113
		arg_471_1.duration_ = 9

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108106114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 4 < arg_471_1.time_ and arg_471_1.time_ <= 4 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			if arg_471_1.time_ >= 4 + 0.3 and arg_471_1.time_ < 4 + 0.3 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_0 = "R8102a"

			if arg_471_1.bgs_.R8102a == nil then
				local var_474_1 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_474_0)
				var_474_1.name = var_474_0
				var_474_1.transform.parent = arg_471_1.stage_.transform
				var_474_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_[var_474_0] = var_474_1
			end

			if 2 < arg_471_1.time_ and arg_471_1.time_ <= 2 + arg_474_0 then
				local var_474_2 = arg_471_1.bgs_.R8102a

				arg_471_1.bgs_.R8102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_474_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_3 = var_474_2:GetComponent("SpriteRenderer")

				if var_474_3 and var_474_3.sprite then
					local var_474_4 = 2 * (var_474_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_474_2.transform.localScale = Vector3.New(var_474_4 / var_474_3.sprite.bounds.size.y < var_474_4 * manager.ui.mainCameraCom_.aspect / var_474_3.sprite.bounds.size.x and var_474_4 * manager.ui.mainCameraCom_.aspect / var_474_3.sprite.bounds.size.x or var_474_4 / var_474_3.sprite.bounds.size.y, var_474_4 / var_474_3.sprite.bounds.size.y < var_474_4 * manager.ui.mainCameraCom_.aspect / var_474_3.sprite.bounds.size.x and var_474_4 * manager.ui.mainCameraCom_.aspect / var_474_3.sprite.bounds.size.x or var_474_4 / var_474_3.sprite.bounds.size.y, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "R8102a" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_5 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_6 = 2

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_6 then
				local var_474_7 = Color.New(0, 0, 0)

				var_474_7.a = Mathf.Lerp(0, 1, (arg_471_1.time_ - var_474_5) / var_474_6)
				arg_471_1.mask_.color = var_474_7
			end

			if arg_471_1.time_ >= var_474_5 + var_474_6 and arg_471_1.time_ < var_474_5 + var_474_6 + arg_474_0 then
				local var_474_8 = Color.New(0, 0, 0)

				var_474_8.a = 1
				arg_471_1.mask_.color = var_474_8
			end

			local var_474_9 = 2

			if 2 < arg_471_1.time_ and arg_471_1.time_ <= var_474_9 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_10 = 2

			if var_474_9 <= arg_471_1.time_ and arg_471_1.time_ < var_474_9 + var_474_10 then
				local var_474_11 = Color.New(0, 0, 0)

				var_474_11.a = Mathf.Lerp(1, 0, (arg_471_1.time_ - var_474_9) / var_474_10)
				arg_471_1.mask_.color = var_474_11
			end

			if arg_471_1.time_ >= var_474_9 + var_474_10 and arg_471_1.time_ < var_474_9 + var_474_10 + arg_474_0 then
				local var_474_12 = Color.New(0, 0, 0)

				arg_471_1.mask_.enabled = false
				var_474_12.a = 0
				arg_471_1.mask_.color = var_474_12
			end

			local var_474_13 = arg_471_1.actors_["1081ui_story"].transform

			if 1.966 < arg_471_1.time_ and arg_471_1.time_ <= 1.966 + arg_474_0 then
				arg_471_1.var_.moveOldPos1081ui_story = var_474_13.localPosition

				arg_471_1:ShowWeapon(arg_471_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_474_14 = 0.001

			if 1.966 <= arg_471_1.time_ and arg_471_1.time_ < 1.966 + var_474_14 then
				var_474_13.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 1.966) / var_474_14)
				var_474_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_13.position).x, (manager.ui.mainCamera.transform.position - var_474_13.position).y, (manager.ui.mainCamera.transform.position - var_474_13.position).z)
				var_474_13.localEulerAngles.z = 0
				var_474_13.localEulerAngles.x = 0
				var_474_13.localEulerAngles = var_474_13.localEulerAngles
			end

			if arg_471_1.time_ >= 1.966 + var_474_14 and arg_471_1.time_ < 1.966 + var_474_14 + arg_474_0 then
				var_474_13.localPosition = Vector3.New(0, 100, 0)
				var_474_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_13.position).x, (manager.ui.mainCamera.transform.position - var_474_13.position).y, (manager.ui.mainCamera.transform.position - var_474_13.position).z)
				var_474_13.localEulerAngles.z = 0
				var_474_13.localEulerAngles.x = 0
				var_474_13.localEulerAngles = var_474_13.localEulerAngles
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_15 = 4
			local var_474_16 = 0.925

			if 4 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_17 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_17:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_18 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1108106113).content)

				arg_471_1.text_.text = var_474_18

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_20 = 37 <= 0 and var_474_16 or var_474_16 * (utf8.len(var_474_18) / 37)

				if (37 <= 0 and var_474_16 or var_474_16 * (utf8.len(var_474_18) / 37)) > 0 and var_474_16 < var_474_20 then
					arg_471_1.talkMaxDuration = var_474_20
					var_474_15 = var_474_15 + 0.3

					if var_474_20 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_20 + var_474_15
					end
				end

				arg_471_1.text_.text = var_474_18
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_21 = var_474_15 + 0.3
			local var_474_22 = math.max(var_474_16, arg_471_1.talkMaxDuration)

			if var_474_15 + 0.3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_21 + var_474_22 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_21) / var_474_22

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_21 + var_474_22 and arg_471_1.time_ < var_474_21 + var_474_22 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play1108106114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1108106114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1108106115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.6

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1108106114).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 24 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 24)

				if (24 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 24)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1108106115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108106115
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108106116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.475

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1108106115).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 19 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 19)

				if (19 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 19)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1108106116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108106116
		arg_485_1.duration_ = 1

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"

			SetActive(arg_485_1.choicesGo_, true)

			for iter_486_0, iter_486_1 in ipairs(arg_485_1.choices_) do
				SetActive(iter_486_1.go, iter_486_0 <= 1)
			end

			arg_485_1.choices_[1].txt.text = arg_485_1:FormatText(StoryChoiceCfg[992].name)
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108106117(arg_485_1)
			end

			arg_485_1:RecordChoiceLog(1108106116, 992)
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			return
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1108106117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108106117
		arg_489_1.duration_ = 2.9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108106118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.45

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(1108106117)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 18 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 18)

				if (18 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 18)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")

						arg_489_1:RecordAudio("1108106117", var_492_6)
						arg_489_1:RecordAudio("1108106117", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108106118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1108106118
		arg_493_1.duration_ = 4.57

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1108106119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.425

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:GetWordFromCfg(1108106118)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 17 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 17)

				if (17 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 17)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")

						arg_493_1:RecordAudio("1108106118", var_496_6)
						arg_493_1:RecordAudio("1108106118", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1108106119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1108106119
		arg_497_1.duration_ = 1.93

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1108106120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.25

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:GetWordFromCfg(1108106119)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 10 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 10)

				if (10 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 10)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")

						arg_497_1:RecordAudio("1108106119", var_500_6)
						arg_497_1:RecordAudio("1108106119", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1108106120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1108106120
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1108106121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 1.525

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1108106120).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 61 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 61)

				if (61 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 61)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1108106121 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1108106121
		arg_505_1.duration_ = 1.37

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1108106122(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.075

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:GetWordFromCfg(1108106121)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 3 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 3)

				if (3 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 3)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")

						arg_505_1:RecordAudio("1108106121", var_508_6)
						arg_505_1:RecordAudio("1108106121", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1108106122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1108106122
		arg_509_1.duration_ = 2.43

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1108106123(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.275

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:GetWordFromCfg(1108106122)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 11 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 11)

				if (11 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 11)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")

						arg_509_1:RecordAudio("1108106122", var_512_6)
						arg_509_1:RecordAudio("1108106122", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1108106123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1108106123
		arg_513_1.duration_ = 6.03

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1108106124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.625

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:GetWordFromCfg(1108106123)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 25 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 25)

				if (25 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 25)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")

						arg_513_1:RecordAudio("1108106123", var_516_6)
						arg_513_1:RecordAudio("1108106123", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1108106124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1108106124
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1108106125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.775

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1108106124).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 31 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 31)

				if (31 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 31)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1108106125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1108106125
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1108106126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.525

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1108106125).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 21 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 21)

				if (21 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 21)) > 0 and var_524_0 < var_524_3 then
					arg_521_1.talkMaxDuration = var_524_3

					if var_524_3 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_3 + 0
					end
				end

				arg_521_1.text_.text = var_524_1
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_4 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_4 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_4

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_4 and arg_521_1.time_ < 0 + var_524_4 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1108106126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1108106126
		arg_525_1.duration_ = 7.03

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1108106127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if arg_525_1.bgs_.R8102 == nil then
				local var_528_0 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8102")
				var_528_0.name = "R8102"
				var_528_0.transform.parent = arg_525_1.stage_.transform
				var_528_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_.R8102 = var_528_0
			end

			if 2.03333333333333 < arg_525_1.time_ and arg_525_1.time_ <= 2.03333333333333 + arg_528_0 then
				local var_528_1 = arg_525_1.bgs_.R8102

				arg_525_1.bgs_.R8102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_528_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_2 = var_528_1:GetComponent("SpriteRenderer")

				if var_528_2 and var_528_2.sprite then
					local var_528_3 = 2 * (var_528_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_528_1.transform.localScale = Vector3.New(var_528_3 / var_528_2.sprite.bounds.size.y < var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x and var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x or var_528_3 / var_528_2.sprite.bounds.size.y, var_528_3 / var_528_2.sprite.bounds.size.y < var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x and var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x or var_528_3 / var_528_2.sprite.bounds.size.y, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "R8102" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_4 = 0

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.allBtn_.enabled = false
			end

			if arg_525_1.time_ >= var_528_4 + 0.3 and arg_525_1.time_ < var_528_4 + 0.3 + arg_528_0 then
				arg_525_1.allBtn_.enabled = true
			end

			local var_528_5 = 0

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_6 = 2.03333333333333

			if var_528_5 <= arg_525_1.time_ and arg_525_1.time_ < var_528_5 + var_528_6 then
				local var_528_7 = Color.New(0, 0, 0)

				var_528_7.a = Mathf.Lerp(0, 1, (arg_525_1.time_ - var_528_5) / var_528_6)
				arg_525_1.mask_.color = var_528_7
			end

			if arg_525_1.time_ >= var_528_5 + var_528_6 and arg_525_1.time_ < var_528_5 + var_528_6 + arg_528_0 then
				local var_528_8 = Color.New(0, 0, 0)

				var_528_8.a = 1
				arg_525_1.mask_.color = var_528_8
			end

			local var_528_9 = 2.03333333333333

			if 2.03333333333333 < arg_525_1.time_ and arg_525_1.time_ <= var_528_9 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_10 = 2

			if var_528_9 <= arg_525_1.time_ and arg_525_1.time_ < var_528_9 + var_528_10 then
				local var_528_11 = Color.New(0, 0, 0)

				var_528_11.a = Mathf.Lerp(1, 0, (arg_525_1.time_ - var_528_9) / var_528_10)
				arg_525_1.mask_.color = var_528_11
			end

			if arg_525_1.time_ >= var_528_9 + var_528_10 and arg_525_1.time_ < var_528_9 + var_528_10 + arg_528_0 then
				local var_528_12 = Color.New(0, 0, 0)

				arg_525_1.mask_.enabled = false
				var_528_12.a = 0
				arg_525_1.mask_.color = var_528_12
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_13 = 2.03333333333333
			local var_528_14 = 0.725

			if 2.03333333333333 < arg_525_1.time_ and arg_525_1.time_ <= var_528_13 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_15 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_15:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_16 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1108106126).content)

				arg_525_1.text_.text = var_528_16

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_18 = 29 <= 0 and var_528_14 or var_528_14 * (utf8.len(var_528_16) / 29)

				if (29 <= 0 and var_528_14 or var_528_14 * (utf8.len(var_528_16) / 29)) > 0 and var_528_14 < var_528_18 then
					arg_525_1.talkMaxDuration = var_528_18
					var_528_13 = var_528_13 + 0.3

					if var_528_18 + var_528_13 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_18 + var_528_13
					end
				end

				arg_525_1.text_.text = var_528_16
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_19 = var_528_13 + 0.3
			local var_528_20 = math.max(var_528_14, arg_525_1.talkMaxDuration)

			if var_528_13 + 0.3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_19 + var_528_20 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_19) / var_528_20

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_19 + var_528_20 and arg_525_1.time_ < var_528_19 + var_528_20 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1108106127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108106127
		arg_531_1.duration_ = 3.2

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108106128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.325

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:GetWordFromCfg(1108106127)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 13 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 13)

				if (13 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 13)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")

						arg_531_1:RecordAudio("1108106127", var_534_6)
						arg_531_1:RecordAudio("1108106127", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108106128 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1108106128
		arg_535_1.duration_ = 5.53

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1108106129(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.725

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:GetWordFromCfg(1108106128)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 29 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 29)

				if (29 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 29)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")

						arg_535_1:RecordAudio("1108106128", var_538_6)
						arg_535_1:RecordAudio("1108106128", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1108106129 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1108106129
		arg_539_1.duration_ = 4.53

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1108106130(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.625

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_1 = arg_539_1:GetWordFromCfg(1108106129)
				local var_542_2 = arg_539_1:FormatText(var_542_1.content)

				arg_539_1.text_.text = var_542_2

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 25 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 25)

				if (25 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 25)) > 0 and var_542_0 < var_542_4 then
					arg_539_1.talkMaxDuration = var_542_4

					if var_542_4 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_4 + 0
					end
				end

				arg_539_1.text_.text = var_542_2
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb") ~= 0 then
					local var_542_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb") / 1000

					if var_542_5 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + 0
					end

					if var_542_1.prefab_name ~= "" and arg_539_1.actors_[var_542_1.prefab_name] ~= nil then
						local var_542_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_1.prefab_name].transform, "story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")

						arg_539_1:RecordAudio("1108106129", var_542_6)
						arg_539_1:RecordAudio("1108106129", var_542_6)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_7 and arg_539_1.time_ < 0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1108106130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108106130
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108106131(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.325

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1108106130).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 13 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 13)

				if (13 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 13)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1108106131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108106131
		arg_547_1.duration_ = 1

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"

			SetActive(arg_547_1.choicesGo_, true)

			for iter_548_0, iter_548_1 in ipairs(arg_547_1.choices_) do
				SetActive(iter_548_1.go, iter_548_0 <= 1)
			end

			arg_547_1.choices_[1].txt.text = arg_547_1:FormatText(StoryChoiceCfg[993].name)
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108106132(arg_547_1)
			end

			arg_547_1:RecordChoiceLog(1108106131, 993)
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			return
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108106132 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108106132
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108106133(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.85

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1108106132).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 34 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 34)

				if (34 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 34)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108106133 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108106133
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1108106134(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.775

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1108106133).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 31 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 31)

				if (31 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 31)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1108106134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1108106134
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1108106135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.65

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(1108106134).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 26 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 26)

				if (26 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 26)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1108106135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1108106135
		arg_563_1.duration_ = 1

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"

			SetActive(arg_563_1.choicesGo_, true)

			for iter_564_0, iter_564_1 in ipairs(arg_563_1.choices_) do
				SetActive(iter_564_1.go, iter_564_0 <= 1)
			end

			arg_563_1.choices_[1].txt.text = arg_563_1:FormatText(StoryChoiceCfg[994].name)
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1108106136(arg_563_1)
			end

			arg_563_1:RecordChoiceLog(1108106135, 994)
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			return
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1108106136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1108106136
		arg_567_1.duration_ = 4.33

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1108106137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.725

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_1 = arg_567_1:GetWordFromCfg(1108106136)
				local var_570_2 = arg_567_1:FormatText(var_570_1.content)

				arg_567_1.text_.text = var_570_2

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_4 = 29 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 29)

				if (29 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 29)) > 0 and var_570_0 < var_570_4 then
					arg_567_1.talkMaxDuration = var_570_4

					if var_570_4 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_4 + 0
					end
				end

				arg_567_1.text_.text = var_570_2
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb") ~= 0 then
					local var_570_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb") / 1000

					if var_570_5 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + 0
					end

					if var_570_1.prefab_name ~= "" and arg_567_1.actors_[var_570_1.prefab_name] ~= nil then
						local var_570_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_1.prefab_name].transform, "story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")

						arg_567_1:RecordAudio("1108106136", var_570_6)
						arg_567_1:RecordAudio("1108106136", var_570_6)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_7 and arg_567_1.time_ < 0 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1108106137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1108106137
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1108106138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.85

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_1 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(1108106137).content)

				arg_571_1.text_.text = var_574_1

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_3 = 34 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 34)

				if (34 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 34)) > 0 and var_574_0 < var_574_3 then
					arg_571_1.talkMaxDuration = var_574_3

					if var_574_3 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_3 + 0
					end
				end

				arg_571_1.text_.text = var_574_1
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_4 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_4 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_4

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_4 and arg_571_1.time_ < 0 + var_574_4 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1108106138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1108106138
		arg_575_1.duration_ = 4.67

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1108106139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.625

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:GetWordFromCfg(1108106138)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 25 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 25)

				if (25 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 25)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")

						arg_575_1:RecordAudio("1108106138", var_578_6)
						arg_575_1:RecordAudio("1108106138", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1108106139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1108106139
		arg_579_1.duration_ = 2.47

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1108106140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.3

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_1 = arg_579_1:GetWordFromCfg(1108106139)
				local var_582_2 = arg_579_1:FormatText(var_582_1.content)

				arg_579_1.text_.text = var_582_2

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 12 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 12)

				if (12 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 12)) > 0 and var_582_0 < var_582_4 then
					arg_579_1.talkMaxDuration = var_582_4

					if var_582_4 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_4 + 0
					end
				end

				arg_579_1.text_.text = var_582_2
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb") ~= 0 then
					local var_582_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb") / 1000

					if var_582_5 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + 0
					end

					if var_582_1.prefab_name ~= "" and arg_579_1.actors_[var_582_1.prefab_name] ~= nil then
						local var_582_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_1.prefab_name].transform, "story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")

						arg_579_1:RecordAudio("1108106139", var_582_6)
						arg_579_1:RecordAudio("1108106139", var_582_6)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_7 and arg_579_1.time_ < 0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1108106140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1108106140
		arg_583_1.duration_ = 2.47

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1108106141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.3

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:GetWordFromCfg(1108106140)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 12 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 12)

				if (12 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 12)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")

						arg_583_1:RecordAudio("1108106140", var_586_6)
						arg_583_1:RecordAudio("1108106140", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1108106141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1108106141
		arg_587_1.duration_ = 4

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1108106142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.725

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_1 = arg_587_1:GetWordFromCfg(1108106141)
				local var_590_2 = arg_587_1:FormatText(var_590_1.content)

				arg_587_1.text_.text = var_590_2

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_4 = 29 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_2) / 29)

				if (29 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_2) / 29)) > 0 and var_590_0 < var_590_4 then
					arg_587_1.talkMaxDuration = var_590_4

					if var_590_4 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_4 + 0
					end
				end

				arg_587_1.text_.text = var_590_2
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb") ~= 0 then
					local var_590_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb") / 1000

					if var_590_5 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + 0
					end

					if var_590_1.prefab_name ~= "" and arg_587_1.actors_[var_590_1.prefab_name] ~= nil then
						local var_590_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_1.prefab_name].transform, "story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")

						arg_587_1:RecordAudio("1108106141", var_590_6)
						arg_587_1:RecordAudio("1108106141", var_590_6)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_7 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_7 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_7

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_7 and arg_587_1.time_ < 0 + var_590_7 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1108106142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1108106142
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1108106143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.75

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1108106142).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 30 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 30)

				if (30 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 30)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1108106143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1108106143
		arg_595_1.duration_ = 3.73

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1108106144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.425

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:GetWordFromCfg(1108106143)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 17 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 17)

				if (17 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 17)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")

						arg_595_1:RecordAudio("1108106143", var_598_6)
						arg_595_1:RecordAudio("1108106143", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1108106144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1108106144
		arg_599_1.duration_ = 8.37

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1108106145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.525

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_1 = arg_599_1:GetWordFromCfg(1108106144)
				local var_602_2 = arg_599_1:FormatText(var_602_1.content)

				arg_599_1.text_.text = var_602_2

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_4 = 21 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 21)

				if (21 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 21)) > 0 and var_602_0 < var_602_4 then
					arg_599_1.talkMaxDuration = var_602_4

					if var_602_4 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_4 + 0
					end
				end

				arg_599_1.text_.text = var_602_2
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb") ~= 0 then
					local var_602_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb") / 1000

					if var_602_5 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + 0
					end

					if var_602_1.prefab_name ~= "" and arg_599_1.actors_[var_602_1.prefab_name] ~= nil then
						local var_602_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_1.prefab_name].transform, "story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")

						arg_599_1:RecordAudio("1108106144", var_602_6)
						arg_599_1:RecordAudio("1108106144", var_602_6)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_7 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_7 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_7

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_7 and arg_599_1.time_ < 0 + var_602_7 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1108106145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108106145
		arg_603_1.duration_ = 5.1

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108106146(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 1.96666666666667 < arg_603_1.time_ and arg_603_1.time_ <= 1.96666666666667 + arg_606_0 then
				local var_606_0 = arg_603_1.bgs_.R8102a

				arg_603_1.bgs_.R8102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_606_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_606_1 = var_606_0:GetComponent("SpriteRenderer")

				if var_606_1 and var_606_1.sprite then
					local var_606_2 = 2 * (var_606_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_606_0.transform.localScale = Vector3.New(var_606_2 / var_606_1.sprite.bounds.size.y < var_606_2 * manager.ui.mainCameraCom_.aspect / var_606_1.sprite.bounds.size.x and var_606_2 * manager.ui.mainCameraCom_.aspect / var_606_1.sprite.bounds.size.x or var_606_2 / var_606_1.sprite.bounds.size.y, var_606_2 / var_606_1.sprite.bounds.size.y < var_606_2 * manager.ui.mainCameraCom_.aspect / var_606_1.sprite.bounds.size.x and var_606_2 * manager.ui.mainCameraCom_.aspect / var_606_1.sprite.bounds.size.x or var_606_2 / var_606_1.sprite.bounds.size.y, 0)
				end

				for iter_606_0, iter_606_1 in pairs(arg_603_1.bgs_) do
					if iter_606_0 ~= "R8102a" then
						iter_606_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_606_3 = 1.96666666666667

			if 1.96666666666667 < arg_603_1.time_ and arg_603_1.time_ <= var_606_3 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			if arg_603_1.time_ >= var_606_3 + 0.3 and arg_603_1.time_ < var_606_3 + 0.3 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end

			local var_606_4 = 0

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_5 = 1.96666666666667

			if var_606_4 <= arg_603_1.time_ and arg_603_1.time_ < var_606_4 + var_606_5 then
				local var_606_6 = Color.New(0, 0, 0)

				var_606_6.a = Mathf.Lerp(0, 1, (arg_603_1.time_ - var_606_4) / var_606_5)
				arg_603_1.mask_.color = var_606_6
			end

			if arg_603_1.time_ >= var_606_4 + var_606_5 and arg_603_1.time_ < var_606_4 + var_606_5 + arg_606_0 then
				local var_606_7 = Color.New(0, 0, 0)

				var_606_7.a = 1
				arg_603_1.mask_.color = var_606_7
			end

			local var_606_8 = 1.96666666666667

			if 1.96666666666667 < arg_603_1.time_ and arg_603_1.time_ <= var_606_8 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_9 = 2

			if var_606_8 <= arg_603_1.time_ and arg_603_1.time_ < var_606_8 + var_606_9 then
				local var_606_10 = Color.New(0, 0, 0)

				var_606_10.a = Mathf.Lerp(1, 0, (arg_603_1.time_ - var_606_8) / var_606_9)
				arg_603_1.mask_.color = var_606_10
			end

			if arg_603_1.time_ >= var_606_8 + var_606_9 and arg_603_1.time_ < var_606_8 + var_606_9 + arg_606_0 then
				local var_606_11 = Color.New(0, 0, 0)

				arg_603_1.mask_.enabled = false
				var_606_11.a = 0
				arg_603_1.mask_.color = var_606_11
			end

			if arg_603_1.frameCnt_ <= 1 then
				arg_603_1.dialog_:SetActive(false)
			end

			local var_606_12 = 3.03333333333333
			local var_606_13 = 0.15

			if 3.03333333333333 < arg_603_1.time_ and arg_603_1.time_ <= var_606_12 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0

				arg_603_1.dialog_:SetActive(true)

				arg_603_1.dialogCg_.alpha = 0

				local var_606_14 = LeanTween.value(arg_603_1.dialog_, 0, 1, 0.3)

				var_606_14:setOnUpdate(LuaHelper.FloatAction(function(arg_607_0)
					arg_603_1.dialogCg_.alpha = arg_607_0
				end))
				var_606_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_603_1.dialog_)
					var_606_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_603_1.duration_ = arg_603_1.duration_ + 0.3

				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_15 = arg_603_1:GetWordFromCfg(1108106145)
				local var_606_16 = arg_603_1:FormatText(var_606_15.content)

				arg_603_1.text_.text = var_606_16

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_18 = 6 <= 0 and var_606_13 or var_606_13 * (utf8.len(var_606_16) / 6)

				if (6 <= 0 and var_606_13 or var_606_13 * (utf8.len(var_606_16) / 6)) > 0 and var_606_13 < var_606_18 then
					arg_603_1.talkMaxDuration = var_606_18
					var_606_12 = var_606_12 + 0.3

					if var_606_18 + var_606_12 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_18 + var_606_12
					end
				end

				arg_603_1.text_.text = var_606_16
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb") ~= 0 then
					local var_606_19 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb") / 1000

					if var_606_19 + var_606_12 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_19 + var_606_12
					end

					if var_606_15.prefab_name ~= "" and arg_603_1.actors_[var_606_15.prefab_name] ~= nil then
						local var_606_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_15.prefab_name].transform, "story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")

						arg_603_1:RecordAudio("1108106145", var_606_20)
						arg_603_1:RecordAudio("1108106145", var_606_20)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_21 = var_606_12 + 0.3
			local var_606_22 = math.max(var_606_13, arg_603_1.talkMaxDuration)

			if var_606_12 + 0.3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_21 + var_606_22 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_21) / var_606_22

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_21 + var_606_22 and arg_603_1.time_ < var_606_21 + var_606_22 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108106146 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1108106146
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1108106147(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 1.15

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(1108106146).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 46 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 46)

				if (46 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 46)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1108106147 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1108106147
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1108106148(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0.175

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_1 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1108106147).content)

				arg_613_1.text_.text = var_616_1

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_3 = 7 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 7)

				if (7 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 7)) > 0 and var_616_0 < var_616_3 then
					arg_613_1.talkMaxDuration = var_616_3

					if var_616_3 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_3 + 0
					end
				end

				arg_613_1.text_.text = var_616_1
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_4 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_4 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_4

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_4 and arg_613_1.time_ < 0 + var_616_4 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1108106148 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1108106148
		arg_617_1.duration_ = 4.73

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1108106149(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0.6

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:GetWordFromCfg(1108106148)
				local var_620_2 = arg_617_1:FormatText(var_620_1.content)

				arg_617_1.text_.text = var_620_2

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 24 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 24)

				if (24 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 24)) > 0 and var_620_0 < var_620_4 then
					arg_617_1.talkMaxDuration = var_620_4

					if var_620_4 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_4 + 0
					end
				end

				arg_617_1.text_.text = var_620_2
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb") ~= 0 then
					local var_620_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb") / 1000

					if var_620_5 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + 0
					end

					if var_620_1.prefab_name ~= "" and arg_617_1.actors_[var_620_1.prefab_name] ~= nil then
						local var_620_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_1.prefab_name].transform, "story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")

						arg_617_1:RecordAudio("1108106148", var_620_6)
						arg_617_1:RecordAudio("1108106148", var_620_6)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_7 and arg_617_1.time_ < 0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1108106149 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1108106149
		arg_621_1.duration_ = 1

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"

			SetActive(arg_621_1.choicesGo_, true)

			for iter_622_0, iter_622_1 in ipairs(arg_621_1.choices_) do
				SetActive(iter_622_1.go, iter_622_0 <= 2)
			end

			arg_621_1.choices_[1].txt.text = arg_621_1:FormatText(StoryChoiceCfg[995].name)
			arg_621_1.choices_[2].txt.text = arg_621_1:FormatText(StoryChoiceCfg[996].name)
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1108106150(arg_621_1)
			end

			if arg_623_0 == 2 then
				arg_621_0:Play1108106150(arg_621_1)
			end

			arg_621_1:RecordChoiceLog(1108106149, 995, 996)
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			return
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1108106150 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1108106150
		arg_625_1.duration_ = 2.27

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1108106151(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.275

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_1 = arg_625_1:GetWordFromCfg(1108106150)
				local var_628_2 = arg_625_1:FormatText(var_628_1.content)

				arg_625_1.text_.text = var_628_2

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 11 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 11)

				if (11 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 11)) > 0 and var_628_0 < var_628_4 then
					arg_625_1.talkMaxDuration = var_628_4

					if var_628_4 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_4 + 0
					end
				end

				arg_625_1.text_.text = var_628_2
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb") ~= 0 then
					local var_628_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb") / 1000

					if var_628_5 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + 0
					end

					if var_628_1.prefab_name ~= "" and arg_625_1.actors_[var_628_1.prefab_name] ~= nil then
						local var_628_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_1.prefab_name].transform, "story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")

						arg_625_1:RecordAudio("1108106150", var_628_6)
						arg_625_1:RecordAudio("1108106150", var_628_6)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_7 and arg_625_1.time_ < 0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1108106151 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1108106151
		arg_629_1.duration_ = 3.7

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1108106152(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0.45

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_1 = arg_629_1:GetWordFromCfg(1108106151)
				local var_632_2 = arg_629_1:FormatText(var_632_1.content)

				arg_629_1.text_.text = var_632_2

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_4 = 18 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_2) / 18)

				if (18 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_2) / 18)) > 0 and var_632_0 < var_632_4 then
					arg_629_1.talkMaxDuration = var_632_4

					if var_632_4 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_4 + 0
					end
				end

				arg_629_1.text_.text = var_632_2
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb") ~= 0 then
					local var_632_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb") / 1000

					if var_632_5 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_5 + 0
					end

					if var_632_1.prefab_name ~= "" and arg_629_1.actors_[var_632_1.prefab_name] ~= nil then
						local var_632_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_1.prefab_name].transform, "story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")

						arg_629_1:RecordAudio("1108106151", var_632_6)
						arg_629_1:RecordAudio("1108106151", var_632_6)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_7 = math.max(var_632_0, arg_629_1.talkMaxDuration)

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_7 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - 0) / var_632_7

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= 0 + var_632_7 and arg_629_1.time_ < 0 + var_632_7 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1108106152 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1108106152
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1108106153(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 0.15

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_1 = arg_633_1:FormatText(arg_633_1:GetWordFromCfg(1108106152).content)

				arg_633_1.text_.text = var_636_1

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_3 = 6 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_1) / 6)

				if (6 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_1) / 6)) > 0 and var_636_0 < var_636_3 then
					arg_633_1.talkMaxDuration = var_636_3

					if var_636_3 + 0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_3 + 0
					end
				end

				arg_633_1.text_.text = var_636_1
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_4 = math.max(var_636_0, arg_633_1.talkMaxDuration)

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_4 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - 0) / var_636_4

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= 0 + var_636_4 and arg_633_1.time_ < 0 + var_636_4 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1108106153 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1108106153
		arg_637_1.duration_ = 5.57

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1108106154(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.6

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_1 = arg_637_1:GetWordFromCfg(1108106153)
				local var_640_2 = arg_637_1:FormatText(var_640_1.content)

				arg_637_1.text_.text = var_640_2

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_4 = 24 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 24)

				if (24 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 24)) > 0 and var_640_0 < var_640_4 then
					arg_637_1.talkMaxDuration = var_640_4

					if var_640_4 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_4 + 0
					end
				end

				arg_637_1.text_.text = var_640_2
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb") ~= 0 then
					local var_640_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb") / 1000

					if var_640_5 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + 0
					end

					if var_640_1.prefab_name ~= "" and arg_637_1.actors_[var_640_1.prefab_name] ~= nil then
						local var_640_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_1.prefab_name].transform, "story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")

						arg_637_1:RecordAudio("1108106153", var_640_6)
						arg_637_1:RecordAudio("1108106153", var_640_6)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_7 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_7 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_7

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_7 and arg_637_1.time_ < 0 + var_640_7 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1108106154 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1108106154
		arg_641_1.duration_ = 2.9

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1108106155(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0.35

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_1 = arg_641_1:GetWordFromCfg(1108106154)
				local var_644_2 = arg_641_1:FormatText(var_644_1.content)

				arg_641_1.text_.text = var_644_2

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_4 = 14 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 14)

				if (14 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_2) / 14)) > 0 and var_644_0 < var_644_4 then
					arg_641_1.talkMaxDuration = var_644_4

					if var_644_4 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_4 + 0
					end
				end

				arg_641_1.text_.text = var_644_2
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb") ~= 0 then
					local var_644_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb") / 1000

					if var_644_5 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_5 + 0
					end

					if var_644_1.prefab_name ~= "" and arg_641_1.actors_[var_644_1.prefab_name] ~= nil then
						local var_644_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_1.prefab_name].transform, "story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")

						arg_641_1:RecordAudio("1108106154", var_644_6)
						arg_641_1:RecordAudio("1108106154", var_644_6)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_7 = math.max(var_644_0, arg_641_1.talkMaxDuration)

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_7 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - 0) / var_644_7

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= 0 + var_644_7 and arg_641_1.time_ < 0 + var_644_7 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1108106155 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1108106155
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1108106156(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.125

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(1108106155).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 5 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 5)

				if (5 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 5)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1108106156 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1108106156
		arg_649_1.duration_ = 6.3

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1108106157(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.8

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:GetWordFromCfg(1108106156)
				local var_652_2 = arg_649_1:FormatText(var_652_1.content)

				arg_649_1.text_.text = var_652_2

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 32 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_2) / 32)

				if (32 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_2) / 32)) > 0 and var_652_0 < var_652_4 then
					arg_649_1.talkMaxDuration = var_652_4

					if var_652_4 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_4 + 0
					end
				end

				arg_649_1.text_.text = var_652_2
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb") ~= 0 then
					local var_652_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb") / 1000

					if var_652_5 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_5 + 0
					end

					if var_652_1.prefab_name ~= "" and arg_649_1.actors_[var_652_1.prefab_name] ~= nil then
						local var_652_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_1.prefab_name].transform, "story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")

						arg_649_1:RecordAudio("1108106156", var_652_6)
						arg_649_1:RecordAudio("1108106156", var_652_6)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_7 and arg_649_1.time_ < 0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1108106157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1108106157
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1108106158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0.925

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(1108106157).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 37 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 37)

				if (37 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 37)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1108106158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1108106158
		arg_657_1.duration_ = 2.3

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1108106159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0.325

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_1 = arg_657_1:GetWordFromCfg(1108106158)
				local var_660_2 = arg_657_1:FormatText(var_660_1.content)

				arg_657_1.text_.text = var_660_2

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_4 = 13 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 13)

				if (13 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 13)) > 0 and var_660_0 < var_660_4 then
					arg_657_1.talkMaxDuration = var_660_4

					if var_660_4 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_4 + 0
					end
				end

				arg_657_1.text_.text = var_660_2
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb") ~= 0 then
					local var_660_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb") / 1000

					if var_660_5 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + 0
					end

					if var_660_1.prefab_name ~= "" and arg_657_1.actors_[var_660_1.prefab_name] ~= nil then
						local var_660_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_1.prefab_name].transform, "story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")

						arg_657_1:RecordAudio("1108106158", var_660_6)
						arg_657_1:RecordAudio("1108106158", var_660_6)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_7 = math.max(var_660_0, arg_657_1.talkMaxDuration)

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_7 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - 0) / var_660_7

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= 0 + var_660_7 and arg_657_1.time_ < 0 + var_660_7 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1108106159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1108106159
		arg_661_1.duration_ = 3.5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1108106160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0.375

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_1 = arg_661_1:GetWordFromCfg(1108106159)
				local var_664_2 = arg_661_1:FormatText(var_664_1.content)

				arg_661_1.text_.text = var_664_2

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_4 = 15 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_2) / 15)

				if (15 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_2) / 15)) > 0 and var_664_0 < var_664_4 then
					arg_661_1.talkMaxDuration = var_664_4

					if var_664_4 + 0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_4 + 0
					end
				end

				arg_661_1.text_.text = var_664_2
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb") ~= 0 then
					local var_664_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb") / 1000

					if var_664_5 + 0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_5 + 0
					end

					if var_664_1.prefab_name ~= "" and arg_661_1.actors_[var_664_1.prefab_name] ~= nil then
						local var_664_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_1.prefab_name].transform, "story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")

						arg_661_1:RecordAudio("1108106159", var_664_6)
						arg_661_1:RecordAudio("1108106159", var_664_6)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_7 = math.max(var_664_0, arg_661_1.talkMaxDuration)

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_7 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - 0) / var_664_7

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= 0 + var_664_7 and arg_661_1.time_ < 0 + var_664_7 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1108106160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1108106160
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1108106161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0.7

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_1 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(1108106160).content)

				arg_665_1.text_.text = var_668_1

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_3 = 28 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 28)

				if (28 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 28)) > 0 and var_668_0 < var_668_3 then
					arg_665_1.talkMaxDuration = var_668_3

					if var_668_3 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_3 + 0
					end
				end

				arg_665_1.text_.text = var_668_1
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_4 = math.max(var_668_0, arg_665_1.talkMaxDuration)

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_4 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - 0) / var_668_4

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= 0 + var_668_4 and arg_665_1.time_ < 0 + var_668_4 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1108106161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1108106161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1108106162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0.725

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_1 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(1108106161).content)

				arg_669_1.text_.text = var_672_1

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_3 = 29 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 29)

				if (29 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 29)) > 0 and var_672_0 < var_672_3 then
					arg_669_1.talkMaxDuration = var_672_3

					if var_672_3 + 0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_3 + 0
					end
				end

				arg_669_1.text_.text = var_672_1
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_4 = math.max(var_672_0, arg_669_1.talkMaxDuration)

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_4 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - 0) / var_672_4

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= 0 + var_672_4 and arg_669_1.time_ < 0 + var_672_4 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1108106162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1108106162
		arg_673_1.duration_ = 7.93

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1108106163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 2 < arg_673_1.time_ and arg_673_1.time_ <= 2 + arg_676_0 then
				local var_676_0 = arg_673_1.bgs_.R8102

				arg_673_1.bgs_.R8102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_676_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_676_1 = var_676_0:GetComponent("SpriteRenderer")

				if var_676_1 and var_676_1.sprite then
					local var_676_2 = 2 * (var_676_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_676_0.transform.localScale = Vector3.New(var_676_2 / var_676_1.sprite.bounds.size.y < var_676_2 * manager.ui.mainCameraCom_.aspect / var_676_1.sprite.bounds.size.x and var_676_2 * manager.ui.mainCameraCom_.aspect / var_676_1.sprite.bounds.size.x or var_676_2 / var_676_1.sprite.bounds.size.y, var_676_2 / var_676_1.sprite.bounds.size.y < var_676_2 * manager.ui.mainCameraCom_.aspect / var_676_1.sprite.bounds.size.x and var_676_2 * manager.ui.mainCameraCom_.aspect / var_676_1.sprite.bounds.size.x or var_676_2 / var_676_1.sprite.bounds.size.y, 0)
				end

				for iter_676_0, iter_676_1 in pairs(arg_673_1.bgs_) do
					if iter_676_0 ~= "R8102" then
						iter_676_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_676_3 = 2

			if 2 < arg_673_1.time_ and arg_673_1.time_ <= var_676_3 + arg_676_0 then
				arg_673_1.allBtn_.enabled = false
			end

			if arg_673_1.time_ >= var_676_3 + 0.3 and arg_673_1.time_ < var_676_3 + 0.3 + arg_676_0 then
				arg_673_1.allBtn_.enabled = true
			end

			local var_676_4 = 0

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1.mask_.enabled = true
				arg_673_1.mask_.raycastTarget = true

				arg_673_1:SetGaussion(false)
			end

			local var_676_5 = 2

			if var_676_4 <= arg_673_1.time_ and arg_673_1.time_ < var_676_4 + var_676_5 then
				local var_676_6 = Color.New(0, 0, 0)

				var_676_6.a = Mathf.Lerp(0, 1, (arg_673_1.time_ - var_676_4) / var_676_5)
				arg_673_1.mask_.color = var_676_6
			end

			if arg_673_1.time_ >= var_676_4 + var_676_5 and arg_673_1.time_ < var_676_4 + var_676_5 + arg_676_0 then
				local var_676_7 = Color.New(0, 0, 0)

				var_676_7.a = 1
				arg_673_1.mask_.color = var_676_7
			end

			local var_676_8 = 2

			if 2 < arg_673_1.time_ and arg_673_1.time_ <= var_676_8 + arg_676_0 then
				arg_673_1.mask_.enabled = true
				arg_673_1.mask_.raycastTarget = true

				arg_673_1:SetGaussion(false)
			end

			local var_676_9 = 2

			if var_676_8 <= arg_673_1.time_ and arg_673_1.time_ < var_676_8 + var_676_9 then
				local var_676_10 = Color.New(0, 0, 0)

				var_676_10.a = Mathf.Lerp(1, 0, (arg_673_1.time_ - var_676_8) / var_676_9)
				arg_673_1.mask_.color = var_676_10
			end

			if arg_673_1.time_ >= var_676_8 + var_676_9 and arg_673_1.time_ < var_676_8 + var_676_9 + arg_676_0 then
				local var_676_11 = Color.New(0, 0, 0)

				arg_673_1.mask_.enabled = false
				var_676_11.a = 0
				arg_673_1.mask_.color = var_676_11
			end

			if arg_673_1.frameCnt_ <= 1 then
				arg_673_1.dialog_:SetActive(false)
			end

			local var_676_12 = 2.93333333333333
			local var_676_13 = 0.875

			if 2.93333333333333 < arg_673_1.time_ and arg_673_1.time_ <= var_676_12 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0

				arg_673_1.dialog_:SetActive(true)

				arg_673_1.dialogCg_.alpha = 0

				local var_676_14 = LeanTween.value(arg_673_1.dialog_, 0, 1, 0.3)

				var_676_14:setOnUpdate(LuaHelper.FloatAction(function(arg_677_0)
					arg_673_1.dialogCg_.alpha = arg_677_0
				end))
				var_676_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_673_1.dialog_)
					var_676_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_673_1.duration_ = arg_673_1.duration_ + 0.3

				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_15 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(1108106162).content)

				arg_673_1.text_.text = var_676_15

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_17 = 35 <= 0 and var_676_13 or var_676_13 * (utf8.len(var_676_15) / 35)

				if (35 <= 0 and var_676_13 or var_676_13 * (utf8.len(var_676_15) / 35)) > 0 and var_676_13 < var_676_17 then
					arg_673_1.talkMaxDuration = var_676_17
					var_676_12 = var_676_12 + 0.3

					if var_676_17 + var_676_12 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_17 + var_676_12
					end
				end

				arg_673_1.text_.text = var_676_15
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_18 = var_676_12 + 0.3
			local var_676_19 = math.max(var_676_13, arg_673_1.talkMaxDuration)

			if var_676_12 + 0.3 <= arg_673_1.time_ and arg_673_1.time_ < var_676_18 + var_676_19 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_18) / var_676_19

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_18 + var_676_19 and arg_673_1.time_ < var_676_18 + var_676_19 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1108106163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1108106163
		arg_679_1.duration_ = 7.33

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1108106164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0.825

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_1 = arg_679_1:GetWordFromCfg(1108106163)
				local var_682_2 = arg_679_1:FormatText(var_682_1.content)

				arg_679_1.text_.text = var_682_2

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_4 = 33 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_2) / 33)

				if (33 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_2) / 33)) > 0 and var_682_0 < var_682_4 then
					arg_679_1.talkMaxDuration = var_682_4

					if var_682_4 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_4 + 0
					end
				end

				arg_679_1.text_.text = var_682_2
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb") ~= 0 then
					local var_682_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb") / 1000

					if var_682_5 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_5 + 0
					end

					if var_682_1.prefab_name ~= "" and arg_679_1.actors_[var_682_1.prefab_name] ~= nil then
						local var_682_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_1.prefab_name].transform, "story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")

						arg_679_1:RecordAudio("1108106163", var_682_6)
						arg_679_1:RecordAudio("1108106163", var_682_6)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_7 = math.max(var_682_0, arg_679_1.talkMaxDuration)

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_7 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - 0) / var_682_7

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= 0 + var_682_7 and arg_679_1.time_ < 0 + var_682_7 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1108106164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1108106164
		arg_683_1.duration_ = 6.1

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1108106165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.4

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_1 = arg_683_1:GetWordFromCfg(1108106164)
				local var_686_2 = arg_683_1:FormatText(var_686_1.content)

				arg_683_1.text_.text = var_686_2

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_4 = 16 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_2) / 16)

				if (16 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_2) / 16)) > 0 and var_686_0 < var_686_4 then
					arg_683_1.talkMaxDuration = var_686_4

					if var_686_4 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_4 + 0
					end
				end

				arg_683_1.text_.text = var_686_2
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb") ~= 0 then
					local var_686_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb") / 1000

					if var_686_5 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_5 + 0
					end

					if var_686_1.prefab_name ~= "" and arg_683_1.actors_[var_686_1.prefab_name] ~= nil then
						local var_686_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_1.prefab_name].transform, "story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")

						arg_683_1:RecordAudio("1108106164", var_686_6)
						arg_683_1:RecordAudio("1108106164", var_686_6)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_7 and arg_683_1.time_ < 0 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1108106165 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1108106165
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1108106166(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0.225

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_1 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(1108106165).content)

				arg_687_1.text_.text = var_690_1

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_3 = 9 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 9)

				if (9 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 9)) > 0 and var_690_0 < var_690_3 then
					arg_687_1.talkMaxDuration = var_690_3

					if var_690_3 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_3 + 0
					end
				end

				arg_687_1.text_.text = var_690_1
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_4 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_4

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1108106166 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1108106166
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1108106167(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0.35

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, true)
				arg_691_1.iconController_:SetSelectedState("hero")

				arg_691_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_691_1.callingController_:SetSelectedState("normal")

				arg_691_1.keyicon_.color = Color.New(1, 1, 1)
				arg_691_1.icon_.color = Color.New(1, 1, 1)

				local var_694_1 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(1108106166).content)

				arg_691_1.text_.text = var_694_1

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_3 = 14 <= 0 and var_694_0 or var_694_0 * (utf8.len(var_694_1) / 14)

				if (14 <= 0 and var_694_0 or var_694_0 * (utf8.len(var_694_1) / 14)) > 0 and var_694_0 < var_694_3 then
					arg_691_1.talkMaxDuration = var_694_3

					if var_694_3 + 0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_3 + 0
					end
				end

				arg_691_1.text_.text = var_694_1
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_4 = math.max(var_694_0, arg_691_1.talkMaxDuration)

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_4 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - 0) / var_694_4

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= 0 + var_694_4 and arg_691_1.time_ < 0 + var_694_4 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1108106167 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1108106167
		arg_695_1.duration_ = 3.93

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1108106168(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0.525

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:GetWordFromCfg(1108106167)
				local var_698_2 = arg_695_1:FormatText(var_698_1.content)

				arg_695_1.text_.text = var_698_2

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_4 = 21 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 21)

				if (21 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_2) / 21)) > 0 and var_698_0 < var_698_4 then
					arg_695_1.talkMaxDuration = var_698_4

					if var_698_4 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_4 + 0
					end
				end

				arg_695_1.text_.text = var_698_2
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb") ~= 0 then
					local var_698_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb") / 1000

					if var_698_5 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_5 + 0
					end

					if var_698_1.prefab_name ~= "" and arg_695_1.actors_[var_698_1.prefab_name] ~= nil then
						local var_698_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_1.prefab_name].transform, "story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")

						arg_695_1:RecordAudio("1108106167", var_698_6)
						arg_695_1:RecordAudio("1108106167", var_698_6)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_7 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_7 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_7

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_7 and arg_695_1.time_ < 0 + var_698_7 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1108106168 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1108106168
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1108106169(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0.275

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, true)
				arg_699_1.iconController_:SetSelectedState("hero")

				arg_699_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_699_1.callingController_:SetSelectedState("normal")

				arg_699_1.keyicon_.color = Color.New(1, 1, 1)
				arg_699_1.icon_.color = Color.New(1, 1, 1)

				local var_702_1 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(1108106168).content)

				arg_699_1.text_.text = var_702_1

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_3 = 11 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_1) / 11)

				if (11 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_1) / 11)) > 0 and var_702_0 < var_702_3 then
					arg_699_1.talkMaxDuration = var_702_3

					if var_702_3 + 0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_3 + 0
					end
				end

				arg_699_1.text_.text = var_702_1
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_4 = math.max(var_702_0, arg_699_1.talkMaxDuration)

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_4 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - 0) / var_702_4

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= 0 + var_702_4 and arg_699_1.time_ < 0 + var_702_4 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1108106169 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1108106169
		arg_703_1.duration_ = 8.03

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1108106170(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if arg_703_1.bgs_.R8102b == nil then
				local var_706_0 = Object.Instantiate(arg_703_1.paintGo_)

				var_706_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8102b")
				var_706_0.name = "R8102b"
				var_706_0.transform.parent = arg_703_1.stage_.transform
				var_706_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_703_1.bgs_.R8102b = var_706_0
			end

			if 1.96666666666667 < arg_703_1.time_ and arg_703_1.time_ <= 1.96666666666667 + arg_706_0 then
				local var_706_1 = arg_703_1.bgs_.R8102b

				arg_703_1.bgs_.R8102b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_706_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_706_2 = var_706_1:GetComponent("SpriteRenderer")

				if var_706_2 and var_706_2.sprite then
					local var_706_3 = 2 * (var_706_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_706_1.transform.localScale = Vector3.New(var_706_3 / var_706_2.sprite.bounds.size.y < var_706_3 * manager.ui.mainCameraCom_.aspect / var_706_2.sprite.bounds.size.x and var_706_3 * manager.ui.mainCameraCom_.aspect / var_706_2.sprite.bounds.size.x or var_706_3 / var_706_2.sprite.bounds.size.y, var_706_3 / var_706_2.sprite.bounds.size.y < var_706_3 * manager.ui.mainCameraCom_.aspect / var_706_2.sprite.bounds.size.x and var_706_3 * manager.ui.mainCameraCom_.aspect / var_706_2.sprite.bounds.size.x or var_706_3 / var_706_2.sprite.bounds.size.y, 0)
				end

				for iter_706_0, iter_706_1 in pairs(arg_703_1.bgs_) do
					if iter_706_0 ~= "R8102b" then
						iter_706_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_706_4 = 1.96666666666667

			if 1.96666666666667 < arg_703_1.time_ and arg_703_1.time_ <= var_706_4 + arg_706_0 then
				arg_703_1.allBtn_.enabled = false
			end

			if arg_703_1.time_ >= var_706_4 + 0.3 and arg_703_1.time_ < var_706_4 + 0.3 + arg_706_0 then
				arg_703_1.allBtn_.enabled = true
			end

			local var_706_5 = 0

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_5 + arg_706_0 then
				arg_703_1.mask_.enabled = true
				arg_703_1.mask_.raycastTarget = true

				arg_703_1:SetGaussion(false)
			end

			local var_706_6 = 1.96666666666667

			if var_706_5 <= arg_703_1.time_ and arg_703_1.time_ < var_706_5 + var_706_6 then
				local var_706_7 = Color.New(0, 0, 0)

				var_706_7.a = Mathf.Lerp(0, 1, (arg_703_1.time_ - var_706_5) / var_706_6)
				arg_703_1.mask_.color = var_706_7
			end

			if arg_703_1.time_ >= var_706_5 + var_706_6 and arg_703_1.time_ < var_706_5 + var_706_6 + arg_706_0 then
				local var_706_8 = Color.New(0, 0, 0)

				var_706_8.a = 1
				arg_703_1.mask_.color = var_706_8
			end

			local var_706_9 = 1.96666666666667

			if 1.96666666666667 < arg_703_1.time_ and arg_703_1.time_ <= var_706_9 + arg_706_0 then
				arg_703_1.mask_.enabled = true
				arg_703_1.mask_.raycastTarget = true

				arg_703_1:SetGaussion(false)
			end

			local var_706_10 = 2

			if var_706_9 <= arg_703_1.time_ and arg_703_1.time_ < var_706_9 + var_706_10 then
				local var_706_11 = Color.New(0, 0, 0)

				var_706_11.a = Mathf.Lerp(1, 0, (arg_703_1.time_ - var_706_9) / var_706_10)
				arg_703_1.mask_.color = var_706_11
			end

			if arg_703_1.time_ >= var_706_9 + var_706_10 and arg_703_1.time_ < var_706_9 + var_706_10 + arg_706_0 then
				local var_706_12 = Color.New(0, 0, 0)

				arg_703_1.mask_.enabled = false
				var_706_12.a = 0
				arg_703_1.mask_.color = var_706_12
			end

			if arg_703_1.frameCnt_ <= 1 then
				arg_703_1.dialog_:SetActive(false)
			end

			local var_706_13 = 3.03333333333333
			local var_706_14 = 0.775

			if 3.03333333333333 < arg_703_1.time_ and arg_703_1.time_ <= var_706_13 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0

				arg_703_1.dialog_:SetActive(true)

				arg_703_1.dialogCg_.alpha = 0

				local var_706_15 = LeanTween.value(arg_703_1.dialog_, 0, 1, 0.3)

				var_706_15:setOnUpdate(LuaHelper.FloatAction(function(arg_707_0)
					arg_703_1.dialogCg_.alpha = arg_707_0
				end))
				var_706_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_703_1.dialog_)
					var_706_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_703_1.duration_ = arg_703_1.duration_ + 0.3

				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_16 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(1108106169).content)

				arg_703_1.text_.text = var_706_16

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_18 = 31 <= 0 and var_706_14 or var_706_14 * (utf8.len(var_706_16) / 31)

				if (31 <= 0 and var_706_14 or var_706_14 * (utf8.len(var_706_16) / 31)) > 0 and var_706_14 < var_706_18 then
					arg_703_1.talkMaxDuration = var_706_18
					var_706_13 = var_706_13 + 0.3

					if var_706_18 + var_706_13 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_18 + var_706_13
					end
				end

				arg_703_1.text_.text = var_706_16
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_19 = var_706_13 + 0.3
			local var_706_20 = math.max(var_706_14, arg_703_1.talkMaxDuration)

			if var_706_13 + 0.3 <= arg_703_1.time_ and arg_703_1.time_ < var_706_19 + var_706_20 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_19) / var_706_20

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_19 + var_706_20 and arg_703_1.time_ < var_706_19 + var_706_20 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1108106170 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1108106170
		arg_709_1.duration_ = 5.6

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1108106171(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0.825

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_1 = arg_709_1:GetWordFromCfg(1108106170)
				local var_712_2 = arg_709_1:FormatText(var_712_1.content)

				arg_709_1.text_.text = var_712_2

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_4 = 33 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 33)

				if (33 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_2) / 33)) > 0 and var_712_0 < var_712_4 then
					arg_709_1.talkMaxDuration = var_712_4

					if var_712_4 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_4 + 0
					end
				end

				arg_709_1.text_.text = var_712_2
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb") ~= 0 then
					local var_712_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb") / 1000

					if var_712_5 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + 0
					end

					if var_712_1.prefab_name ~= "" and arg_709_1.actors_[var_712_1.prefab_name] ~= nil then
						local var_712_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_1.prefab_name].transform, "story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")

						arg_709_1:RecordAudio("1108106170", var_712_6)
						arg_709_1:RecordAudio("1108106170", var_712_6)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_7 = math.max(var_712_0, arg_709_1.talkMaxDuration)

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_7 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - 0) / var_712_7

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= 0 + var_712_7 and arg_709_1.time_ < 0 + var_712_7 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1108106171 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1108106171
		arg_713_1.duration_ = 5.9

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1108106172(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.725

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_1 = arg_713_1:GetWordFromCfg(1108106171)
				local var_716_2 = arg_713_1:FormatText(var_716_1.content)

				arg_713_1.text_.text = var_716_2

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_4 = 29 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_2) / 29)

				if (29 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_2) / 29)) > 0 and var_716_0 < var_716_4 then
					arg_713_1.talkMaxDuration = var_716_4

					if var_716_4 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_4 + 0
					end
				end

				arg_713_1.text_.text = var_716_2
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb") ~= 0 then
					local var_716_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb") / 1000

					if var_716_5 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_5 + 0
					end

					if var_716_1.prefab_name ~= "" and arg_713_1.actors_[var_716_1.prefab_name] ~= nil then
						local var_716_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_1.prefab_name].transform, "story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")

						arg_713_1:RecordAudio("1108106171", var_716_6)
						arg_713_1:RecordAudio("1108106171", var_716_6)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_7 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_7 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_7

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_7 and arg_713_1.time_ < 0 + var_716_7 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1108106172 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1108106172
		arg_717_1.duration_ = 3.07

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1108106173(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.3

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_1 = arg_717_1:GetWordFromCfg(1108106172)
				local var_720_2 = arg_717_1:FormatText(var_720_1.content)

				arg_717_1.text_.text = var_720_2

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_4 = 12 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 12)

				if (12 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_2) / 12)) > 0 and var_720_0 < var_720_4 then
					arg_717_1.talkMaxDuration = var_720_4

					if var_720_4 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_4 + 0
					end
				end

				arg_717_1.text_.text = var_720_2
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb") ~= 0 then
					local var_720_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb") / 1000

					if var_720_5 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_5 + 0
					end

					if var_720_1.prefab_name ~= "" and arg_717_1.actors_[var_720_1.prefab_name] ~= nil then
						local var_720_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_1.prefab_name].transform, "story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")

						arg_717_1:RecordAudio("1108106172", var_720_6)
						arg_717_1:RecordAudio("1108106172", var_720_6)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_7 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_7 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_7

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_7 and arg_717_1.time_ < 0 + var_720_7 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1108106173 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1108106173
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1108106174(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 1.2

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_1 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(1108106173).content)

				arg_721_1.text_.text = var_724_1

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_3 = 48 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 48)

				if (48 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 48)) > 0 and var_724_0 < var_724_3 then
					arg_721_1.talkMaxDuration = var_724_3

					if var_724_3 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_3 + 0
					end
				end

				arg_721_1.text_.text = var_724_1
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_4 = math.max(var_724_0, arg_721_1.talkMaxDuration)

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_4 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - 0) / var_724_4

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= 0 + var_724_4 and arg_721_1.time_ < 0 + var_724_4 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1108106174 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1108106174
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1108106175(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 0.05

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, true)
				arg_725_1.iconController_:SetSelectedState("hero")

				arg_725_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_725_1.callingController_:SetSelectedState("normal")

				arg_725_1.keyicon_.color = Color.New(1, 1, 1)
				arg_725_1.icon_.color = Color.New(1, 1, 1)

				local var_728_1 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(1108106174).content)

				arg_725_1.text_.text = var_728_1

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_3 = 2 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 2)

				if (2 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 2)) > 0 and var_728_0 < var_728_3 then
					arg_725_1.talkMaxDuration = var_728_3

					if var_728_3 + 0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_3 + 0
					end
				end

				arg_725_1.text_.text = var_728_1
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_4 = math.max(var_728_0, arg_725_1.talkMaxDuration)

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_4 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - 0) / var_728_4

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= 0 + var_728_4 and arg_725_1.time_ < 0 + var_728_4 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play1108106175 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1108106175
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1108106176(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0.425

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_1 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(1108106175).content)

				arg_729_1.text_.text = var_732_1

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_3 = 17 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 17)

				if (17 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 17)) > 0 and var_732_0 < var_732_3 then
					arg_729_1.talkMaxDuration = var_732_3

					if var_732_3 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_3 + 0
					end
				end

				arg_729_1.text_.text = var_732_1
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_4 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_4 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_4

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_4 and arg_729_1.time_ < 0 + var_732_4 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1108106176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1108106176
		arg_733_1.duration_ = 5.13

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1108106177(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 0.55

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_1 = arg_733_1:GetWordFromCfg(1108106176)
				local var_736_2 = arg_733_1:FormatText(var_736_1.content)

				arg_733_1.text_.text = var_736_2

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_4 = 22 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_2) / 22)

				if (22 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_2) / 22)) > 0 and var_736_0 < var_736_4 then
					arg_733_1.talkMaxDuration = var_736_4

					if var_736_4 + 0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_4 + 0
					end
				end

				arg_733_1.text_.text = var_736_2
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb") ~= 0 then
					local var_736_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb") / 1000

					if var_736_5 + 0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_5 + 0
					end

					if var_736_1.prefab_name ~= "" and arg_733_1.actors_[var_736_1.prefab_name] ~= nil then
						local var_736_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_733_1.actors_[var_736_1.prefab_name].transform, "story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")

						arg_733_1:RecordAudio("1108106176", var_736_6)
						arg_733_1:RecordAudio("1108106176", var_736_6)
					else
						arg_733_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")
					end

					arg_733_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")
				end

				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_7 = math.max(var_736_0, arg_733_1.talkMaxDuration)

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_7 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - 0) / var_736_7

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= 0 + var_736_7 and arg_733_1.time_ < 0 + var_736_7 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play1108106177 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1108106177
		arg_737_1.duration_ = 3.5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1108106178(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0.3

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_1 = arg_737_1:GetWordFromCfg(1108106177)
				local var_740_2 = arg_737_1:FormatText(var_740_1.content)

				arg_737_1.text_.text = var_740_2

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_4 = 12 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_2) / 12)

				if (12 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_2) / 12)) > 0 and var_740_0 < var_740_4 then
					arg_737_1.talkMaxDuration = var_740_4

					if var_740_4 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_4 + 0
					end
				end

				arg_737_1.text_.text = var_740_2
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb") ~= 0 then
					local var_740_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb") / 1000

					if var_740_5 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_5 + 0
					end

					if var_740_1.prefab_name ~= "" and arg_737_1.actors_[var_740_1.prefab_name] ~= nil then
						local var_740_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_1.prefab_name].transform, "story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")

						arg_737_1:RecordAudio("1108106177", var_740_6)
						arg_737_1:RecordAudio("1108106177", var_740_6)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_7 = math.max(var_740_0, arg_737_1.talkMaxDuration)

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_7 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - 0) / var_740_7

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= 0 + var_740_7 and arg_737_1.time_ < 0 + var_740_7 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1108106178 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1108106178
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1108106179(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0.275

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, true)
				arg_741_1.iconController_:SetSelectedState("hero")

				arg_741_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_741_1.callingController_:SetSelectedState("normal")

				arg_741_1.keyicon_.color = Color.New(1, 1, 1)
				arg_741_1.icon_.color = Color.New(1, 1, 1)

				local var_744_1 = arg_741_1:FormatText(arg_741_1:GetWordFromCfg(1108106178).content)

				arg_741_1.text_.text = var_744_1

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_3 = 11 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_1) / 11)

				if (11 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_1) / 11)) > 0 and var_744_0 < var_744_3 then
					arg_741_1.talkMaxDuration = var_744_3

					if var_744_3 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_3 + 0
					end
				end

				arg_741_1.text_.text = var_744_1
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_4 = math.max(var_744_0, arg_741_1.talkMaxDuration)

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_4 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - 0) / var_744_4

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= 0 + var_744_4 and arg_741_1.time_ < 0 + var_744_4 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1108106179 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1108106179
		arg_745_1.duration_ = 4

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1108106180(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0.45

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_1 = arg_745_1:GetWordFromCfg(1108106179)
				local var_748_2 = arg_745_1:FormatText(var_748_1.content)

				arg_745_1.text_.text = var_748_2

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_4 = 18 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_2) / 18)

				if (18 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_2) / 18)) > 0 and var_748_0 < var_748_4 then
					arg_745_1.talkMaxDuration = var_748_4

					if var_748_4 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_4 + 0
					end
				end

				arg_745_1.text_.text = var_748_2
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb") ~= 0 then
					local var_748_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb") / 1000

					if var_748_5 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_5 + 0
					end

					if var_748_1.prefab_name ~= "" and arg_745_1.actors_[var_748_1.prefab_name] ~= nil then
						local var_748_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_745_1.actors_[var_748_1.prefab_name].transform, "story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")

						arg_745_1:RecordAudio("1108106179", var_748_6)
						arg_745_1:RecordAudio("1108106179", var_748_6)
					else
						arg_745_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")
					end

					arg_745_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")
				end

				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_7 = math.max(var_748_0, arg_745_1.talkMaxDuration)

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_7 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - 0) / var_748_7

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= 0 + var_748_7 and arg_745_1.time_ < 0 + var_748_7 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1108106180 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1108106180
		arg_749_1.duration_ = 6.2

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1108106181(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 then
				local var_752_0 = arg_749_1.bgs_.H01b

				arg_749_1.bgs_.H01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_752_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_752_1 = var_752_0:GetComponent("SpriteRenderer")

				if var_752_1 and var_752_1.sprite then
					local var_752_2 = 2 * (var_752_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_752_0.transform.localScale = Vector3.New(var_752_2 / var_752_1.sprite.bounds.size.y < var_752_2 * manager.ui.mainCameraCom_.aspect / var_752_1.sprite.bounds.size.x and var_752_2 * manager.ui.mainCameraCom_.aspect / var_752_1.sprite.bounds.size.x or var_752_2 / var_752_1.sprite.bounds.size.y, var_752_2 / var_752_1.sprite.bounds.size.y < var_752_2 * manager.ui.mainCameraCom_.aspect / var_752_1.sprite.bounds.size.x and var_752_2 * manager.ui.mainCameraCom_.aspect / var_752_1.sprite.bounds.size.x or var_752_2 / var_752_1.sprite.bounds.size.y, 0)
				end

				for iter_752_0, iter_752_1 in pairs(arg_749_1.bgs_) do
					if iter_752_0 ~= "H01b" then
						iter_752_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_752_3 = 1

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= var_752_3 + arg_752_0 then
				arg_749_1.allBtn_.enabled = false
			end

			if arg_749_1.time_ >= var_752_3 + 0.3 and arg_749_1.time_ < var_752_3 + 0.3 + arg_752_0 then
				arg_749_1.allBtn_.enabled = true
			end

			local var_752_4 = 0

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_4 + arg_752_0 then
				arg_749_1.mask_.enabled = true
				arg_749_1.mask_.raycastTarget = true

				arg_749_1:SetGaussion(false)
			end

			local var_752_5 = 1

			if var_752_4 <= arg_749_1.time_ and arg_749_1.time_ < var_752_4 + var_752_5 then
				local var_752_6 = Color.New(0, 0, 0)

				var_752_6.a = Mathf.Lerp(0, 1, (arg_749_1.time_ - var_752_4) / var_752_5)
				arg_749_1.mask_.color = var_752_6
			end

			if arg_749_1.time_ >= var_752_4 + var_752_5 and arg_749_1.time_ < var_752_4 + var_752_5 + arg_752_0 then
				local var_752_7 = Color.New(0, 0, 0)

				var_752_7.a = 1
				arg_749_1.mask_.color = var_752_7
			end

			local var_752_8 = 1

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= var_752_8 + arg_752_0 then
				arg_749_1.mask_.enabled = true
				arg_749_1.mask_.raycastTarget = true

				arg_749_1:SetGaussion(false)
			end

			local var_752_9 = 1.93333333333333

			if var_752_8 <= arg_749_1.time_ and arg_749_1.time_ < var_752_8 + var_752_9 then
				local var_752_10 = Color.New(0, 0, 0)

				var_752_10.a = Mathf.Lerp(1, 0, (arg_749_1.time_ - var_752_8) / var_752_9)
				arg_749_1.mask_.color = var_752_10
			end

			if arg_749_1.time_ >= var_752_8 + var_752_9 and arg_749_1.time_ < var_752_8 + var_752_9 + arg_752_0 then
				local var_752_11 = Color.New(0, 0, 0)

				arg_749_1.mask_.enabled = false
				var_752_11.a = 0
				arg_749_1.mask_.color = var_752_11
			end

			local var_752_12 = arg_749_1.actors_["1081ui_story"].transform

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 then
				arg_749_1.var_.moveOldPos1081ui_story = var_752_12.localPosition
			end

			local var_752_13 = 0.001

			if 1 <= arg_749_1.time_ and arg_749_1.time_ < 1 + var_752_13 then
				var_752_12.localPosition = Vector3.Lerp(arg_749_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_749_1.time_ - 1) / var_752_13)
				var_752_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_752_12.position).x, (manager.ui.mainCamera.transform.position - var_752_12.position).y, (manager.ui.mainCamera.transform.position - var_752_12.position).z)
				var_752_12.localEulerAngles.z = 0
				var_752_12.localEulerAngles.x = 0
				var_752_12.localEulerAngles = var_752_12.localEulerAngles
			end

			if arg_749_1.time_ >= 1 + var_752_13 and arg_749_1.time_ < 1 + var_752_13 + arg_752_0 then
				var_752_12.localPosition = Vector3.New(0, -0.92, -5.8)
				var_752_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_752_12.position).x, (manager.ui.mainCamera.transform.position - var_752_12.position).y, (manager.ui.mainCamera.transform.position - var_752_12.position).z)
				var_752_12.localEulerAngles.z = 0
				var_752_12.localEulerAngles.x = 0
				var_752_12.localEulerAngles = var_752_12.localEulerAngles
			end

			local var_752_14 = arg_749_1.actors_["1081ui_story"]

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 and not isNil(var_752_14) and arg_749_1.var_.characterEffect1081ui_story == nil then
				arg_749_1.var_.characterEffect1081ui_story = var_752_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_15 = 0.2

			if 1 <= arg_749_1.time_ and arg_749_1.time_ < 1 + var_752_15 and not isNil(var_752_14) then
				if arg_749_1.var_.characterEffect1081ui_story and not isNil(var_752_14) then
					arg_749_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_749_1.time_ >= 1 + var_752_15 and arg_749_1.time_ < 1 + var_752_15 + arg_752_0 and not isNil(var_752_14) and arg_749_1.var_.characterEffect1081ui_story then
				arg_749_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 then
				arg_749_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 then
				arg_749_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			if 1 < arg_749_1.time_ and arg_749_1.time_ <= 1 + arg_752_0 then
				arg_749_1:AudioAction("stop", "effect", "se_story_123_01", "se_story_123_01_flame1", "")
			end

			if arg_749_1.frameCnt_ <= 1 then
				arg_749_1.dialog_:SetActive(false)
			end

			local var_752_18 = 1.2
			local var_752_19 = 0.55

			if 1.2 < arg_749_1.time_ and arg_749_1.time_ <= var_752_18 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0

				arg_749_1.dialog_:SetActive(true)

				arg_749_1.dialogCg_.alpha = 0

				local var_752_20 = LeanTween.value(arg_749_1.dialog_, 0, 1, 0.3)

				var_752_20:setOnUpdate(LuaHelper.FloatAction(function(arg_753_0)
					arg_749_1.dialogCg_.alpha = arg_753_0
				end))
				var_752_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_749_1.dialog_)
					var_752_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_749_1.duration_ = arg_749_1.duration_ + 0.3

				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_21 = arg_749_1:GetWordFromCfg(1108106180)
				local var_752_22 = arg_749_1:FormatText(var_752_21.content)

				arg_749_1.text_.text = var_752_22

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_24 = 22 <= 0 and var_752_19 or var_752_19 * (utf8.len(var_752_22) / 22)

				if (22 <= 0 and var_752_19 or var_752_19 * (utf8.len(var_752_22) / 22)) > 0 and var_752_19 < var_752_24 then
					arg_749_1.talkMaxDuration = var_752_24
					var_752_18 = var_752_18 + 0.3

					if var_752_24 + var_752_18 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_24 + var_752_18
					end
				end

				arg_749_1.text_.text = var_752_22
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb") ~= 0 then
					local var_752_25 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb") / 1000

					if var_752_25 + var_752_18 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_25 + var_752_18
					end

					if var_752_21.prefab_name ~= "" and arg_749_1.actors_[var_752_21.prefab_name] ~= nil then
						local var_752_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_749_1.actors_[var_752_21.prefab_name].transform, "story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")

						arg_749_1:RecordAudio("1108106180", var_752_26)
						arg_749_1:RecordAudio("1108106180", var_752_26)
					else
						arg_749_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")
					end

					arg_749_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")
				end

				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_27 = var_752_18 + 0.3
			local var_752_28 = math.max(var_752_19, arg_749_1.talkMaxDuration)

			if var_752_18 + 0.3 <= arg_749_1.time_ and arg_749_1.time_ < var_752_27 + var_752_28 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_27) / var_752_28

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_27 + var_752_28 and arg_749_1.time_ < var_752_27 + var_752_28 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_749_1:InitPlayNodeList()
	end,
	Play1108106181 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 1108106181
		arg_755_1.duration_ = 2.93

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play1108106182(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 then
				arg_755_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_2")
			end

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 then
				arg_755_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_758_0 = 0
			local var_758_1 = 0.225

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_0 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				arg_755_1.leftNameTxt_.text = arg_755_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_2 = arg_755_1:GetWordFromCfg(1108106181)
				local var_758_3 = arg_755_1:FormatText(var_758_2.content)

				arg_755_1.text_.text = var_758_3

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 9 <= 0 and var_758_1 or var_758_1 * (utf8.len(var_758_3) / 9)

				if (9 <= 0 and var_758_1 or var_758_1 * (utf8.len(var_758_3) / 9)) > 0 and var_758_1 < var_758_5 then
					arg_755_1.talkMaxDuration = var_758_5

					if var_758_5 + var_758_0 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_5 + var_758_0
					end
				end

				arg_755_1.text_.text = var_758_3
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb") ~= 0 then
					local var_758_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb") / 1000

					if var_758_6 + var_758_0 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_6 + var_758_0
					end

					if var_758_2.prefab_name ~= "" and arg_755_1.actors_[var_758_2.prefab_name] ~= nil then
						local var_758_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_755_1.actors_[var_758_2.prefab_name].transform, "story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")

						arg_755_1:RecordAudio("1108106181", var_758_7)
						arg_755_1:RecordAudio("1108106181", var_758_7)
					else
						arg_755_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")
					end

					arg_755_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")
				end

				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_8 = math.max(var_758_1, arg_755_1.talkMaxDuration)

			if var_758_0 <= arg_755_1.time_ and arg_755_1.time_ < var_758_0 + var_758_8 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_0) / var_758_8

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_0 + var_758_8 and arg_755_1.time_ < var_758_0 + var_758_8 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play1108106182 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 1108106182
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play1108106183(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1.var_.moveOldPos1081ui_story = arg_759_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_762_0 = 0.001

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_0 then
				arg_759_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_759_1.time_ - 0) / var_762_0)
				arg_759_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).z)
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles = arg_759_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_759_1.time_ >= 0 + var_762_0 and arg_759_1.time_ < 0 + var_762_0 + arg_762_0 then
				arg_759_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_759_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_759_1.actors_["1081ui_story"].transform.position).z)
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_759_1.actors_["1081ui_story"].transform.localEulerAngles = arg_759_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_762_1 = 0
			local var_762_2 = 0.7

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, false)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_3 = arg_759_1:FormatText(arg_759_1:GetWordFromCfg(1108106182).content)

				arg_759_1.text_.text = var_762_3

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_5 = 28 <= 0 and var_762_2 or var_762_2 * (utf8.len(var_762_3) / 28)

				if (28 <= 0 and var_762_2 or var_762_2 * (utf8.len(var_762_3) / 28)) > 0 and var_762_2 < var_762_5 then
					arg_759_1.talkMaxDuration = var_762_5

					if var_762_5 + var_762_1 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_5 + var_762_1
					end
				end

				arg_759_1.text_.text = var_762_3
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_6 = math.max(var_762_2, arg_759_1.talkMaxDuration)

			if var_762_1 <= arg_759_1.time_ and arg_759_1.time_ < var_762_1 + var_762_6 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_1) / var_762_6

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_1 + var_762_6 and arg_759_1.time_ < var_762_1 + var_762_6 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_759_1:InitPlayNodeList()
	end,
	Play1108106183 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 1108106183
		arg_763_1.duration_ = 1.63

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play1108106184(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0.075

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				arg_763_1.leftNameTxt_.text = arg_763_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, true)
				arg_763_1.iconController_:SetSelectedState("hero")

				arg_763_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_763_1.callingController_:SetSelectedState("normal")

				arg_763_1.keyicon_.color = Color.New(1, 1, 1)
				arg_763_1.icon_.color = Color.New(1, 1, 1)

				local var_766_1 = arg_763_1:GetWordFromCfg(1108106183)
				local var_766_2 = arg_763_1:FormatText(var_766_1.content)

				arg_763_1.text_.text = var_766_2

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_4 = 3 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_2) / 3)

				if (3 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_2) / 3)) > 0 and var_766_0 < var_766_4 then
					arg_763_1.talkMaxDuration = var_766_4

					if var_766_4 + 0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_4 + 0
					end
				end

				arg_763_1.text_.text = var_766_2
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb") ~= 0 then
					local var_766_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb") / 1000

					if var_766_5 + 0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_5 + 0
					end

					if var_766_1.prefab_name ~= "" and arg_763_1.actors_[var_766_1.prefab_name] ~= nil then
						local var_766_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_1.prefab_name].transform, "story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")

						arg_763_1:RecordAudio("1108106183", var_766_6)
						arg_763_1:RecordAudio("1108106183", var_766_6)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_7 = math.max(var_766_0, arg_763_1.talkMaxDuration)

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_7 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - 0) / var_766_7

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= 0 + var_766_7 and arg_763_1.time_ < 0 + var_766_7 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play1108106184 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 1108106184
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play1108106185(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = 0.425

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				arg_767_1.leftNameTxt_.text = arg_767_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, true)
				arg_767_1.iconController_:SetSelectedState("hero")

				arg_767_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_767_1.callingController_:SetSelectedState("normal")

				arg_767_1.keyicon_.color = Color.New(1, 1, 1)
				arg_767_1.icon_.color = Color.New(1, 1, 1)

				local var_770_1 = arg_767_1:FormatText(arg_767_1:GetWordFromCfg(1108106184).content)

				arg_767_1.text_.text = var_770_1

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_3 = 17 <= 0 and var_770_0 or var_770_0 * (utf8.len(var_770_1) / 17)

				if (17 <= 0 and var_770_0 or var_770_0 * (utf8.len(var_770_1) / 17)) > 0 and var_770_0 < var_770_3 then
					arg_767_1.talkMaxDuration = var_770_3

					if var_770_3 + 0 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_3 + 0
					end
				end

				arg_767_1.text_.text = var_770_1
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_4 = math.max(var_770_0, arg_767_1.talkMaxDuration)

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_4 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - 0) / var_770_4

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= 0 + var_770_4 and arg_767_1.time_ < 0 + var_770_4 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play1108106185 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 1108106185
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play1108106186(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0.45

			if 0 < arg_771_1.time_ and arg_771_1.time_ <= 0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, true)

				arg_771_1.leftNameTxt_.text = arg_771_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_771_1.leftNameTxt_.transform)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1.leftNameTxt_.text)
				SetActive(arg_771_1.iconTrs_.gameObject, true)
				arg_771_1.iconController_:SetSelectedState("hero")

				arg_771_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_771_1.callingController_:SetSelectedState("normal")

				arg_771_1.keyicon_.color = Color.New(1, 1, 1)
				arg_771_1.icon_.color = Color.New(1, 1, 1)

				local var_774_1 = arg_771_1:FormatText(arg_771_1:GetWordFromCfg(1108106185).content)

				arg_771_1.text_.text = var_774_1

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_3 = 18 <= 0 and var_774_0 or var_774_0 * (utf8.len(var_774_1) / 18)

				if (18 <= 0 and var_774_0 or var_774_0 * (utf8.len(var_774_1) / 18)) > 0 and var_774_0 < var_774_3 then
					arg_771_1.talkMaxDuration = var_774_3

					if var_774_3 + 0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_3 + 0
					end
				end

				arg_771_1.text_.text = var_774_1
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_4 = math.max(var_774_0, arg_771_1.talkMaxDuration)

			if 0 <= arg_771_1.time_ and arg_771_1.time_ < 0 + var_774_4 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - 0) / var_774_4

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= 0 + var_774_4 and arg_771_1.time_ < 0 + var_774_4 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play1108106186 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 1108106186
		arg_775_1.duration_ = 5

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play1108106187(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			if 0 < arg_775_1.time_ and arg_775_1.time_ <= 0 + arg_778_0 then
				arg_775_1:AudioAction("stop", "music", "se_story_123_01", "se_story_123_flame1", "")

				local var_778_2 = manager.audio:GetAudioName("se_story_123_01", "se_story_123_flame1")

				if "" ~= "" then
					if arg_775_1.bgmTxt_.text ~= var_778_2 and arg_775_1.bgmTxt_.text ~= "" then
						if arg_775_1.bgmTxt2_.text ~= "" then
							arg_775_1.bgmTxt_.text = arg_775_1.bgmTxt2_.text
						end

						arg_775_1.bgmTxt2_.text = var_778_2

						arg_775_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_775_1.bgmTxt_.text = var_778_2
						arg_775_1.bgmTxt2_.text = var_778_2
					end

					if arg_775_1.bgmTimer then
						arg_775_1.bgmTimer:Stop()

						arg_775_1.bgmTimer = nil
					end

					if arg_775_1.settingData.show_music_name == 1 then
						arg_775_1.musicController:SetSelectedState("show")
						arg_775_1.musicAnimator_:Play("open", 0, 0)

						if arg_775_1.settingData.music_time ~= 0 then
							arg_775_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_775_1.settingData.music_time), function()
								if arg_775_1 == nil or isNil(arg_775_1.bgmTxt_) then
									return
								end

								arg_775_1.musicController:SetSelectedState("hide")
								arg_775_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_778_3 = 0
			local var_778_4 = 0.85

			if 0 < arg_775_1.time_ and arg_775_1.time_ <= var_778_3 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, false)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_5 = arg_775_1:FormatText(arg_775_1:GetWordFromCfg(1108106186).content)

				arg_775_1.text_.text = var_778_5

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_7 = 34 <= 0 and var_778_4 or var_778_4 * (utf8.len(var_778_5) / 34)

				if (34 <= 0 and var_778_4 or var_778_4 * (utf8.len(var_778_5) / 34)) > 0 and var_778_4 < var_778_7 then
					arg_775_1.talkMaxDuration = var_778_7

					if var_778_7 + var_778_3 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_7 + var_778_3
					end
				end

				arg_775_1.text_.text = var_778_5
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)
				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_8 = math.max(var_778_4, arg_775_1.talkMaxDuration)

			if var_778_3 <= arg_775_1.time_ and arg_775_1.time_ < var_778_3 + var_778_8 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_3) / var_778_8

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_3 + var_778_8 and arg_775_1.time_ < var_778_3 + var_778_8 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {}

		arg_775_1:InitPlayNodeList()
	end,
	Play1108106187 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1108106187
		arg_780_1.duration_ = 8.57

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1108106188(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			if 3.56666666666667 < arg_780_1.time_ and arg_780_1.time_ <= 3.56666666666667 + arg_783_0 then
				arg_780_1.allBtn_.enabled = false
			end

			if arg_780_1.time_ >= 3.56666666666667 + 0.3 and arg_780_1.time_ < 3.56666666666667 + 0.3 + arg_783_0 then
				arg_780_1.allBtn_.enabled = true
			end

			local var_783_0 = "ST12"

			if arg_780_1.bgs_.ST12 == nil then
				local var_783_1 = Object.Instantiate(arg_780_1.paintGo_)

				var_783_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_783_0)
				var_783_1.name = var_783_0
				var_783_1.transform.parent = arg_780_1.stage_.transform
				var_783_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_780_1.bgs_[var_783_0] = var_783_1
			end

			if 2 < arg_780_1.time_ and arg_780_1.time_ <= 2 + arg_783_0 then
				local var_783_2 = arg_780_1.bgs_.ST12

				arg_780_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_783_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_783_3 = var_783_2:GetComponent("SpriteRenderer")

				if var_783_3 and var_783_3.sprite then
					local var_783_4 = 2 * (var_783_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_783_2.transform.localScale = Vector3.New(var_783_4 / var_783_3.sprite.bounds.size.y < var_783_4 * manager.ui.mainCameraCom_.aspect / var_783_3.sprite.bounds.size.x and var_783_4 * manager.ui.mainCameraCom_.aspect / var_783_3.sprite.bounds.size.x or var_783_4 / var_783_3.sprite.bounds.size.y, var_783_4 / var_783_3.sprite.bounds.size.y < var_783_4 * manager.ui.mainCameraCom_.aspect / var_783_3.sprite.bounds.size.x and var_783_4 * manager.ui.mainCameraCom_.aspect / var_783_3.sprite.bounds.size.x or var_783_4 / var_783_3.sprite.bounds.size.y, 0)
				end

				for iter_783_0, iter_783_1 in pairs(arg_780_1.bgs_) do
					if iter_783_0 ~= "ST12" then
						iter_783_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_783_5 = 0

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_5 + arg_783_0 then
				arg_780_1.mask_.enabled = true
				arg_780_1.mask_.raycastTarget = true

				arg_780_1:SetGaussion(false)
			end

			local var_783_6 = 2

			if var_783_5 <= arg_780_1.time_ and arg_780_1.time_ < var_783_5 + var_783_6 then
				local var_783_7 = Color.New(0, 0, 0)

				var_783_7.a = Mathf.Lerp(0, 1, (arg_780_1.time_ - var_783_5) / var_783_6)
				arg_780_1.mask_.color = var_783_7
			end

			if arg_780_1.time_ >= var_783_5 + var_783_6 and arg_780_1.time_ < var_783_5 + var_783_6 + arg_783_0 then
				local var_783_8 = Color.New(0, 0, 0)

				var_783_8.a = 1
				arg_780_1.mask_.color = var_783_8
			end

			local var_783_9 = 2

			if 2 < arg_780_1.time_ and arg_780_1.time_ <= var_783_9 + arg_783_0 then
				arg_780_1.mask_.enabled = true
				arg_780_1.mask_.raycastTarget = true

				arg_780_1:SetGaussion(false)
			end

			local var_783_10 = 2

			if var_783_9 <= arg_780_1.time_ and arg_780_1.time_ < var_783_9 + var_783_10 then
				local var_783_11 = Color.New(0, 0, 0)

				var_783_11.a = Mathf.Lerp(1, 0, (arg_780_1.time_ - var_783_9) / var_783_10)
				arg_780_1.mask_.color = var_783_11
			end

			if arg_780_1.time_ >= var_783_9 + var_783_10 and arg_780_1.time_ < var_783_9 + var_783_10 + arg_783_0 then
				local var_783_12 = Color.New(0, 0, 0)

				arg_780_1.mask_.enabled = false
				var_783_12.a = 0
				arg_780_1.mask_.color = var_783_12
			end

			if 2 < arg_780_1.time_ and arg_780_1.time_ <= 2 + arg_783_0 then
				arg_780_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_783_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_780_1.bgmTxt_.text ~= var_783_15 and arg_780_1.bgmTxt_.text ~= "" then
						if arg_780_1.bgmTxt2_.text ~= "" then
							arg_780_1.bgmTxt_.text = arg_780_1.bgmTxt2_.text
						end

						arg_780_1.bgmTxt2_.text = var_783_15

						arg_780_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_780_1.bgmTxt_.text = var_783_15
						arg_780_1.bgmTxt2_.text = var_783_15
					end

					if arg_780_1.bgmTimer then
						arg_780_1.bgmTimer:Stop()

						arg_780_1.bgmTimer = nil
					end

					if arg_780_1.settingData.show_music_name == 1 then
						arg_780_1.musicController:SetSelectedState("show")
						arg_780_1.musicAnimator_:Play("open", 0, 0)

						if arg_780_1.settingData.music_time ~= 0 then
							arg_780_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_780_1.settingData.music_time), function()
								if arg_780_1 == nil or isNil(arg_780_1.bgmTxt_) then
									return
								end

								arg_780_1.musicController:SetSelectedState("hide")
								arg_780_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_780_1.frameCnt_ <= 1 then
				arg_780_1.dialog_:SetActive(false)
			end

			local var_783_16 = 3.56666666666667
			local var_783_17 = 0.9

			if 3.56666666666667 < arg_780_1.time_ and arg_780_1.time_ <= var_783_16 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0

				arg_780_1.dialog_:SetActive(true)

				arg_780_1.dialogCg_.alpha = 0

				local var_783_18 = LeanTween.value(arg_780_1.dialog_, 0, 1, 0.3)

				var_783_18:setOnUpdate(LuaHelper.FloatAction(function(arg_785_0)
					arg_780_1.dialogCg_.alpha = arg_785_0
				end))
				var_783_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_780_1.dialog_)
					var_783_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_780_1.duration_ = arg_780_1.duration_ + 0.3

				SetActive(arg_780_1.leftNameGo_, false)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_19 = arg_780_1:FormatText(arg_780_1:GetWordFromCfg(1108106187).content)

				arg_780_1.text_.text = var_783_19

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_21 = 36 <= 0 and var_783_17 or var_783_17 * (utf8.len(var_783_19) / 36)

				if (36 <= 0 and var_783_17 or var_783_17 * (utf8.len(var_783_19) / 36)) > 0 and var_783_17 < var_783_21 then
					arg_780_1.talkMaxDuration = var_783_21
					var_783_16 = var_783_16 + 0.3

					if var_783_21 + var_783_16 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_21 + var_783_16
					end
				end

				arg_780_1.text_.text = var_783_19
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)
				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_22 = var_783_16 + 0.3
			local var_783_23 = math.max(var_783_17, arg_780_1.talkMaxDuration)

			if var_783_16 + 0.3 <= arg_780_1.time_ and arg_780_1.time_ < var_783_22 + var_783_23 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_22) / var_783_23

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_22 + var_783_23 and arg_780_1.time_ < var_783_22 + var_783_23 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1108106188 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 1108106188
		arg_787_1.duration_ = 5

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play1108106189(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			local var_790_0 = 0.75

			if 0 < arg_787_1.time_ and arg_787_1.time_ <= 0 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, false)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_1 = arg_787_1:FormatText(arg_787_1:GetWordFromCfg(1108106188).content)

				arg_787_1.text_.text = var_790_1

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_3 = 30 <= 0 and var_790_0 or var_790_0 * (utf8.len(var_790_1) / 30)

				if (30 <= 0 and var_790_0 or var_790_0 * (utf8.len(var_790_1) / 30)) > 0 and var_790_0 < var_790_3 then
					arg_787_1.talkMaxDuration = var_790_3

					if var_790_3 + 0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_3 + 0
					end
				end

				arg_787_1.text_.text = var_790_1
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)
				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_4 = math.max(var_790_0, arg_787_1.talkMaxDuration)

			if 0 <= arg_787_1.time_ and arg_787_1.time_ < 0 + var_790_4 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - 0) / var_790_4

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= 0 + var_790_4 and arg_787_1.time_ < 0 + var_790_4 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {}

		arg_787_1:InitPlayNodeList()
	end,
	Play1108106189 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 1108106189
		arg_791_1.duration_ = 1

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"

			SetActive(arg_791_1.choicesGo_, true)

			for iter_792_0, iter_792_1 in ipairs(arg_791_1.choices_) do
				SetActive(iter_792_1.go, iter_792_0 <= 1)
			end

			arg_791_1.choices_[1].txt.text = arg_791_1:FormatText(StoryChoiceCfg[997].name)
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play1108106190(arg_791_1)
			end

			arg_791_1:RecordChoiceLog(1108106189, 997)
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			return
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play1108106190 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 1108106190
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play1108106191(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0.15

			if 0 < arg_795_1.time_ and arg_795_1.time_ <= 0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				arg_795_1.leftNameTxt_.text = arg_795_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, true)
				arg_795_1.iconController_:SetSelectedState("hero")

				arg_795_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_795_1.callingController_:SetSelectedState("normal")

				arg_795_1.keyicon_.color = Color.New(1, 1, 1)
				arg_795_1.icon_.color = Color.New(1, 1, 1)

				local var_798_1 = arg_795_1:FormatText(arg_795_1:GetWordFromCfg(1108106190).content)

				arg_795_1.text_.text = var_798_1

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_3 = 6 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_1) / 6)

				if (6 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_1) / 6)) > 0 and var_798_0 < var_798_3 then
					arg_795_1.talkMaxDuration = var_798_3

					if var_798_3 + 0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_3 + 0
					end
				end

				arg_795_1.text_.text = var_798_1
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_4 = math.max(var_798_0, arg_795_1.talkMaxDuration)

			if 0 <= arg_795_1.time_ and arg_795_1.time_ < 0 + var_798_4 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - 0) / var_798_4

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= 0 + var_798_4 and arg_795_1.time_ < 0 + var_798_4 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play1108106191 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 1108106191
		arg_799_1.duration_ = 5

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play1108106192(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = 0.25

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				arg_799_1.leftNameTxt_.text = arg_799_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, true)
				arg_799_1.iconController_:SetSelectedState("hero")

				arg_799_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_799_1.callingController_:SetSelectedState("normal")

				arg_799_1.keyicon_.color = Color.New(1, 1, 1)
				arg_799_1.icon_.color = Color.New(1, 1, 1)

				local var_802_1 = arg_799_1:FormatText(arg_799_1:GetWordFromCfg(1108106191).content)

				arg_799_1.text_.text = var_802_1

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_3 = 10 <= 0 and var_802_0 or var_802_0 * (utf8.len(var_802_1) / 10)

				if (10 <= 0 and var_802_0 or var_802_0 * (utf8.len(var_802_1) / 10)) > 0 and var_802_0 < var_802_3 then
					arg_799_1.talkMaxDuration = var_802_3

					if var_802_3 + 0 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_3 + 0
					end
				end

				arg_799_1.text_.text = var_802_1
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)
				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_4 = math.max(var_802_0, arg_799_1.talkMaxDuration)

			if 0 <= arg_799_1.time_ and arg_799_1.time_ < 0 + var_802_4 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - 0) / var_802_4

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= 0 + var_802_4 and arg_799_1.time_ < 0 + var_802_4 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {}

		arg_799_1:InitPlayNodeList()
	end,
	Play1108106192 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 1108106192
		arg_803_1.duration_ = 7.87

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play1108106193(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			if arg_803_1.bgs_.ST07b == nil then
				local var_806_0 = Object.Instantiate(arg_803_1.paintGo_)

				var_806_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_806_0.name = "ST07b"
				var_806_0.transform.parent = arg_803_1.stage_.transform
				var_806_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_803_1.bgs_.ST07b = var_806_0
			end

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= 1.999999999999 + arg_806_0 then
				local var_806_1 = arg_803_1.bgs_.ST07b

				arg_803_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_806_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_806_2 = var_806_1:GetComponent("SpriteRenderer")

				if var_806_2 and var_806_2.sprite then
					local var_806_3 = 2 * (var_806_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_806_1.transform.localScale = Vector3.New(var_806_3 / var_806_2.sprite.bounds.size.y < var_806_3 * manager.ui.mainCameraCom_.aspect / var_806_2.sprite.bounds.size.x and var_806_3 * manager.ui.mainCameraCom_.aspect / var_806_2.sprite.bounds.size.x or var_806_3 / var_806_2.sprite.bounds.size.y, var_806_3 / var_806_2.sprite.bounds.size.y < var_806_3 * manager.ui.mainCameraCom_.aspect / var_806_2.sprite.bounds.size.x and var_806_3 * manager.ui.mainCameraCom_.aspect / var_806_2.sprite.bounds.size.x or var_806_3 / var_806_2.sprite.bounds.size.y, 0)
				end

				for iter_806_0, iter_806_1 in pairs(arg_803_1.bgs_) do
					if iter_806_0 ~= "ST07b" then
						iter_806_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_806_4 = 0

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= var_806_4 + arg_806_0 then
				arg_803_1.mask_.enabled = true
				arg_803_1.mask_.raycastTarget = true

				arg_803_1:SetGaussion(false)
			end

			local var_806_5 = 2

			if var_806_4 <= arg_803_1.time_ and arg_803_1.time_ < var_806_4 + var_806_5 then
				local var_806_6 = Color.New(0, 0, 0)

				var_806_6.a = Mathf.Lerp(0, 1, (arg_803_1.time_ - var_806_4) / var_806_5)
				arg_803_1.mask_.color = var_806_6
			end

			if arg_803_1.time_ >= var_806_4 + var_806_5 and arg_803_1.time_ < var_806_4 + var_806_5 + arg_806_0 then
				local var_806_7 = Color.New(0, 0, 0)

				var_806_7.a = 1
				arg_803_1.mask_.color = var_806_7
			end

			local var_806_8 = 1.999999999999

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= var_806_8 + arg_806_0 then
				arg_803_1.mask_.enabled = true
				arg_803_1.mask_.raycastTarget = true

				arg_803_1:SetGaussion(false)
			end

			local var_806_9 = 2

			if var_806_8 <= arg_803_1.time_ and arg_803_1.time_ < var_806_8 + var_806_9 then
				local var_806_10 = Color.New(0, 0, 0)

				var_806_10.a = Mathf.Lerp(1, 0, (arg_803_1.time_ - var_806_8) / var_806_9)
				arg_803_1.mask_.color = var_806_10
			end

			if arg_803_1.time_ >= var_806_8 + var_806_9 and arg_803_1.time_ < var_806_8 + var_806_9 + arg_806_0 then
				local var_806_11 = Color.New(0, 0, 0)

				arg_803_1.mask_.enabled = false
				var_806_11.a = 0
				arg_803_1.mask_.color = var_806_11
			end

			local var_806_12 = "10066ui_story"

			if arg_803_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_806_13 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_803_1.stage_.transform)

				var_806_13.name = var_806_12
				var_806_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_803_1.actors_[var_806_12] = var_806_13

				local var_806_14 = var_806_13:GetComponentInChildren(typeof(CharacterEffect))

				var_806_14.enabled = true

				local var_806_15 = GameObjectTools.GetOrAddComponent(var_806_13, typeof(DynamicBoneHelper))

				if var_806_15 then
					var_806_15:EnableDynamicBone(false)
				end

				arg_803_1:ShowWeapon(var_806_14.transform, false)

				arg_803_1.var_[var_806_12 .. "Animator"] = var_806_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_803_1.var_[var_806_12 .. "Animator"].applyRootMotion = true
				arg_803_1.var_[var_806_12 .. "LipSync"] = var_806_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= 1.999999999999 + arg_806_0 then
				arg_803_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= 1.999999999999 + arg_806_0 then
				arg_803_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_806_16 = arg_803_1.actors_["10066ui_story"]

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= 1.999999999999 + arg_806_0 and not isNil(var_806_16) and arg_803_1.var_.characterEffect10066ui_story == nil then
				arg_803_1.var_.characterEffect10066ui_story = var_806_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_17 = 0.0833333333333335

			if 1.999999999999 <= arg_803_1.time_ and arg_803_1.time_ < 1.999999999999 + var_806_17 and not isNil(var_806_16) then
				if arg_803_1.var_.characterEffect10066ui_story and not isNil(var_806_16) then
					arg_803_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_803_1.time_ >= 1.999999999999 + var_806_17 and arg_803_1.time_ < 1.999999999999 + var_806_17 + arg_806_0 and not isNil(var_806_16) and arg_803_1.var_.characterEffect10066ui_story then
				arg_803_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_806_19 = arg_803_1.actors_["10066ui_story"].transform

			if 1.999999999999 < arg_803_1.time_ and arg_803_1.time_ <= 1.999999999999 + arg_806_0 then
				arg_803_1.var_.moveOldPos10066ui_story = var_806_19.localPosition
			end

			local var_806_20 = 0.001

			if 1.999999999999 <= arg_803_1.time_ and arg_803_1.time_ < 1.999999999999 + var_806_20 then
				var_806_19.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_803_1.time_ - 1.999999999999) / var_806_20)
				var_806_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_806_19.position).x, (manager.ui.mainCamera.transform.position - var_806_19.position).y, (manager.ui.mainCamera.transform.position - var_806_19.position).z)
				var_806_19.localEulerAngles.z = 0
				var_806_19.localEulerAngles.x = 0
				var_806_19.localEulerAngles = var_806_19.localEulerAngles
			end

			if arg_803_1.time_ >= 1.999999999999 + var_806_20 and arg_803_1.time_ < 1.999999999999 + var_806_20 + arg_806_0 then
				var_806_19.localPosition = Vector3.New(0, -0.99, -5.83)
				var_806_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_806_19.position).x, (manager.ui.mainCamera.transform.position - var_806_19.position).y, (manager.ui.mainCamera.transform.position - var_806_19.position).z)
				var_806_19.localEulerAngles.z = 0
				var_806_19.localEulerAngles.x = 0
				var_806_19.localEulerAngles = var_806_19.localEulerAngles
			end

			if 2 < arg_803_1.time_ and arg_803_1.time_ <= 2 + arg_806_0 then
				arg_803_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_806_23 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_803_1.bgmTxt_.text ~= var_806_23 and arg_803_1.bgmTxt_.text ~= "" then
						if arg_803_1.bgmTxt2_.text ~= "" then
							arg_803_1.bgmTxt_.text = arg_803_1.bgmTxt2_.text
						end

						arg_803_1.bgmTxt2_.text = var_806_23

						arg_803_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_803_1.bgmTxt_.text = var_806_23
						arg_803_1.bgmTxt2_.text = var_806_23
					end

					if arg_803_1.bgmTimer then
						arg_803_1.bgmTimer:Stop()

						arg_803_1.bgmTimer = nil
					end

					if arg_803_1.settingData.show_music_name == 1 then
						arg_803_1.musicController:SetSelectedState("show")
						arg_803_1.musicAnimator_:Play("open", 0, 0)

						if arg_803_1.settingData.music_time ~= 0 then
							arg_803_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_803_1.settingData.music_time), function()
								if arg_803_1 == nil or isNil(arg_803_1.bgmTxt_) then
									return
								end

								arg_803_1.musicController:SetSelectedState("hide")
								arg_803_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_803_1.frameCnt_ <= 1 then
				arg_803_1.dialog_:SetActive(false)
			end

			local var_806_24 = 2.66666666666667
			local var_806_25 = 0.45

			if 2.66666666666667 < arg_803_1.time_ and arg_803_1.time_ <= var_806_24 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0

				arg_803_1.dialog_:SetActive(true)

				arg_803_1.dialogCg_.alpha = 0

				local var_806_26 = LeanTween.value(arg_803_1.dialog_, 0, 1, 0.3)

				var_806_26:setOnUpdate(LuaHelper.FloatAction(function(arg_808_0)
					arg_803_1.dialogCg_.alpha = arg_808_0
				end))
				var_806_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_803_1.dialog_)
					var_806_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_803_1.duration_ = arg_803_1.duration_ + 0.3

				SetActive(arg_803_1.leftNameGo_, true)

				arg_803_1.leftNameTxt_.text = arg_803_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_27 = arg_803_1:GetWordFromCfg(1108106192)
				local var_806_28 = arg_803_1:FormatText(var_806_27.content)

				arg_803_1.text_.text = var_806_28

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_30 = 18 <= 0 and var_806_25 or var_806_25 * (utf8.len(var_806_28) / 18)

				if (18 <= 0 and var_806_25 or var_806_25 * (utf8.len(var_806_28) / 18)) > 0 and var_806_25 < var_806_30 then
					arg_803_1.talkMaxDuration = var_806_30
					var_806_24 = var_806_24 + 0.3

					if var_806_30 + var_806_24 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_30 + var_806_24
					end
				end

				arg_803_1.text_.text = var_806_28
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb") ~= 0 then
					local var_806_31 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb") / 1000

					if var_806_31 + var_806_24 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_31 + var_806_24
					end

					if var_806_27.prefab_name ~= "" and arg_803_1.actors_[var_806_27.prefab_name] ~= nil then
						local var_806_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_803_1.actors_[var_806_27.prefab_name].transform, "story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")

						arg_803_1:RecordAudio("1108106192", var_806_32)
						arg_803_1:RecordAudio("1108106192", var_806_32)
					else
						arg_803_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")
					end

					arg_803_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")
				end

				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_33 = var_806_24 + 0.3
			local var_806_34 = math.max(var_806_25, arg_803_1.talkMaxDuration)

			if var_806_24 + 0.3 <= arg_803_1.time_ and arg_803_1.time_ < var_806_33 + var_806_34 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_33) / var_806_34

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_33 + var_806_34 and arg_803_1.time_ < var_806_33 + var_806_34 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play1108106193 = function(arg_810_0, arg_810_1)
		arg_810_1.time_ = 0
		arg_810_1.frameCnt_ = 0
		arg_810_1.state_ = "playing"
		arg_810_1.curTalkId_ = 1108106193
		arg_810_1.duration_ = 5

		SetActive(arg_810_1.tipsGo_, false)

		function arg_810_1.onSingleLineFinish_()
			arg_810_1.onSingleLineUpdate_ = nil
			arg_810_1.onSingleLineFinish_ = nil
			arg_810_1.state_ = "waiting"
		end

		function arg_810_1.playNext_(arg_812_0)
			if arg_812_0 == 1 then
				arg_810_0:Play1108106194(arg_810_1)
			end
		end

		function arg_810_1.onSingleLineUpdate_(arg_813_0)
			if 0 < arg_810_1.time_ and arg_810_1.time_ <= 0 + arg_813_0 then
				arg_810_1.var_.moveOldPos10066ui_story = arg_810_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_813_0 = 0.001

			if 0 <= arg_810_1.time_ and arg_810_1.time_ < 0 + var_813_0 then
				arg_810_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_810_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_810_1.time_ - 0) / var_813_0)
				arg_810_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).z)
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles = arg_810_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_810_1.time_ >= 0 + var_813_0 and arg_810_1.time_ < 0 + var_813_0 + arg_813_0 then
				arg_810_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_810_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_810_1.actors_["10066ui_story"].transform.position).z)
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_810_1.actors_["10066ui_story"].transform.localEulerAngles = arg_810_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_813_1 = 0
			local var_813_2 = 1.15

			if 0 < arg_810_1.time_ and arg_810_1.time_ <= var_813_1 + arg_813_0 then
				arg_810_1.talkMaxDuration = 0
				arg_810_1.dialogCg_.alpha = 1

				arg_810_1.dialog_:SetActive(true)
				SetActive(arg_810_1.leftNameGo_, false)

				arg_810_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_810_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_810_1:RecordName(arg_810_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_810_1.iconTrs_.gameObject, false)
				arg_810_1.callingController_:SetSelectedState("normal")

				local var_813_3 = arg_810_1:FormatText(arg_810_1:GetWordFromCfg(1108106193).content)

				arg_810_1.text_.text = var_813_3

				LuaForUtil.ClearLinePrefixSymbol(arg_810_1.text_)

				local var_813_5 = 46 <= 0 and var_813_2 or var_813_2 * (utf8.len(var_813_3) / 46)

				if (46 <= 0 and var_813_2 or var_813_2 * (utf8.len(var_813_3) / 46)) > 0 and var_813_2 < var_813_5 then
					arg_810_1.talkMaxDuration = var_813_5

					if var_813_5 + var_813_1 > arg_810_1.duration_ then
						arg_810_1.duration_ = var_813_5 + var_813_1
					end
				end

				arg_810_1.text_.text = var_813_3
				arg_810_1.typewritter.percent = 0

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(false)
				arg_810_1:RecordContent(arg_810_1.text_.text)
			end

			local var_813_6 = math.max(var_813_2, arg_810_1.talkMaxDuration)

			if var_813_1 <= arg_810_1.time_ and arg_810_1.time_ < var_813_1 + var_813_6 then
				arg_810_1.typewritter.percent = (arg_810_1.time_ - var_813_1) / var_813_6

				arg_810_1.typewritter:SetDirty()
			end

			if arg_810_1.time_ >= var_813_1 + var_813_6 and arg_810_1.time_ < var_813_1 + var_813_6 + arg_813_0 then
				arg_810_1.typewritter.percent = 1

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(true)
			end
		end

		arg_810_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_810_1:InitPlayNodeList()
	end,
	Play1108106194 = function(arg_814_0, arg_814_1)
		arg_814_1.time_ = 0
		arg_814_1.frameCnt_ = 0
		arg_814_1.state_ = "playing"
		arg_814_1.curTalkId_ = 1108106194
		arg_814_1.duration_ = 6.93

		SetActive(arg_814_1.tipsGo_, false)

		function arg_814_1.onSingleLineFinish_()
			arg_814_1.onSingleLineUpdate_ = nil
			arg_814_1.onSingleLineFinish_ = nil
			arg_814_1.state_ = "waiting"
		end

		function arg_814_1.playNext_(arg_816_0)
			if arg_816_0 == 1 then
				arg_814_0:Play1108106195(arg_814_1)
			end
		end

		function arg_814_1.onSingleLineUpdate_(arg_817_0)
			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1.var_.moveOldPos10066ui_story = arg_814_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_817_0 = 0.001

			if 0 <= arg_814_1.time_ and arg_814_1.time_ < 0 + var_817_0 then
				arg_814_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_814_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_814_1.time_ - 0) / var_817_0)
				arg_814_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).z)
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles = arg_814_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_814_1.time_ >= 0 + var_817_0 and arg_814_1.time_ < 0 + var_817_0 + arg_817_0 then
				arg_814_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_814_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_814_1.actors_["10066ui_story"].transform.position).z)
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_814_1.actors_["10066ui_story"].transform.localEulerAngles = arg_814_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_817_1 = arg_814_1.actors_["10066ui_story"]

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 and not isNil(var_817_1) and arg_814_1.var_.characterEffect10066ui_story == nil then
				arg_814_1.var_.characterEffect10066ui_story = var_817_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_817_2 = 0.034000001847744

			if 0 <= arg_814_1.time_ and arg_814_1.time_ < 0 + var_817_2 and not isNil(var_817_1) then
				if arg_814_1.var_.characterEffect10066ui_story and not isNil(var_817_1) then
					arg_814_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_814_1.time_ >= 0 + var_817_2 and arg_814_1.time_ < 0 + var_817_2 + arg_817_0 and not isNil(var_817_1) and arg_814_1.var_.characterEffect10066ui_story then
				arg_814_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_817_4 = 0
			local var_817_5 = 0.725

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= var_817_4 + arg_817_0 then
				arg_814_1.talkMaxDuration = 0
				arg_814_1.dialogCg_.alpha = 1

				arg_814_1.dialog_:SetActive(true)
				SetActive(arg_814_1.leftNameGo_, true)

				arg_814_1.leftNameTxt_.text = arg_814_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_814_1.leftNameTxt_.transform)

				arg_814_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_814_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_814_1:RecordName(arg_814_1.leftNameTxt_.text)
				SetActive(arg_814_1.iconTrs_.gameObject, false)
				arg_814_1.callingController_:SetSelectedState("normal")

				local var_817_6 = arg_814_1:GetWordFromCfg(1108106194)
				local var_817_7 = arg_814_1:FormatText(var_817_6.content)

				arg_814_1.text_.text = var_817_7

				LuaForUtil.ClearLinePrefixSymbol(arg_814_1.text_)

				local var_817_9 = 29 <= 0 and var_817_5 or var_817_5 * (utf8.len(var_817_7) / 29)

				if (29 <= 0 and var_817_5 or var_817_5 * (utf8.len(var_817_7) / 29)) > 0 and var_817_5 < var_817_9 then
					arg_814_1.talkMaxDuration = var_817_9

					if var_817_9 + var_817_4 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_9 + var_817_4
					end
				end

				arg_814_1.text_.text = var_817_7
				arg_814_1.typewritter.percent = 0

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb") ~= 0 then
					local var_817_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb") / 1000

					if var_817_10 + var_817_4 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_10 + var_817_4
					end

					if var_817_6.prefab_name ~= "" and arg_814_1.actors_[var_817_6.prefab_name] ~= nil then
						local var_817_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_814_1.actors_[var_817_6.prefab_name].transform, "story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")

						arg_814_1:RecordAudio("1108106194", var_817_11)
						arg_814_1:RecordAudio("1108106194", var_817_11)
					else
						arg_814_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")
					end

					arg_814_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")
				end

				arg_814_1:RecordContent(arg_814_1.text_.text)
			end

			local var_817_12 = math.max(var_817_5, arg_814_1.talkMaxDuration)

			if var_817_4 <= arg_814_1.time_ and arg_814_1.time_ < var_817_4 + var_817_12 then
				arg_814_1.typewritter.percent = (arg_814_1.time_ - var_817_4) / var_817_12

				arg_814_1.typewritter:SetDirty()
			end

			if arg_814_1.time_ >= var_817_4 + var_817_12 and arg_814_1.time_ < var_817_4 + var_817_12 + arg_817_0 then
				arg_814_1.typewritter.percent = 1

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(true)
			end
		end

		arg_814_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_814_1:InitPlayNodeList()
	end,
	Play1108106195 = function(arg_818_0, arg_818_1)
		arg_818_1.time_ = 0
		arg_818_1.frameCnt_ = 0
		arg_818_1.state_ = "playing"
		arg_818_1.curTalkId_ = 1108106195
		arg_818_1.duration_ = 7.8

		SetActive(arg_818_1.tipsGo_, false)

		function arg_818_1.onSingleLineFinish_()
			arg_818_1.onSingleLineUpdate_ = nil
			arg_818_1.onSingleLineFinish_ = nil
			arg_818_1.state_ = "waiting"
		end

		function arg_818_1.playNext_(arg_820_0)
			if arg_820_0 == 1 then
				arg_818_0:Play1108106196(arg_818_1)
			end
		end

		function arg_818_1.onSingleLineUpdate_(arg_821_0)
			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				arg_818_1.var_.moveOldPos10066ui_story = arg_818_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_821_0 = 0.001

			if 0 <= arg_818_1.time_ and arg_818_1.time_ < 0 + var_821_0 then
				arg_818_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_818_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_818_1.time_ - 0) / var_821_0)
				arg_818_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).z)
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles = arg_818_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_818_1.time_ >= 0 + var_821_0 and arg_818_1.time_ < 0 + var_821_0 + arg_821_0 then
				arg_818_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_818_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["10066ui_story"].transform.position).z)
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_818_1.actors_["10066ui_story"].transform.localEulerAngles = arg_818_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_821_1 = arg_818_1.actors_["10066ui_story"]

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 and not isNil(var_821_1) and arg_818_1.var_.characterEffect10066ui_story == nil then
				arg_818_1.var_.characterEffect10066ui_story = var_821_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_821_2 = 0.200000002980232

			if 0 <= arg_818_1.time_ and arg_818_1.time_ < 0 + var_821_2 and not isNil(var_821_1) then
				if arg_818_1.var_.characterEffect10066ui_story and not isNil(var_821_1) then
					arg_818_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_818_1.time_ >= 0 + var_821_2 and arg_818_1.time_ < 0 + var_821_2 + arg_821_0 and not isNil(var_821_1) and arg_818_1.var_.characterEffect10066ui_story then
				arg_818_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				arg_818_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				arg_818_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_821_4 = 0
			local var_821_5 = 0.775

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= var_821_4 + arg_821_0 then
				arg_818_1.talkMaxDuration = 0
				arg_818_1.dialogCg_.alpha = 1

				arg_818_1.dialog_:SetActive(true)
				SetActive(arg_818_1.leftNameGo_, true)

				arg_818_1.leftNameTxt_.text = arg_818_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_818_1.leftNameTxt_.transform)

				arg_818_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_818_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_818_1:RecordName(arg_818_1.leftNameTxt_.text)
				SetActive(arg_818_1.iconTrs_.gameObject, false)
				arg_818_1.callingController_:SetSelectedState("normal")

				local var_821_6 = arg_818_1:GetWordFromCfg(1108106195)
				local var_821_7 = arg_818_1:FormatText(var_821_6.content)

				arg_818_1.text_.text = var_821_7

				LuaForUtil.ClearLinePrefixSymbol(arg_818_1.text_)

				local var_821_9 = 31 <= 0 and var_821_5 or var_821_5 * (utf8.len(var_821_7) / 31)

				if (31 <= 0 and var_821_5 or var_821_5 * (utf8.len(var_821_7) / 31)) > 0 and var_821_5 < var_821_9 then
					arg_818_1.talkMaxDuration = var_821_9

					if var_821_9 + var_821_4 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_9 + var_821_4
					end
				end

				arg_818_1.text_.text = var_821_7
				arg_818_1.typewritter.percent = 0

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb") ~= 0 then
					local var_821_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb") / 1000

					if var_821_10 + var_821_4 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_10 + var_821_4
					end

					if var_821_6.prefab_name ~= "" and arg_818_1.actors_[var_821_6.prefab_name] ~= nil then
						local var_821_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_818_1.actors_[var_821_6.prefab_name].transform, "story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")

						arg_818_1:RecordAudio("1108106195", var_821_11)
						arg_818_1:RecordAudio("1108106195", var_821_11)
					else
						arg_818_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")
					end

					arg_818_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")
				end

				arg_818_1:RecordContent(arg_818_1.text_.text)
			end

			local var_821_12 = math.max(var_821_5, arg_818_1.talkMaxDuration)

			if var_821_4 <= arg_818_1.time_ and arg_818_1.time_ < var_821_4 + var_821_12 then
				arg_818_1.typewritter.percent = (arg_818_1.time_ - var_821_4) / var_821_12

				arg_818_1.typewritter:SetDirty()
			end

			if arg_818_1.time_ >= var_821_4 + var_821_12 and arg_818_1.time_ < var_821_4 + var_821_12 + arg_821_0 then
				arg_818_1.typewritter.percent = 1

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(true)
			end
		end

		arg_818_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_818_1:InitPlayNodeList()
	end,
	Play1108106196 = function(arg_822_0, arg_822_1)
		arg_822_1.time_ = 0
		arg_822_1.frameCnt_ = 0
		arg_822_1.state_ = "playing"
		arg_822_1.curTalkId_ = 1108106196
		arg_822_1.duration_ = 1

		SetActive(arg_822_1.tipsGo_, false)

		function arg_822_1.onSingleLineFinish_()
			arg_822_1.onSingleLineUpdate_ = nil
			arg_822_1.onSingleLineFinish_ = nil
			arg_822_1.state_ = "waiting"

			SetActive(arg_822_1.choicesGo_, true)

			for iter_823_0, iter_823_1 in ipairs(arg_822_1.choices_) do
				SetActive(iter_823_1.go, iter_823_0 <= 2)
			end

			arg_822_1.choices_[1].txt.text = arg_822_1:FormatText(StoryChoiceCfg[998].name)
			arg_822_1.choices_[2].txt.text = arg_822_1:FormatText(StoryChoiceCfg[999].name)
		end

		function arg_822_1.playNext_(arg_824_0)
			if arg_824_0 == 1 then
				arg_822_0:Play1108106197(arg_822_1)
			end

			if arg_824_0 == 2 then
				arg_822_0:Play1108106197(arg_822_1)
			end

			arg_822_1:RecordChoiceLog(1108106196, 998, 999)
		end

		function arg_822_1.onSingleLineUpdate_(arg_825_0)
			return
		end

		arg_822_1.nodeConfigList_ = {}

		arg_822_1:InitPlayNodeList()
	end,
	Play1108106197 = function(arg_826_0, arg_826_1)
		arg_826_1.time_ = 0
		arg_826_1.frameCnt_ = 0
		arg_826_1.state_ = "playing"
		arg_826_1.curTalkId_ = 1108106197
		arg_826_1.duration_ = 5

		SetActive(arg_826_1.tipsGo_, false)

		function arg_826_1.onSingleLineFinish_()
			arg_826_1.onSingleLineUpdate_ = nil
			arg_826_1.onSingleLineFinish_ = nil
			arg_826_1.state_ = "waiting"
		end

		function arg_826_1.playNext_(arg_828_0)
			if arg_828_0 == 1 then
				arg_826_0:Play1108106198(arg_826_1)
			end
		end

		function arg_826_1.onSingleLineUpdate_(arg_829_0)
			if 0 < arg_826_1.time_ and arg_826_1.time_ <= 0 + arg_829_0 and not isNil(arg_826_1.actors_["10066ui_story"]) and arg_826_1.var_.characterEffect10066ui_story == nil then
				arg_826_1.var_.characterEffect10066ui_story = arg_826_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_829_0 = 0.05

			if 0 <= arg_826_1.time_ and arg_826_1.time_ < 0 + var_829_0 and not isNil(arg_826_1.actors_["10066ui_story"]) then
				if arg_826_1.var_.characterEffect10066ui_story and not isNil(arg_826_1.actors_["10066ui_story"]) then
					arg_826_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_826_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_826_1.time_ - 0) / var_829_0)
				end
			end

			if arg_826_1.time_ >= 0 + var_829_0 and arg_826_1.time_ < 0 + var_829_0 + arg_829_0 and not isNil(arg_826_1.actors_["10066ui_story"]) and arg_826_1.var_.characterEffect10066ui_story then
				arg_826_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_826_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_829_1 = 0
			local var_829_2 = 0.05

			if 0 < arg_826_1.time_ and arg_826_1.time_ <= var_829_1 + arg_829_0 then
				arg_826_1.talkMaxDuration = 0
				arg_826_1.dialogCg_.alpha = 1

				arg_826_1.dialog_:SetActive(true)
				SetActive(arg_826_1.leftNameGo_, true)

				arg_826_1.leftNameTxt_.text = arg_826_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_826_1.leftNameTxt_.transform)

				arg_826_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_826_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_826_1:RecordName(arg_826_1.leftNameTxt_.text)
				SetActive(arg_826_1.iconTrs_.gameObject, true)
				arg_826_1.iconController_:SetSelectedState("hero")

				arg_826_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_826_1.callingController_:SetSelectedState("normal")

				arg_826_1.keyicon_.color = Color.New(1, 1, 1)
				arg_826_1.icon_.color = Color.New(1, 1, 1)

				local var_829_3 = arg_826_1:FormatText(arg_826_1:GetWordFromCfg(1108106197).content)

				arg_826_1.text_.text = var_829_3

				LuaForUtil.ClearLinePrefixSymbol(arg_826_1.text_)

				local var_829_5 = 2 <= 0 and var_829_2 or var_829_2 * (utf8.len(var_829_3) / 2)

				if (2 <= 0 and var_829_2 or var_829_2 * (utf8.len(var_829_3) / 2)) > 0 and var_829_2 < var_829_5 then
					arg_826_1.talkMaxDuration = var_829_5

					if var_829_5 + var_829_1 > arg_826_1.duration_ then
						arg_826_1.duration_ = var_829_5 + var_829_1
					end
				end

				arg_826_1.text_.text = var_829_3
				arg_826_1.typewritter.percent = 0

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(false)
				arg_826_1:RecordContent(arg_826_1.text_.text)
			end

			local var_829_6 = math.max(var_829_2, arg_826_1.talkMaxDuration)

			if var_829_1 <= arg_826_1.time_ and arg_826_1.time_ < var_829_1 + var_829_6 then
				arg_826_1.typewritter.percent = (arg_826_1.time_ - var_829_1) / var_829_6

				arg_826_1.typewritter:SetDirty()
			end

			if arg_826_1.time_ >= var_829_1 + var_829_6 and arg_826_1.time_ < var_829_1 + var_829_6 + arg_829_0 then
				arg_826_1.typewritter.percent = 1

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(true)
			end
		end

		arg_826_1.nodeConfigList_ = {}

		arg_826_1:InitPlayNodeList()
	end,
	Play1108106198 = function(arg_830_0, arg_830_1)
		arg_830_1.time_ = 0
		arg_830_1.frameCnt_ = 0
		arg_830_1.state_ = "playing"
		arg_830_1.curTalkId_ = 1108106198
		arg_830_1.duration_ = 5

		SetActive(arg_830_1.tipsGo_, false)

		function arg_830_1.onSingleLineFinish_()
			arg_830_1.onSingleLineUpdate_ = nil
			arg_830_1.onSingleLineFinish_ = nil
			arg_830_1.state_ = "waiting"
		end

		function arg_830_1.playNext_(arg_832_0)
			if arg_832_0 == 1 then
				arg_830_0:Play1108106199(arg_830_1)
			end
		end

		function arg_830_1.onSingleLineUpdate_(arg_833_0)
			local var_833_0 = 0.7

			if 0 < arg_830_1.time_ and arg_830_1.time_ <= 0 + arg_833_0 then
				arg_830_1.talkMaxDuration = 0
				arg_830_1.dialogCg_.alpha = 1

				arg_830_1.dialog_:SetActive(true)
				SetActive(arg_830_1.leftNameGo_, true)

				arg_830_1.leftNameTxt_.text = arg_830_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_830_1.leftNameTxt_.transform)

				arg_830_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_830_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_830_1:RecordName(arg_830_1.leftNameTxt_.text)
				SetActive(arg_830_1.iconTrs_.gameObject, true)
				arg_830_1.iconController_:SetSelectedState("hero")

				arg_830_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_830_1.callingController_:SetSelectedState("normal")

				arg_830_1.keyicon_.color = Color.New(1, 1, 1)
				arg_830_1.icon_.color = Color.New(1, 1, 1)

				local var_833_1 = arg_830_1:FormatText(arg_830_1:GetWordFromCfg(1108106198).content)

				arg_830_1.text_.text = var_833_1

				LuaForUtil.ClearLinePrefixSymbol(arg_830_1.text_)

				local var_833_3 = 28 <= 0 and var_833_0 or var_833_0 * (utf8.len(var_833_1) / 28)

				if (28 <= 0 and var_833_0 or var_833_0 * (utf8.len(var_833_1) / 28)) > 0 and var_833_0 < var_833_3 then
					arg_830_1.talkMaxDuration = var_833_3

					if var_833_3 + 0 > arg_830_1.duration_ then
						arg_830_1.duration_ = var_833_3 + 0
					end
				end

				arg_830_1.text_.text = var_833_1
				arg_830_1.typewritter.percent = 0

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(false)
				arg_830_1:RecordContent(arg_830_1.text_.text)
			end

			local var_833_4 = math.max(var_833_0, arg_830_1.talkMaxDuration)

			if 0 <= arg_830_1.time_ and arg_830_1.time_ < 0 + var_833_4 then
				arg_830_1.typewritter.percent = (arg_830_1.time_ - 0) / var_833_4

				arg_830_1.typewritter:SetDirty()
			end

			if arg_830_1.time_ >= 0 + var_833_4 and arg_830_1.time_ < 0 + var_833_4 + arg_833_0 then
				arg_830_1.typewritter.percent = 1

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(true)
			end
		end

		arg_830_1.nodeConfigList_ = {}

		arg_830_1:InitPlayNodeList()
	end,
	Play1108106199 = function(arg_834_0, arg_834_1)
		arg_834_1.time_ = 0
		arg_834_1.frameCnt_ = 0
		arg_834_1.state_ = "playing"
		arg_834_1.curTalkId_ = 1108106199
		arg_834_1.duration_ = 8.5

		SetActive(arg_834_1.tipsGo_, false)

		function arg_834_1.onSingleLineFinish_()
			arg_834_1.onSingleLineUpdate_ = nil
			arg_834_1.onSingleLineFinish_ = nil
			arg_834_1.state_ = "waiting"
		end

		function arg_834_1.playNext_(arg_836_0)
			if arg_836_0 == 1 then
				arg_834_0:Play1108106200(arg_834_1)
			end
		end

		function arg_834_1.onSingleLineUpdate_(arg_837_0)
			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 then
				arg_834_1.var_.moveOldPos10066ui_story = arg_834_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_837_0 = 0.001

			if 0 <= arg_834_1.time_ and arg_834_1.time_ < 0 + var_837_0 then
				arg_834_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_834_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_834_1.time_ - 0) / var_837_0)
				arg_834_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).z)
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles = arg_834_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_834_1.time_ >= 0 + var_837_0 and arg_834_1.time_ < 0 + var_837_0 + arg_837_0 then
				arg_834_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_834_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_834_1.actors_["10066ui_story"].transform.position).z)
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_834_1.actors_["10066ui_story"].transform.localEulerAngles = arg_834_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_837_1 = arg_834_1.actors_["10066ui_story"]

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 and not isNil(var_837_1) and arg_834_1.var_.characterEffect10066ui_story == nil then
				arg_834_1.var_.characterEffect10066ui_story = var_837_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_837_2 = 0.200000002980232

			if 0 <= arg_834_1.time_ and arg_834_1.time_ < 0 + var_837_2 and not isNil(var_837_1) then
				if arg_834_1.var_.characterEffect10066ui_story and not isNil(var_837_1) then
					arg_834_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_834_1.time_ >= 0 + var_837_2 and arg_834_1.time_ < 0 + var_837_2 + arg_837_0 and not isNil(var_837_1) and arg_834_1.var_.characterEffect10066ui_story then
				arg_834_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 then
				arg_834_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 then
				arg_834_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_837_4 = 0
			local var_837_5 = 0.725

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= var_837_4 + arg_837_0 then
				arg_834_1.talkMaxDuration = 0
				arg_834_1.dialogCg_.alpha = 1

				arg_834_1.dialog_:SetActive(true)
				SetActive(arg_834_1.leftNameGo_, true)

				arg_834_1.leftNameTxt_.text = arg_834_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_834_1.leftNameTxt_.transform)

				arg_834_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_834_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_834_1:RecordName(arg_834_1.leftNameTxt_.text)
				SetActive(arg_834_1.iconTrs_.gameObject, false)
				arg_834_1.callingController_:SetSelectedState("normal")

				local var_837_6 = arg_834_1:GetWordFromCfg(1108106199)
				local var_837_7 = arg_834_1:FormatText(var_837_6.content)

				arg_834_1.text_.text = var_837_7

				LuaForUtil.ClearLinePrefixSymbol(arg_834_1.text_)

				local var_837_9 = 29 <= 0 and var_837_5 or var_837_5 * (utf8.len(var_837_7) / 29)

				if (29 <= 0 and var_837_5 or var_837_5 * (utf8.len(var_837_7) / 29)) > 0 and var_837_5 < var_837_9 then
					arg_834_1.talkMaxDuration = var_837_9

					if var_837_9 + var_837_4 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_9 + var_837_4
					end
				end

				arg_834_1.text_.text = var_837_7
				arg_834_1.typewritter.percent = 0

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb") ~= 0 then
					local var_837_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb") / 1000

					if var_837_10 + var_837_4 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_10 + var_837_4
					end

					if var_837_6.prefab_name ~= "" and arg_834_1.actors_[var_837_6.prefab_name] ~= nil then
						local var_837_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_834_1.actors_[var_837_6.prefab_name].transform, "story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")

						arg_834_1:RecordAudio("1108106199", var_837_11)
						arg_834_1:RecordAudio("1108106199", var_837_11)
					else
						arg_834_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")
					end

					arg_834_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")
				end

				arg_834_1:RecordContent(arg_834_1.text_.text)
			end

			local var_837_12 = math.max(var_837_5, arg_834_1.talkMaxDuration)

			if var_837_4 <= arg_834_1.time_ and arg_834_1.time_ < var_837_4 + var_837_12 then
				arg_834_1.typewritter.percent = (arg_834_1.time_ - var_837_4) / var_837_12

				arg_834_1.typewritter:SetDirty()
			end

			if arg_834_1.time_ >= var_837_4 + var_837_12 and arg_834_1.time_ < var_837_4 + var_837_12 + arg_837_0 then
				arg_834_1.typewritter.percent = 1

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(true)
			end
		end

		arg_834_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_834_1:InitPlayNodeList()
	end,
	Play1108106200 = function(arg_838_0, arg_838_1)
		arg_838_1.time_ = 0
		arg_838_1.frameCnt_ = 0
		arg_838_1.state_ = "playing"
		arg_838_1.curTalkId_ = 1108106200
		arg_838_1.duration_ = 7

		SetActive(arg_838_1.tipsGo_, false)

		function arg_838_1.onSingleLineFinish_()
			arg_838_1.onSingleLineUpdate_ = nil
			arg_838_1.onSingleLineFinish_ = nil
			arg_838_1.state_ = "waiting"
		end

		function arg_838_1.playNext_(arg_840_0)
			if arg_840_0 == 1 then
				arg_838_0:Play1108106201(arg_838_1)
			end
		end

		function arg_838_1.onSingleLineUpdate_(arg_841_0)
			if 2 < arg_838_1.time_ and arg_838_1.time_ <= 2 + arg_841_0 then
				arg_838_1.allBtn_.enabled = false
			end

			if arg_838_1.time_ >= 2 + 0.3 and arg_838_1.time_ < 2 + 0.3 + arg_841_0 then
				arg_838_1.allBtn_.enabled = true
			end

			if 1 < arg_838_1.time_ and arg_838_1.time_ <= 1 + arg_841_0 then
				local var_841_0 = arg_838_1.bgs_.ST07b

				arg_838_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_841_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_841_1 = var_841_0:GetComponent("SpriteRenderer")

				if var_841_1 and var_841_1.sprite then
					local var_841_2 = 2 * (var_841_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_841_0.transform.localScale = Vector3.New(var_841_2 / var_841_1.sprite.bounds.size.y < var_841_2 * manager.ui.mainCameraCom_.aspect / var_841_1.sprite.bounds.size.x and var_841_2 * manager.ui.mainCameraCom_.aspect / var_841_1.sprite.bounds.size.x or var_841_2 / var_841_1.sprite.bounds.size.y, var_841_2 / var_841_1.sprite.bounds.size.y < var_841_2 * manager.ui.mainCameraCom_.aspect / var_841_1.sprite.bounds.size.x and var_841_2 * manager.ui.mainCameraCom_.aspect / var_841_1.sprite.bounds.size.x or var_841_2 / var_841_1.sprite.bounds.size.y, 0)
				end

				for iter_841_0, iter_841_1 in pairs(arg_838_1.bgs_) do
					if iter_841_0 ~= "ST07b" then
						iter_841_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_841_3 = 0

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= var_841_3 + arg_841_0 then
				arg_838_1.mask_.enabled = true
				arg_838_1.mask_.raycastTarget = true

				arg_838_1:SetGaussion(false)
			end

			local var_841_4 = 1

			if var_841_3 <= arg_838_1.time_ and arg_838_1.time_ < var_841_3 + var_841_4 then
				local var_841_5 = Color.New(0, 0, 0)

				var_841_5.a = Mathf.Lerp(0, 1, (arg_838_1.time_ - var_841_3) / var_841_4)
				arg_838_1.mask_.color = var_841_5
			end

			if arg_838_1.time_ >= var_841_3 + var_841_4 and arg_838_1.time_ < var_841_3 + var_841_4 + arg_841_0 then
				local var_841_6 = Color.New(0, 0, 0)

				var_841_6.a = 1
				arg_838_1.mask_.color = var_841_6
			end

			local var_841_7 = 1

			if 1 < arg_838_1.time_ and arg_838_1.time_ <= var_841_7 + arg_841_0 then
				arg_838_1.mask_.enabled = true
				arg_838_1.mask_.raycastTarget = true

				arg_838_1:SetGaussion(false)
			end

			local var_841_8 = 2

			if var_841_7 <= arg_838_1.time_ and arg_838_1.time_ < var_841_7 + var_841_8 then
				local var_841_9 = Color.New(0, 0, 0)

				var_841_9.a = Mathf.Lerp(1, 0, (arg_838_1.time_ - var_841_7) / var_841_8)
				arg_838_1.mask_.color = var_841_9
			end

			if arg_838_1.time_ >= var_841_7 + var_841_8 and arg_838_1.time_ < var_841_7 + var_841_8 + arg_841_0 then
				local var_841_10 = Color.New(0, 0, 0)

				arg_838_1.mask_.enabled = false
				var_841_10.a = 0
				arg_838_1.mask_.color = var_841_10
			end

			local var_841_11 = arg_838_1.actors_["10066ui_story"].transform

			if 0.965999998152257 < arg_838_1.time_ and arg_838_1.time_ <= 0.965999998152257 + arg_841_0 then
				arg_838_1.var_.moveOldPos10066ui_story = var_841_11.localPosition
			end

			local var_841_12 = 0.001

			if 0.965999998152257 <= arg_838_1.time_ and arg_838_1.time_ < 0.965999998152257 + var_841_12 then
				var_841_11.localPosition = Vector3.Lerp(arg_838_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_838_1.time_ - 0.965999998152257) / var_841_12)
				var_841_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_841_11.position).x, (manager.ui.mainCamera.transform.position - var_841_11.position).y, (manager.ui.mainCamera.transform.position - var_841_11.position).z)
				var_841_11.localEulerAngles.z = 0
				var_841_11.localEulerAngles.x = 0
				var_841_11.localEulerAngles = var_841_11.localEulerAngles
			end

			if arg_838_1.time_ >= 0.965999998152257 + var_841_12 and arg_838_1.time_ < 0.965999998152257 + var_841_12 + arg_841_0 then
				var_841_11.localPosition = Vector3.New(0, 100, 0)
				var_841_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_841_11.position).x, (manager.ui.mainCamera.transform.position - var_841_11.position).y, (manager.ui.mainCamera.transform.position - var_841_11.position).z)
				var_841_11.localEulerAngles.z = 0
				var_841_11.localEulerAngles.x = 0
				var_841_11.localEulerAngles = var_841_11.localEulerAngles
			end

			if arg_838_1.frameCnt_ <= 1 then
				arg_838_1.dialog_:SetActive(false)
			end

			local var_841_13 = 2
			local var_841_14 = 0.675

			if 2 < arg_838_1.time_ and arg_838_1.time_ <= var_841_13 + arg_841_0 then
				arg_838_1.talkMaxDuration = 0

				arg_838_1.dialog_:SetActive(true)

				arg_838_1.dialogCg_.alpha = 0

				local var_841_15 = LeanTween.value(arg_838_1.dialog_, 0, 1, 0.3)

				var_841_15:setOnUpdate(LuaHelper.FloatAction(function(arg_842_0)
					arg_838_1.dialogCg_.alpha = arg_842_0
				end))
				var_841_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_838_1.dialog_)
					var_841_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_838_1.duration_ = arg_838_1.duration_ + 0.3

				SetActive(arg_838_1.leftNameGo_, false)

				arg_838_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_838_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_838_1:RecordName(arg_838_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_838_1.iconTrs_.gameObject, false)
				arg_838_1.callingController_:SetSelectedState("normal")

				local var_841_16 = arg_838_1:FormatText(arg_838_1:GetWordFromCfg(1108106200).content)

				arg_838_1.text_.text = var_841_16

				LuaForUtil.ClearLinePrefixSymbol(arg_838_1.text_)

				local var_841_18 = 27 <= 0 and var_841_14 or var_841_14 * (utf8.len(var_841_16) / 27)

				if (27 <= 0 and var_841_14 or var_841_14 * (utf8.len(var_841_16) / 27)) > 0 and var_841_14 < var_841_18 then
					arg_838_1.talkMaxDuration = var_841_18
					var_841_13 = var_841_13 + 0.3

					if var_841_18 + var_841_13 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_18 + var_841_13
					end
				end

				arg_838_1.text_.text = var_841_16
				arg_838_1.typewritter.percent = 0

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(false)
				arg_838_1:RecordContent(arg_838_1.text_.text)
			end

			local var_841_19 = var_841_13 + 0.3
			local var_841_20 = math.max(var_841_14, arg_838_1.talkMaxDuration)

			if var_841_13 + 0.3 <= arg_838_1.time_ and arg_838_1.time_ < var_841_19 + var_841_20 then
				arg_838_1.typewritter.percent = (arg_838_1.time_ - var_841_19) / var_841_20

				arg_838_1.typewritter:SetDirty()
			end

			if arg_838_1.time_ >= var_841_19 + var_841_20 and arg_838_1.time_ < var_841_19 + var_841_20 + arg_841_0 then
				arg_838_1.typewritter.percent = 1

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(true)
			end
		end

		arg_838_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152257,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_838_1:InitPlayNodeList()
	end,
	Play1108106201 = function(arg_844_0, arg_844_1)
		arg_844_1.time_ = 0
		arg_844_1.frameCnt_ = 0
		arg_844_1.state_ = "playing"
		arg_844_1.curTalkId_ = 1108106201
		arg_844_1.duration_ = 5

		SetActive(arg_844_1.tipsGo_, false)

		function arg_844_1.onSingleLineFinish_()
			arg_844_1.onSingleLineUpdate_ = nil
			arg_844_1.onSingleLineFinish_ = nil
			arg_844_1.state_ = "waiting"
		end

		function arg_844_1.playNext_(arg_846_0)
			if arg_846_0 == 1 then
				arg_844_0:Play1108106202(arg_844_1)
			end
		end

		function arg_844_1.onSingleLineUpdate_(arg_847_0)
			local var_847_0 = 1.35

			if 0 < arg_844_1.time_ and arg_844_1.time_ <= 0 + arg_847_0 then
				arg_844_1.talkMaxDuration = 0
				arg_844_1.dialogCg_.alpha = 1

				arg_844_1.dialog_:SetActive(true)
				SetActive(arg_844_1.leftNameGo_, false)

				arg_844_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_844_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_844_1:RecordName(arg_844_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_844_1.iconTrs_.gameObject, false)
				arg_844_1.callingController_:SetSelectedState("normal")

				local var_847_1 = arg_844_1:FormatText(arg_844_1:GetWordFromCfg(1108106201).content)

				arg_844_1.text_.text = var_847_1

				LuaForUtil.ClearLinePrefixSymbol(arg_844_1.text_)

				local var_847_3 = 54 <= 0 and var_847_0 or var_847_0 * (utf8.len(var_847_1) / 54)

				if (54 <= 0 and var_847_0 or var_847_0 * (utf8.len(var_847_1) / 54)) > 0 and var_847_0 < var_847_3 then
					arg_844_1.talkMaxDuration = var_847_3

					if var_847_3 + 0 > arg_844_1.duration_ then
						arg_844_1.duration_ = var_847_3 + 0
					end
				end

				arg_844_1.text_.text = var_847_1
				arg_844_1.typewritter.percent = 0

				arg_844_1.typewritter:SetDirty()
				arg_844_1:ShowNextGo(false)
				arg_844_1:RecordContent(arg_844_1.text_.text)
			end

			local var_847_4 = math.max(var_847_0, arg_844_1.talkMaxDuration)

			if 0 <= arg_844_1.time_ and arg_844_1.time_ < 0 + var_847_4 then
				arg_844_1.typewritter.percent = (arg_844_1.time_ - 0) / var_847_4

				arg_844_1.typewritter:SetDirty()
			end

			if arg_844_1.time_ >= 0 + var_847_4 and arg_844_1.time_ < 0 + var_847_4 + arg_847_0 then
				arg_844_1.typewritter.percent = 1

				arg_844_1.typewritter:SetDirty()
				arg_844_1:ShowNextGo(true)
			end
		end

		arg_844_1.nodeConfigList_ = {}

		arg_844_1:InitPlayNodeList()
	end,
	Play1108106202 = function(arg_848_0, arg_848_1)
		arg_848_1.time_ = 0
		arg_848_1.frameCnt_ = 0
		arg_848_1.state_ = "playing"
		arg_848_1.curTalkId_ = 1108106202
		arg_848_1.duration_ = 5

		SetActive(arg_848_1.tipsGo_, false)

		function arg_848_1.onSingleLineFinish_()
			arg_848_1.onSingleLineUpdate_ = nil
			arg_848_1.onSingleLineFinish_ = nil
			arg_848_1.state_ = "waiting"
		end

		function arg_848_1.playNext_(arg_850_0)
			if arg_850_0 == 1 then
				arg_848_0:Play1108106203(arg_848_1)
			end
		end

		function arg_848_1.onSingleLineUpdate_(arg_851_0)
			local var_851_0 = 0.125

			if 0 < arg_848_1.time_ and arg_848_1.time_ <= 0 + arg_851_0 then
				arg_848_1.talkMaxDuration = 0
				arg_848_1.dialogCg_.alpha = 1

				arg_848_1.dialog_:SetActive(true)
				SetActive(arg_848_1.leftNameGo_, true)

				arg_848_1.leftNameTxt_.text = arg_848_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_848_1.leftNameTxt_.transform)

				arg_848_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_848_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_848_1:RecordName(arg_848_1.leftNameTxt_.text)
				SetActive(arg_848_1.iconTrs_.gameObject, true)
				arg_848_1.iconController_:SetSelectedState("hero")

				arg_848_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_848_1.callingController_:SetSelectedState("normal")

				arg_848_1.keyicon_.color = Color.New(1, 1, 1)
				arg_848_1.icon_.color = Color.New(1, 1, 1)

				local var_851_1 = arg_848_1:FormatText(arg_848_1:GetWordFromCfg(1108106202).content)

				arg_848_1.text_.text = var_851_1

				LuaForUtil.ClearLinePrefixSymbol(arg_848_1.text_)

				local var_851_3 = 5 <= 0 and var_851_0 or var_851_0 * (utf8.len(var_851_1) / 5)

				if (5 <= 0 and var_851_0 or var_851_0 * (utf8.len(var_851_1) / 5)) > 0 and var_851_0 < var_851_3 then
					arg_848_1.talkMaxDuration = var_851_3

					if var_851_3 + 0 > arg_848_1.duration_ then
						arg_848_1.duration_ = var_851_3 + 0
					end
				end

				arg_848_1.text_.text = var_851_1
				arg_848_1.typewritter.percent = 0

				arg_848_1.typewritter:SetDirty()
				arg_848_1:ShowNextGo(false)
				arg_848_1:RecordContent(arg_848_1.text_.text)
			end

			local var_851_4 = math.max(var_851_0, arg_848_1.talkMaxDuration)

			if 0 <= arg_848_1.time_ and arg_848_1.time_ < 0 + var_851_4 then
				arg_848_1.typewritter.percent = (arg_848_1.time_ - 0) / var_851_4

				arg_848_1.typewritter:SetDirty()
			end

			if arg_848_1.time_ >= 0 + var_851_4 and arg_848_1.time_ < 0 + var_851_4 + arg_851_0 then
				arg_848_1.typewritter.percent = 1

				arg_848_1.typewritter:SetDirty()
				arg_848_1:ShowNextGo(true)
			end
		end

		arg_848_1.nodeConfigList_ = {}

		arg_848_1:InitPlayNodeList()
	end,
	Play1108106203 = function(arg_852_0, arg_852_1)
		arg_852_1.time_ = 0
		arg_852_1.frameCnt_ = 0
		arg_852_1.state_ = "playing"
		arg_852_1.curTalkId_ = 1108106203
		arg_852_1.duration_ = 5

		SetActive(arg_852_1.tipsGo_, false)

		function arg_852_1.onSingleLineFinish_()
			arg_852_1.onSingleLineUpdate_ = nil
			arg_852_1.onSingleLineFinish_ = nil
			arg_852_1.state_ = "waiting"
		end

		function arg_852_1.playNext_(arg_854_0)
			if arg_854_0 == 1 then
				arg_852_0:Play1108106204(arg_852_1)
			end
		end

		function arg_852_1.onSingleLineUpdate_(arg_855_0)
			local var_855_0 = 0.85

			if 0 < arg_852_1.time_ and arg_852_1.time_ <= 0 + arg_855_0 then
				arg_852_1.talkMaxDuration = 0
				arg_852_1.dialogCg_.alpha = 1

				arg_852_1.dialog_:SetActive(true)
				SetActive(arg_852_1.leftNameGo_, false)

				arg_852_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_852_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_852_1:RecordName(arg_852_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_852_1.iconTrs_.gameObject, false)
				arg_852_1.callingController_:SetSelectedState("normal")

				local var_855_1 = arg_852_1:FormatText(arg_852_1:GetWordFromCfg(1108106203).content)

				arg_852_1.text_.text = var_855_1

				LuaForUtil.ClearLinePrefixSymbol(arg_852_1.text_)

				local var_855_3 = 34 <= 0 and var_855_0 or var_855_0 * (utf8.len(var_855_1) / 34)

				if (34 <= 0 and var_855_0 or var_855_0 * (utf8.len(var_855_1) / 34)) > 0 and var_855_0 < var_855_3 then
					arg_852_1.talkMaxDuration = var_855_3

					if var_855_3 + 0 > arg_852_1.duration_ then
						arg_852_1.duration_ = var_855_3 + 0
					end
				end

				arg_852_1.text_.text = var_855_1
				arg_852_1.typewritter.percent = 0

				arg_852_1.typewritter:SetDirty()
				arg_852_1:ShowNextGo(false)
				arg_852_1:RecordContent(arg_852_1.text_.text)
			end

			local var_855_4 = math.max(var_855_0, arg_852_1.talkMaxDuration)

			if 0 <= arg_852_1.time_ and arg_852_1.time_ < 0 + var_855_4 then
				arg_852_1.typewritter.percent = (arg_852_1.time_ - 0) / var_855_4

				arg_852_1.typewritter:SetDirty()
			end

			if arg_852_1.time_ >= 0 + var_855_4 and arg_852_1.time_ < 0 + var_855_4 + arg_855_0 then
				arg_852_1.typewritter.percent = 1

				arg_852_1.typewritter:SetDirty()
				arg_852_1:ShowNextGo(true)
			end
		end

		arg_852_1.nodeConfigList_ = {}

		arg_852_1:InitPlayNodeList()
	end,
	Play1108106204 = function(arg_856_0, arg_856_1)
		arg_856_1.time_ = 0
		arg_856_1.frameCnt_ = 0
		arg_856_1.state_ = "playing"
		arg_856_1.curTalkId_ = 1108106204
		arg_856_1.duration_ = 1

		SetActive(arg_856_1.tipsGo_, false)

		function arg_856_1.onSingleLineFinish_()
			arg_856_1.onSingleLineUpdate_ = nil
			arg_856_1.onSingleLineFinish_ = nil
			arg_856_1.state_ = "waiting"

			SetActive(arg_856_1.choicesGo_, true)

			for iter_857_0, iter_857_1 in ipairs(arg_856_1.choices_) do
				SetActive(iter_857_1.go, iter_857_0 <= 1)
			end

			arg_856_1.choices_[1].txt.text = arg_856_1:FormatText(StoryChoiceCfg[1000].name)
		end

		function arg_856_1.playNext_(arg_858_0)
			if arg_858_0 == 1 then
				arg_856_0:Play1108106205(arg_856_1)
			end

			arg_856_1:RecordChoiceLog(1108106204, 1000)
		end

		function arg_856_1.onSingleLineUpdate_(arg_859_0)
			return
		end

		arg_856_1.nodeConfigList_ = {}

		arg_856_1:InitPlayNodeList()
	end,
	Play1108106205 = function(arg_860_0, arg_860_1)
		arg_860_1.time_ = 0
		arg_860_1.frameCnt_ = 0
		arg_860_1.state_ = "playing"
		arg_860_1.curTalkId_ = 1108106205
		arg_860_1.duration_ = 5

		SetActive(arg_860_1.tipsGo_, false)

		function arg_860_1.onSingleLineFinish_()
			arg_860_1.onSingleLineUpdate_ = nil
			arg_860_1.onSingleLineFinish_ = nil
			arg_860_1.state_ = "waiting"
		end

		function arg_860_1.playNext_(arg_862_0)
			if arg_862_0 == 1 then
				arg_860_0:Play1108106206(arg_860_1)
			end
		end

		function arg_860_1.onSingleLineUpdate_(arg_863_0)
			local var_863_0 = 1.075

			if 0 < arg_860_1.time_ and arg_860_1.time_ <= 0 + arg_863_0 then
				arg_860_1.talkMaxDuration = 0
				arg_860_1.dialogCg_.alpha = 1

				arg_860_1.dialog_:SetActive(true)
				SetActive(arg_860_1.leftNameGo_, false)

				arg_860_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_860_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_860_1:RecordName(arg_860_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_860_1.iconTrs_.gameObject, false)
				arg_860_1.callingController_:SetSelectedState("normal")

				local var_863_1 = arg_860_1:FormatText(arg_860_1:GetWordFromCfg(1108106205).content)

				arg_860_1.text_.text = var_863_1

				LuaForUtil.ClearLinePrefixSymbol(arg_860_1.text_)

				local var_863_3 = 43 <= 0 and var_863_0 or var_863_0 * (utf8.len(var_863_1) / 43)

				if (43 <= 0 and var_863_0 or var_863_0 * (utf8.len(var_863_1) / 43)) > 0 and var_863_0 < var_863_3 then
					arg_860_1.talkMaxDuration = var_863_3

					if var_863_3 + 0 > arg_860_1.duration_ then
						arg_860_1.duration_ = var_863_3 + 0
					end
				end

				arg_860_1.text_.text = var_863_1
				arg_860_1.typewritter.percent = 0

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(false)
				arg_860_1:RecordContent(arg_860_1.text_.text)
			end

			local var_863_4 = math.max(var_863_0, arg_860_1.talkMaxDuration)

			if 0 <= arg_860_1.time_ and arg_860_1.time_ < 0 + var_863_4 then
				arg_860_1.typewritter.percent = (arg_860_1.time_ - 0) / var_863_4

				arg_860_1.typewritter:SetDirty()
			end

			if arg_860_1.time_ >= 0 + var_863_4 and arg_860_1.time_ < 0 + var_863_4 + arg_863_0 then
				arg_860_1.typewritter.percent = 1

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(true)
			end
		end

		arg_860_1.nodeConfigList_ = {}

		arg_860_1:InitPlayNodeList()
	end,
	Play1108106206 = function(arg_864_0, arg_864_1)
		arg_864_1.time_ = 0
		arg_864_1.frameCnt_ = 0
		arg_864_1.state_ = "playing"
		arg_864_1.curTalkId_ = 1108106206
		arg_864_1.duration_ = 5

		SetActive(arg_864_1.tipsGo_, false)

		function arg_864_1.onSingleLineFinish_()
			arg_864_1.onSingleLineUpdate_ = nil
			arg_864_1.onSingleLineFinish_ = nil
			arg_864_1.state_ = "waiting"
		end

		function arg_864_1.playNext_(arg_866_0)
			if arg_866_0 == 1 then
				arg_864_0:Play1108106207(arg_864_1)
			end
		end

		function arg_864_1.onSingleLineUpdate_(arg_867_0)
			local var_867_0 = 0.5

			if 0 < arg_864_1.time_ and arg_864_1.time_ <= 0 + arg_867_0 then
				arg_864_1.talkMaxDuration = 0
				arg_864_1.dialogCg_.alpha = 1

				arg_864_1.dialog_:SetActive(true)
				SetActive(arg_864_1.leftNameGo_, true)

				arg_864_1.leftNameTxt_.text = arg_864_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_864_1.leftNameTxt_.transform)

				arg_864_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_864_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_864_1:RecordName(arg_864_1.leftNameTxt_.text)
				SetActive(arg_864_1.iconTrs_.gameObject, true)
				arg_864_1.iconController_:SetSelectedState("hero")

				arg_864_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_864_1.callingController_:SetSelectedState("normal")

				arg_864_1.keyicon_.color = Color.New(1, 1, 1)
				arg_864_1.icon_.color = Color.New(1, 1, 1)

				local var_867_1 = arg_864_1:FormatText(arg_864_1:GetWordFromCfg(1108106206).content)

				arg_864_1.text_.text = var_867_1

				LuaForUtil.ClearLinePrefixSymbol(arg_864_1.text_)

				local var_867_3 = 20 <= 0 and var_867_0 or var_867_0 * (utf8.len(var_867_1) / 20)

				if (20 <= 0 and var_867_0 or var_867_0 * (utf8.len(var_867_1) / 20)) > 0 and var_867_0 < var_867_3 then
					arg_864_1.talkMaxDuration = var_867_3

					if var_867_3 + 0 > arg_864_1.duration_ then
						arg_864_1.duration_ = var_867_3 + 0
					end
				end

				arg_864_1.text_.text = var_867_1
				arg_864_1.typewritter.percent = 0

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(false)
				arg_864_1:RecordContent(arg_864_1.text_.text)
			end

			local var_867_4 = math.max(var_867_0, arg_864_1.talkMaxDuration)

			if 0 <= arg_864_1.time_ and arg_864_1.time_ < 0 + var_867_4 then
				arg_864_1.typewritter.percent = (arg_864_1.time_ - 0) / var_867_4

				arg_864_1.typewritter:SetDirty()
			end

			if arg_864_1.time_ >= 0 + var_867_4 and arg_864_1.time_ < 0 + var_867_4 + arg_867_0 then
				arg_864_1.typewritter.percent = 1

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(true)
			end
		end

		arg_864_1.nodeConfigList_ = {}

		arg_864_1:InitPlayNodeList()
	end,
	Play1108106207 = function(arg_868_0, arg_868_1)
		arg_868_1.time_ = 0
		arg_868_1.frameCnt_ = 0
		arg_868_1.state_ = "playing"
		arg_868_1.curTalkId_ = 1108106207
		arg_868_1.duration_ = 5

		SetActive(arg_868_1.tipsGo_, false)

		function arg_868_1.onSingleLineFinish_()
			arg_868_1.onSingleLineUpdate_ = nil
			arg_868_1.onSingleLineFinish_ = nil
			arg_868_1.state_ = "waiting"
		end

		function arg_868_1.playNext_(arg_870_0)
			if arg_870_0 == 1 then
				arg_868_0:Play1108106208(arg_868_1)
			end
		end

		function arg_868_1.onSingleLineUpdate_(arg_871_0)
			local var_871_0 = 0.3

			if 0 < arg_868_1.time_ and arg_868_1.time_ <= 0 + arg_871_0 then
				arg_868_1.talkMaxDuration = 0
				arg_868_1.dialogCg_.alpha = 1

				arg_868_1.dialog_:SetActive(true)
				SetActive(arg_868_1.leftNameGo_, true)

				arg_868_1.leftNameTxt_.text = arg_868_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_868_1.leftNameTxt_.transform)

				arg_868_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_868_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_868_1:RecordName(arg_868_1.leftNameTxt_.text)
				SetActive(arg_868_1.iconTrs_.gameObject, true)
				arg_868_1.iconController_:SetSelectedState("hero")

				arg_868_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_868_1.callingController_:SetSelectedState("normal")

				arg_868_1.keyicon_.color = Color.New(1, 1, 1)
				arg_868_1.icon_.color = Color.New(1, 1, 1)

				local var_871_1 = arg_868_1:FormatText(arg_868_1:GetWordFromCfg(1108106207).content)

				arg_868_1.text_.text = var_871_1

				LuaForUtil.ClearLinePrefixSymbol(arg_868_1.text_)

				local var_871_3 = 12 <= 0 and var_871_0 or var_871_0 * (utf8.len(var_871_1) / 12)

				if (12 <= 0 and var_871_0 or var_871_0 * (utf8.len(var_871_1) / 12)) > 0 and var_871_0 < var_871_3 then
					arg_868_1.talkMaxDuration = var_871_3

					if var_871_3 + 0 > arg_868_1.duration_ then
						arg_868_1.duration_ = var_871_3 + 0
					end
				end

				arg_868_1.text_.text = var_871_1
				arg_868_1.typewritter.percent = 0

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(false)
				arg_868_1:RecordContent(arg_868_1.text_.text)
			end

			local var_871_4 = math.max(var_871_0, arg_868_1.talkMaxDuration)

			if 0 <= arg_868_1.time_ and arg_868_1.time_ < 0 + var_871_4 then
				arg_868_1.typewritter.percent = (arg_868_1.time_ - 0) / var_871_4

				arg_868_1.typewritter:SetDirty()
			end

			if arg_868_1.time_ >= 0 + var_871_4 and arg_868_1.time_ < 0 + var_871_4 + arg_871_0 then
				arg_868_1.typewritter.percent = 1

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(true)
			end
		end

		arg_868_1.nodeConfigList_ = {}

		arg_868_1:InitPlayNodeList()
	end,
	Play1108106208 = function(arg_872_0, arg_872_1)
		arg_872_1.time_ = 0
		arg_872_1.frameCnt_ = 0
		arg_872_1.state_ = "playing"
		arg_872_1.curTalkId_ = 1108106208
		arg_872_1.duration_ = 5

		SetActive(arg_872_1.tipsGo_, false)

		function arg_872_1.onSingleLineFinish_()
			arg_872_1.onSingleLineUpdate_ = nil
			arg_872_1.onSingleLineFinish_ = nil
			arg_872_1.state_ = "waiting"
		end

		function arg_872_1.playNext_(arg_874_0)
			if arg_874_0 == 1 then
				arg_872_0:Play1108106209(arg_872_1)
			end
		end

		function arg_872_1.onSingleLineUpdate_(arg_875_0)
			local var_875_0 = 1.025

			if 0 < arg_872_1.time_ and arg_872_1.time_ <= 0 + arg_875_0 then
				arg_872_1.talkMaxDuration = 0
				arg_872_1.dialogCg_.alpha = 1

				arg_872_1.dialog_:SetActive(true)
				SetActive(arg_872_1.leftNameGo_, false)

				arg_872_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_872_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_872_1:RecordName(arg_872_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_872_1.iconTrs_.gameObject, false)
				arg_872_1.callingController_:SetSelectedState("normal")

				local var_875_1 = arg_872_1:FormatText(arg_872_1:GetWordFromCfg(1108106208).content)

				arg_872_1.text_.text = var_875_1

				LuaForUtil.ClearLinePrefixSymbol(arg_872_1.text_)

				local var_875_3 = 41 <= 0 and var_875_0 or var_875_0 * (utf8.len(var_875_1) / 41)

				if (41 <= 0 and var_875_0 or var_875_0 * (utf8.len(var_875_1) / 41)) > 0 and var_875_0 < var_875_3 then
					arg_872_1.talkMaxDuration = var_875_3

					if var_875_3 + 0 > arg_872_1.duration_ then
						arg_872_1.duration_ = var_875_3 + 0
					end
				end

				arg_872_1.text_.text = var_875_1
				arg_872_1.typewritter.percent = 0

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(false)
				arg_872_1:RecordContent(arg_872_1.text_.text)
			end

			local var_875_4 = math.max(var_875_0, arg_872_1.talkMaxDuration)

			if 0 <= arg_872_1.time_ and arg_872_1.time_ < 0 + var_875_4 then
				arg_872_1.typewritter.percent = (arg_872_1.time_ - 0) / var_875_4

				arg_872_1.typewritter:SetDirty()
			end

			if arg_872_1.time_ >= 0 + var_875_4 and arg_872_1.time_ < 0 + var_875_4 + arg_875_0 then
				arg_872_1.typewritter.percent = 1

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(true)
			end
		end

		arg_872_1.nodeConfigList_ = {}

		arg_872_1:InitPlayNodeList()
	end,
	Play1108106209 = function(arg_876_0, arg_876_1)
		arg_876_1.time_ = 0
		arg_876_1.frameCnt_ = 0
		arg_876_1.state_ = "playing"
		arg_876_1.curTalkId_ = 1108106209
		arg_876_1.duration_ = 5.3

		SetActive(arg_876_1.tipsGo_, false)

		function arg_876_1.onSingleLineFinish_()
			arg_876_1.onSingleLineUpdate_ = nil
			arg_876_1.onSingleLineFinish_ = nil
			arg_876_1.state_ = "waiting"
		end

		function arg_876_1.playNext_(arg_878_0)
			if arg_878_0 == 1 then
				arg_876_0:Play1108106210(arg_876_1)
			end
		end

		function arg_876_1.onSingleLineUpdate_(arg_879_0)
			if 0 < arg_876_1.time_ and arg_876_1.time_ <= 0 + arg_879_0 then
				arg_876_1.var_.moveOldPos1081ui_story = arg_876_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_879_0 = 0.001

			if 0 <= arg_876_1.time_ and arg_876_1.time_ < 0 + var_879_0 then
				arg_876_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_876_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_876_1.time_ - 0) / var_879_0)
				arg_876_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).z)
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles = arg_876_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_876_1.time_ >= 0 + var_879_0 and arg_876_1.time_ < 0 + var_879_0 + arg_879_0 then
				arg_876_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_876_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_876_1.actors_["1081ui_story"].transform.position).z)
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_876_1.actors_["1081ui_story"].transform.localEulerAngles = arg_876_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_879_1 = arg_876_1.actors_["1081ui_story"]

			if 0 < arg_876_1.time_ and arg_876_1.time_ <= 0 + arg_879_0 and not isNil(var_879_1) and arg_876_1.var_.characterEffect1081ui_story == nil then
				arg_876_1.var_.characterEffect1081ui_story = var_879_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_879_2 = 0.200000002980232

			if 0 <= arg_876_1.time_ and arg_876_1.time_ < 0 + var_879_2 and not isNil(var_879_1) then
				if arg_876_1.var_.characterEffect1081ui_story and not isNil(var_879_1) then
					arg_876_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_876_1.time_ >= 0 + var_879_2 and arg_876_1.time_ < 0 + var_879_2 + arg_879_0 and not isNil(var_879_1) and arg_876_1.var_.characterEffect1081ui_story then
				arg_876_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_876_1.time_ and arg_876_1.time_ <= 0 + arg_879_0 then
				arg_876_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_876_1.time_ and arg_876_1.time_ <= 0 + arg_879_0 then
				arg_876_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_879_4 = 0
			local var_879_5 = 0.65

			if 0 < arg_876_1.time_ and arg_876_1.time_ <= var_879_4 + arg_879_0 then
				arg_876_1.talkMaxDuration = 0
				arg_876_1.dialogCg_.alpha = 1

				arg_876_1.dialog_:SetActive(true)
				SetActive(arg_876_1.leftNameGo_, true)

				arg_876_1.leftNameTxt_.text = arg_876_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_876_1.leftNameTxt_.transform)

				arg_876_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_876_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_876_1:RecordName(arg_876_1.leftNameTxt_.text)
				SetActive(arg_876_1.iconTrs_.gameObject, false)
				arg_876_1.callingController_:SetSelectedState("normal")

				local var_879_6 = arg_876_1:GetWordFromCfg(1108106209)
				local var_879_7 = arg_876_1:FormatText(var_879_6.content)

				arg_876_1.text_.text = var_879_7

				LuaForUtil.ClearLinePrefixSymbol(arg_876_1.text_)

				local var_879_9 = 26 <= 0 and var_879_5 or var_879_5 * (utf8.len(var_879_7) / 26)

				if (26 <= 0 and var_879_5 or var_879_5 * (utf8.len(var_879_7) / 26)) > 0 and var_879_5 < var_879_9 then
					arg_876_1.talkMaxDuration = var_879_9

					if var_879_9 + var_879_4 > arg_876_1.duration_ then
						arg_876_1.duration_ = var_879_9 + var_879_4
					end
				end

				arg_876_1.text_.text = var_879_7
				arg_876_1.typewritter.percent = 0

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb") ~= 0 then
					local var_879_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb") / 1000

					if var_879_10 + var_879_4 > arg_876_1.duration_ then
						arg_876_1.duration_ = var_879_10 + var_879_4
					end

					if var_879_6.prefab_name ~= "" and arg_876_1.actors_[var_879_6.prefab_name] ~= nil then
						local var_879_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_876_1.actors_[var_879_6.prefab_name].transform, "story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")

						arg_876_1:RecordAudio("1108106209", var_879_11)
						arg_876_1:RecordAudio("1108106209", var_879_11)
					else
						arg_876_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")
					end

					arg_876_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")
				end

				arg_876_1:RecordContent(arg_876_1.text_.text)
			end

			local var_879_12 = math.max(var_879_5, arg_876_1.talkMaxDuration)

			if var_879_4 <= arg_876_1.time_ and arg_876_1.time_ < var_879_4 + var_879_12 then
				arg_876_1.typewritter.percent = (arg_876_1.time_ - var_879_4) / var_879_12

				arg_876_1.typewritter:SetDirty()
			end

			if arg_876_1.time_ >= var_879_4 + var_879_12 and arg_876_1.time_ < var_879_4 + var_879_12 + arg_879_0 then
				arg_876_1.typewritter.percent = 1

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(true)
			end
		end

		arg_876_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_876_1:InitPlayNodeList()
	end,
	Play1108106210 = function(arg_880_0, arg_880_1)
		arg_880_1.time_ = 0
		arg_880_1.frameCnt_ = 0
		arg_880_1.state_ = "playing"
		arg_880_1.curTalkId_ = 1108106210
		arg_880_1.duration_ = 5

		SetActive(arg_880_1.tipsGo_, false)

		function arg_880_1.onSingleLineFinish_()
			arg_880_1.onSingleLineUpdate_ = nil
			arg_880_1.onSingleLineFinish_ = nil
			arg_880_1.state_ = "waiting"
		end

		function arg_880_1.playNext_(arg_882_0)
			if arg_882_0 == 1 then
				arg_880_0:Play1108106211(arg_880_1)
			end
		end

		function arg_880_1.onSingleLineUpdate_(arg_883_0)
			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 then
				arg_880_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_2")
			end

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 then
				arg_880_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_883_0 = arg_880_1.actors_["1081ui_story"]

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 and not isNil(var_883_0) and arg_880_1.var_.characterEffect1081ui_story == nil then
				arg_880_1.var_.characterEffect1081ui_story = var_883_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_883_1 = 0.2

			if 0 <= arg_880_1.time_ and arg_880_1.time_ < 0 + var_883_1 and not isNil(var_883_0) then
				if arg_880_1.var_.characterEffect1081ui_story and not isNil(var_883_0) then
					arg_880_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_880_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_880_1.time_ - 0) / var_883_1)
				end
			end

			if arg_880_1.time_ >= 0 + var_883_1 and arg_880_1.time_ < 0 + var_883_1 + arg_883_0 and not isNil(var_883_0) and arg_880_1.var_.characterEffect1081ui_story then
				arg_880_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_880_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_883_2 = 0
			local var_883_3 = 0.825

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= var_883_2 + arg_883_0 then
				arg_880_1.talkMaxDuration = 0
				arg_880_1.dialogCg_.alpha = 1

				arg_880_1.dialog_:SetActive(true)
				SetActive(arg_880_1.leftNameGo_, false)

				arg_880_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_880_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_880_1:RecordName(arg_880_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_880_1.iconTrs_.gameObject, false)
				arg_880_1.callingController_:SetSelectedState("normal")

				local var_883_4 = arg_880_1:FormatText(arg_880_1:GetWordFromCfg(1108106210).content)

				arg_880_1.text_.text = var_883_4

				LuaForUtil.ClearLinePrefixSymbol(arg_880_1.text_)

				local var_883_6 = 33 <= 0 and var_883_3 or var_883_3 * (utf8.len(var_883_4) / 33)

				if (33 <= 0 and var_883_3 or var_883_3 * (utf8.len(var_883_4) / 33)) > 0 and var_883_3 < var_883_6 then
					arg_880_1.talkMaxDuration = var_883_6

					if var_883_6 + var_883_2 > arg_880_1.duration_ then
						arg_880_1.duration_ = var_883_6 + var_883_2
					end
				end

				arg_880_1.text_.text = var_883_4
				arg_880_1.typewritter.percent = 0

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(false)
				arg_880_1:RecordContent(arg_880_1.text_.text)
			end

			local var_883_7 = math.max(var_883_3, arg_880_1.talkMaxDuration)

			if var_883_2 <= arg_880_1.time_ and arg_880_1.time_ < var_883_2 + var_883_7 then
				arg_880_1.typewritter.percent = (arg_880_1.time_ - var_883_2) / var_883_7

				arg_880_1.typewritter:SetDirty()
			end

			if arg_880_1.time_ >= var_883_2 + var_883_7 and arg_880_1.time_ < var_883_2 + var_883_7 + arg_883_0 then
				arg_880_1.typewritter.percent = 1

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(true)
			end
		end

		arg_880_1.nodeConfigList_ = {}

		arg_880_1:InitPlayNodeList()
	end,
	Play1108106211 = function(arg_884_0, arg_884_1)
		arg_884_1.time_ = 0
		arg_884_1.frameCnt_ = 0
		arg_884_1.state_ = "playing"
		arg_884_1.curTalkId_ = 1108106211
		arg_884_1.duration_ = 7.3

		SetActive(arg_884_1.tipsGo_, false)

		function arg_884_1.onSingleLineFinish_()
			arg_884_1.onSingleLineUpdate_ = nil
			arg_884_1.onSingleLineFinish_ = nil
			arg_884_1.state_ = "waiting"
		end

		function arg_884_1.playNext_(arg_886_0)
			if arg_886_0 == 1 then
				arg_884_0:Play1108106212(arg_884_1)
			end
		end

		function arg_884_1.onSingleLineUpdate_(arg_887_0)
			if 0 < arg_884_1.time_ and arg_884_1.time_ <= 0 + arg_887_0 and not isNil(arg_884_1.actors_["1081ui_story"]) and arg_884_1.var_.characterEffect1081ui_story == nil then
				arg_884_1.var_.characterEffect1081ui_story = arg_884_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_887_0 = 0.200000002980232

			if 0 <= arg_884_1.time_ and arg_884_1.time_ < 0 + var_887_0 and not isNil(arg_884_1.actors_["1081ui_story"]) then
				if arg_884_1.var_.characterEffect1081ui_story and not isNil(arg_884_1.actors_["1081ui_story"]) then
					arg_884_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_884_1.time_ >= 0 + var_887_0 and arg_884_1.time_ < 0 + var_887_0 + arg_887_0 and not isNil(arg_884_1.actors_["1081ui_story"]) and arg_884_1.var_.characterEffect1081ui_story then
				arg_884_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_887_2 = 0
			local var_887_3 = 0.95

			if 0 < arg_884_1.time_ and arg_884_1.time_ <= var_887_2 + arg_887_0 then
				arg_884_1.talkMaxDuration = 0
				arg_884_1.dialogCg_.alpha = 1

				arg_884_1.dialog_:SetActive(true)
				SetActive(arg_884_1.leftNameGo_, true)

				arg_884_1.leftNameTxt_.text = arg_884_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_884_1.leftNameTxt_.transform)

				arg_884_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_884_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_884_1:RecordName(arg_884_1.leftNameTxt_.text)
				SetActive(arg_884_1.iconTrs_.gameObject, false)
				arg_884_1.callingController_:SetSelectedState("normal")

				local var_887_4 = arg_884_1:GetWordFromCfg(1108106211)
				local var_887_5 = arg_884_1:FormatText(var_887_4.content)

				arg_884_1.text_.text = var_887_5

				LuaForUtil.ClearLinePrefixSymbol(arg_884_1.text_)

				local var_887_7 = 38 <= 0 and var_887_3 or var_887_3 * (utf8.len(var_887_5) / 38)

				if (38 <= 0 and var_887_3 or var_887_3 * (utf8.len(var_887_5) / 38)) > 0 and var_887_3 < var_887_7 then
					arg_884_1.talkMaxDuration = var_887_7

					if var_887_7 + var_887_2 > arg_884_1.duration_ then
						arg_884_1.duration_ = var_887_7 + var_887_2
					end
				end

				arg_884_1.text_.text = var_887_5
				arg_884_1.typewritter.percent = 0

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb") ~= 0 then
					local var_887_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb") / 1000

					if var_887_8 + var_887_2 > arg_884_1.duration_ then
						arg_884_1.duration_ = var_887_8 + var_887_2
					end

					if var_887_4.prefab_name ~= "" and arg_884_1.actors_[var_887_4.prefab_name] ~= nil then
						local var_887_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_884_1.actors_[var_887_4.prefab_name].transform, "story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")

						arg_884_1:RecordAudio("1108106211", var_887_9)
						arg_884_1:RecordAudio("1108106211", var_887_9)
					else
						arg_884_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")
					end

					arg_884_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")
				end

				arg_884_1:RecordContent(arg_884_1.text_.text)
			end

			local var_887_10 = math.max(var_887_3, arg_884_1.talkMaxDuration)

			if var_887_2 <= arg_884_1.time_ and arg_884_1.time_ < var_887_2 + var_887_10 then
				arg_884_1.typewritter.percent = (arg_884_1.time_ - var_887_2) / var_887_10

				arg_884_1.typewritter:SetDirty()
			end

			if arg_884_1.time_ >= var_887_2 + var_887_10 and arg_884_1.time_ < var_887_2 + var_887_10 + arg_887_0 then
				arg_884_1.typewritter.percent = 1

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(true)
			end
		end

		arg_884_1.nodeConfigList_ = {}

		arg_884_1:InitPlayNodeList()
	end,
	Play1108106212 = function(arg_888_0, arg_888_1)
		arg_888_1.time_ = 0
		arg_888_1.frameCnt_ = 0
		arg_888_1.state_ = "playing"
		arg_888_1.curTalkId_ = 1108106212
		arg_888_1.duration_ = 5

		SetActive(arg_888_1.tipsGo_, false)

		function arg_888_1.onSingleLineFinish_()
			arg_888_1.onSingleLineUpdate_ = nil
			arg_888_1.onSingleLineFinish_ = nil
			arg_888_1.state_ = "waiting"
		end

		function arg_888_1.playNext_(arg_890_0)
			if arg_890_0 == 1 then
				arg_888_0:Play1108106213(arg_888_1)
			end
		end

		function arg_888_1.onSingleLineUpdate_(arg_891_0)
			if 0 < arg_888_1.time_ and arg_888_1.time_ <= 0 + arg_891_0 then
				arg_888_1.var_.moveOldPos1081ui_story = arg_888_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_891_0 = 0.001

			if 0 <= arg_888_1.time_ and arg_888_1.time_ < 0 + var_891_0 then
				arg_888_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_888_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_888_1.time_ - 0) / var_891_0)
				arg_888_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).z)
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles = arg_888_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_888_1.time_ >= 0 + var_891_0 and arg_888_1.time_ < 0 + var_891_0 + arg_891_0 then
				arg_888_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_888_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1081ui_story"].transform.position).z)
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_888_1.actors_["1081ui_story"].transform.localEulerAngles = arg_888_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_891_1 = 0
			local var_891_2 = 0.05

			if 0 < arg_888_1.time_ and arg_888_1.time_ <= var_891_1 + arg_891_0 then
				arg_888_1.talkMaxDuration = 0
				arg_888_1.dialogCg_.alpha = 1

				arg_888_1.dialog_:SetActive(true)
				SetActive(arg_888_1.leftNameGo_, true)

				arg_888_1.leftNameTxt_.text = arg_888_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_888_1.leftNameTxt_.transform)

				arg_888_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_888_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_888_1:RecordName(arg_888_1.leftNameTxt_.text)
				SetActive(arg_888_1.iconTrs_.gameObject, true)
				arg_888_1.iconController_:SetSelectedState("hero")

				arg_888_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_888_1.callingController_:SetSelectedState("normal")

				arg_888_1.keyicon_.color = Color.New(1, 1, 1)
				arg_888_1.icon_.color = Color.New(1, 1, 1)

				local var_891_3 = arg_888_1:FormatText(arg_888_1:GetWordFromCfg(1108106212).content)

				arg_888_1.text_.text = var_891_3

				LuaForUtil.ClearLinePrefixSymbol(arg_888_1.text_)

				local var_891_5 = 2 <= 0 and var_891_2 or var_891_2 * (utf8.len(var_891_3) / 2)

				if (2 <= 0 and var_891_2 or var_891_2 * (utf8.len(var_891_3) / 2)) > 0 and var_891_2 < var_891_5 then
					arg_888_1.talkMaxDuration = var_891_5

					if var_891_5 + var_891_1 > arg_888_1.duration_ then
						arg_888_1.duration_ = var_891_5 + var_891_1
					end
				end

				arg_888_1.text_.text = var_891_3
				arg_888_1.typewritter.percent = 0

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(false)
				arg_888_1:RecordContent(arg_888_1.text_.text)
			end

			local var_891_6 = math.max(var_891_2, arg_888_1.talkMaxDuration)

			if var_891_1 <= arg_888_1.time_ and arg_888_1.time_ < var_891_1 + var_891_6 then
				arg_888_1.typewritter.percent = (arg_888_1.time_ - var_891_1) / var_891_6

				arg_888_1.typewritter:SetDirty()
			end

			if arg_888_1.time_ >= var_891_1 + var_891_6 and arg_888_1.time_ < var_891_1 + var_891_6 + arg_891_0 then
				arg_888_1.typewritter.percent = 1

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(true)
			end
		end

		arg_888_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_888_1:InitPlayNodeList()
	end,
	Play1108106213 = function(arg_892_0, arg_892_1)
		arg_892_1.time_ = 0
		arg_892_1.frameCnt_ = 0
		arg_892_1.state_ = "playing"
		arg_892_1.curTalkId_ = 1108106213
		arg_892_1.duration_ = 1

		SetActive(arg_892_1.tipsGo_, false)

		function arg_892_1.onSingleLineFinish_()
			arg_892_1.onSingleLineUpdate_ = nil
			arg_892_1.onSingleLineFinish_ = nil
			arg_892_1.state_ = "waiting"

			SetActive(arg_892_1.choicesGo_, true)

			for iter_893_0, iter_893_1 in ipairs(arg_892_1.choices_) do
				SetActive(iter_893_1.go, iter_893_0 <= 1)
			end

			arg_892_1.choices_[1].txt.text = arg_892_1:FormatText(StoryChoiceCfg[1001].name)
		end

		function arg_892_1.playNext_(arg_894_0)
			if arg_894_0 == 1 then
				arg_892_0:Play1108106214(arg_892_1)
			end

			arg_892_1:RecordChoiceLog(1108106213, 1001)
		end

		function arg_892_1.onSingleLineUpdate_(arg_895_0)
			return
		end

		arg_892_1.nodeConfigList_ = {}

		arg_892_1:InitPlayNodeList()
	end,
	Play1108106214 = function(arg_896_0, arg_896_1)
		arg_896_1.time_ = 0
		arg_896_1.frameCnt_ = 0
		arg_896_1.state_ = "playing"
		arg_896_1.curTalkId_ = 1108106214
		arg_896_1.duration_ = 8.12

		SetActive(arg_896_1.tipsGo_, false)

		function arg_896_1.onSingleLineFinish_()
			arg_896_1.onSingleLineUpdate_ = nil
			arg_896_1.onSingleLineFinish_ = nil
			arg_896_1.state_ = "waiting"
		end

		function arg_896_1.playNext_(arg_898_0)
			if arg_898_0 == 1 then
				arg_896_0:Play1108106215(arg_896_1)
			end
		end

		function arg_896_1.onSingleLineUpdate_(arg_899_0)
			if 2 < arg_896_1.time_ and arg_896_1.time_ <= 2 + arg_899_0 then
				local var_899_0 = arg_896_1.bgs_.ST07b

				arg_896_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_899_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_899_1 = var_899_0:GetComponent("SpriteRenderer")

				if var_899_1 and var_899_1.sprite then
					local var_899_2 = 2 * (var_899_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_899_0.transform.localScale = Vector3.New(var_899_2 / var_899_1.sprite.bounds.size.y < var_899_2 * manager.ui.mainCameraCom_.aspect / var_899_1.sprite.bounds.size.x and var_899_2 * manager.ui.mainCameraCom_.aspect / var_899_1.sprite.bounds.size.x or var_899_2 / var_899_1.sprite.bounds.size.y, var_899_2 / var_899_1.sprite.bounds.size.y < var_899_2 * manager.ui.mainCameraCom_.aspect / var_899_1.sprite.bounds.size.x and var_899_2 * manager.ui.mainCameraCom_.aspect / var_899_1.sprite.bounds.size.x or var_899_2 / var_899_1.sprite.bounds.size.y, 0)
				end

				for iter_899_0, iter_899_1 in pairs(arg_896_1.bgs_) do
					if iter_899_0 ~= "ST07b" then
						iter_899_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_899_3 = 0

			if 0 < arg_896_1.time_ and arg_896_1.time_ <= var_899_3 + arg_899_0 then
				arg_896_1.mask_.enabled = true
				arg_896_1.mask_.raycastTarget = true

				arg_896_1:SetGaussion(false)
			end

			local var_899_4 = 2

			if var_899_3 <= arg_896_1.time_ and arg_896_1.time_ < var_899_3 + var_899_4 then
				local var_899_5 = Color.New(0, 0, 0)

				var_899_5.a = Mathf.Lerp(0, 1, (arg_896_1.time_ - var_899_3) / var_899_4)
				arg_896_1.mask_.color = var_899_5
			end

			if arg_896_1.time_ >= var_899_3 + var_899_4 and arg_896_1.time_ < var_899_3 + var_899_4 + arg_899_0 then
				local var_899_6 = Color.New(0, 0, 0)

				var_899_6.a = 1
				arg_896_1.mask_.color = var_899_6
			end

			local var_899_7 = 2

			if 2 < arg_896_1.time_ and arg_896_1.time_ <= var_899_7 + arg_899_0 then
				arg_896_1.mask_.enabled = true
				arg_896_1.mask_.raycastTarget = true

				arg_896_1:SetGaussion(false)
			end

			local var_899_8 = 2

			if var_899_7 <= arg_896_1.time_ and arg_896_1.time_ < var_899_7 + var_899_8 then
				local var_899_9 = Color.New(0, 0, 0)

				var_899_9.a = Mathf.Lerp(1, 0, (arg_896_1.time_ - var_899_7) / var_899_8)
				arg_896_1.mask_.color = var_899_9
			end

			if arg_896_1.time_ >= var_899_7 + var_899_8 and arg_896_1.time_ < var_899_7 + var_899_8 + arg_899_0 then
				local var_899_10 = Color.New(0, 0, 0)

				arg_896_1.mask_.enabled = false
				var_899_10.a = 0
				arg_896_1.mask_.color = var_899_10
			end

			if arg_896_1.frameCnt_ <= 1 then
				arg_896_1.dialog_:SetActive(false)
			end

			local var_899_11 = 3.125
			local var_899_12 = 0.875

			if 3.125 < arg_896_1.time_ and arg_896_1.time_ <= var_899_11 + arg_899_0 then
				arg_896_1.talkMaxDuration = 0

				arg_896_1.dialog_:SetActive(true)

				arg_896_1.dialogCg_.alpha = 0

				local var_899_13 = LeanTween.value(arg_896_1.dialog_, 0, 1, 0.3)

				var_899_13:setOnUpdate(LuaHelper.FloatAction(function(arg_900_0)
					arg_896_1.dialogCg_.alpha = arg_900_0
				end))
				var_899_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_896_1.dialog_)
					var_899_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_896_1.duration_ = arg_896_1.duration_ + 0.3

				SetActive(arg_896_1.leftNameGo_, true)

				arg_896_1.leftNameTxt_.text = arg_896_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_896_1.leftNameTxt_.transform)

				arg_896_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_896_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_896_1:RecordName(arg_896_1.leftNameTxt_.text)
				SetActive(arg_896_1.iconTrs_.gameObject, true)
				arg_896_1.iconController_:SetSelectedState("hero")

				arg_896_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_896_1.callingController_:SetSelectedState("normal")

				arg_896_1.keyicon_.color = Color.New(1, 1, 1)
				arg_896_1.icon_.color = Color.New(1, 1, 1)

				local var_899_14 = arg_896_1:FormatText(arg_896_1:GetWordFromCfg(1108106214).content)

				arg_896_1.text_.text = var_899_14

				LuaForUtil.ClearLinePrefixSymbol(arg_896_1.text_)

				local var_899_16 = 35 <= 0 and var_899_12 or var_899_12 * (utf8.len(var_899_14) / 35)

				if (35 <= 0 and var_899_12 or var_899_12 * (utf8.len(var_899_14) / 35)) > 0 and var_899_12 < var_899_16 then
					arg_896_1.talkMaxDuration = var_899_16
					var_899_11 = var_899_11 + 0.3

					if var_899_16 + var_899_11 > arg_896_1.duration_ then
						arg_896_1.duration_ = var_899_16 + var_899_11
					end
				end

				arg_896_1.text_.text = var_899_14
				arg_896_1.typewritter.percent = 0

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(false)
				arg_896_1:RecordContent(arg_896_1.text_.text)
			end

			local var_899_17 = var_899_11 + 0.3
			local var_899_18 = math.max(var_899_12, arg_896_1.talkMaxDuration)

			if var_899_11 + 0.3 <= arg_896_1.time_ and arg_896_1.time_ < var_899_17 + var_899_18 then
				arg_896_1.typewritter.percent = (arg_896_1.time_ - var_899_17) / var_899_18

				arg_896_1.typewritter:SetDirty()
			end

			if arg_896_1.time_ >= var_899_17 + var_899_18 and arg_896_1.time_ < var_899_17 + var_899_18 + arg_899_0 then
				arg_896_1.typewritter.percent = 1

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(true)
			end
		end

		arg_896_1.nodeConfigList_ = {}

		arg_896_1:InitPlayNodeList()
	end,
	Play1108106215 = function(arg_902_0, arg_902_1)
		arg_902_1.time_ = 0
		arg_902_1.frameCnt_ = 0
		arg_902_1.state_ = "playing"
		arg_902_1.curTalkId_ = 1108106215
		arg_902_1.duration_ = 5.27

		SetActive(arg_902_1.tipsGo_, false)

		function arg_902_1.onSingleLineFinish_()
			arg_902_1.onSingleLineUpdate_ = nil
			arg_902_1.onSingleLineFinish_ = nil
			arg_902_1.state_ = "waiting"
		end

		function arg_902_1.playNext_(arg_904_0)
			if arg_904_0 == 1 then
				arg_902_0:Play1108106216(arg_902_1)
			end
		end

		function arg_902_1.onSingleLineUpdate_(arg_905_0)
			if 0 < arg_902_1.time_ and arg_902_1.time_ <= 0 + arg_905_0 then
				arg_902_1.var_.moveOldPos1081ui_story = arg_902_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_905_0 = 0.001

			if 0 <= arg_902_1.time_ and arg_902_1.time_ < 0 + var_905_0 then
				arg_902_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_902_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_902_1.time_ - 0) / var_905_0)
				arg_902_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).z)
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles = arg_902_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_902_1.time_ >= 0 + var_905_0 and arg_902_1.time_ < 0 + var_905_0 + arg_905_0 then
				arg_902_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_902_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_902_1.actors_["1081ui_story"].transform.position).z)
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_902_1.actors_["1081ui_story"].transform.localEulerAngles = arg_902_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_905_1 = arg_902_1.actors_["1081ui_story"]

			if 0 < arg_902_1.time_ and arg_902_1.time_ <= 0 + arg_905_0 and not isNil(var_905_1) and arg_902_1.var_.characterEffect1081ui_story == nil then
				arg_902_1.var_.characterEffect1081ui_story = var_905_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_905_2 = 0.200000002980232

			if 0 <= arg_902_1.time_ and arg_902_1.time_ < 0 + var_905_2 and not isNil(var_905_1) then
				if arg_902_1.var_.characterEffect1081ui_story and not isNil(var_905_1) then
					arg_902_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_902_1.time_ >= 0 + var_905_2 and arg_902_1.time_ < 0 + var_905_2 + arg_905_0 and not isNil(var_905_1) and arg_902_1.var_.characterEffect1081ui_story then
				arg_902_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_902_1.time_ and arg_902_1.time_ <= 0 + arg_905_0 then
				arg_902_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			if 0 < arg_902_1.time_ and arg_902_1.time_ <= 0 + arg_905_0 then
				arg_902_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_905_4 = 0
			local var_905_5 = 0.9

			if 0 < arg_902_1.time_ and arg_902_1.time_ <= var_905_4 + arg_905_0 then
				arg_902_1.talkMaxDuration = 0
				arg_902_1.dialogCg_.alpha = 1

				arg_902_1.dialog_:SetActive(true)
				SetActive(arg_902_1.leftNameGo_, true)

				arg_902_1.leftNameTxt_.text = arg_902_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_902_1.leftNameTxt_.transform)

				arg_902_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_902_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_902_1:RecordName(arg_902_1.leftNameTxt_.text)
				SetActive(arg_902_1.iconTrs_.gameObject, false)
				arg_902_1.callingController_:SetSelectedState("normal")

				local var_905_6 = arg_902_1:GetWordFromCfg(1108106215)
				local var_905_7 = arg_902_1:FormatText(var_905_6.content)

				arg_902_1.text_.text = var_905_7

				LuaForUtil.ClearLinePrefixSymbol(arg_902_1.text_)

				local var_905_9 = 36 <= 0 and var_905_5 or var_905_5 * (utf8.len(var_905_7) / 36)

				if (36 <= 0 and var_905_5 or var_905_5 * (utf8.len(var_905_7) / 36)) > 0 and var_905_5 < var_905_9 then
					arg_902_1.talkMaxDuration = var_905_9

					if var_905_9 + var_905_4 > arg_902_1.duration_ then
						arg_902_1.duration_ = var_905_9 + var_905_4
					end
				end

				arg_902_1.text_.text = var_905_7
				arg_902_1.typewritter.percent = 0

				arg_902_1.typewritter:SetDirty()
				arg_902_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb") ~= 0 then
					local var_905_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb") / 1000

					if var_905_10 + var_905_4 > arg_902_1.duration_ then
						arg_902_1.duration_ = var_905_10 + var_905_4
					end

					if var_905_6.prefab_name ~= "" and arg_902_1.actors_[var_905_6.prefab_name] ~= nil then
						local var_905_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_902_1.actors_[var_905_6.prefab_name].transform, "story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")

						arg_902_1:RecordAudio("1108106215", var_905_11)
						arg_902_1:RecordAudio("1108106215", var_905_11)
					else
						arg_902_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")
					end

					arg_902_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")
				end

				arg_902_1:RecordContent(arg_902_1.text_.text)
			end

			local var_905_12 = math.max(var_905_5, arg_902_1.talkMaxDuration)

			if var_905_4 <= arg_902_1.time_ and arg_902_1.time_ < var_905_4 + var_905_12 then
				arg_902_1.typewritter.percent = (arg_902_1.time_ - var_905_4) / var_905_12

				arg_902_1.typewritter:SetDirty()
			end

			if arg_902_1.time_ >= var_905_4 + var_905_12 and arg_902_1.time_ < var_905_4 + var_905_12 + arg_905_0 then
				arg_902_1.typewritter.percent = 1

				arg_902_1.typewritter:SetDirty()
				arg_902_1:ShowNextGo(true)
			end
		end

		arg_902_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_902_1:InitPlayNodeList()
	end,
	Play1108106216 = function(arg_906_0, arg_906_1)
		arg_906_1.time_ = 0
		arg_906_1.frameCnt_ = 0
		arg_906_1.state_ = "playing"
		arg_906_1.curTalkId_ = 1108106216
		arg_906_1.duration_ = 1

		SetActive(arg_906_1.tipsGo_, true)

		arg_906_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_906_1.onSingleLineFinish_()
			arg_906_1.onSingleLineUpdate_ = nil
			arg_906_1.onSingleLineFinish_ = nil
			arg_906_1.state_ = "waiting"

			SetActive(arg_906_1.choicesGo_, true)

			for iter_907_0, iter_907_1 in ipairs(arg_906_1.choices_) do
				SetActive(iter_907_1.go, iter_907_0 <= 2)
			end

			arg_906_1.choices_[1].txt.text = arg_906_1:FormatText(StoryChoiceCfg[1002].name)
			arg_906_1.choices_[2].txt.text = arg_906_1:FormatText(StoryChoiceCfg[1003].name)
		end

		function arg_906_1.playNext_(arg_908_0)
			if arg_908_0 == 1 then
				PlayerAction.UseStoryTrigger(1081013, 210810106, 1108106216, 1)
				arg_906_0:Play1108106217(arg_906_1)
			end

			if arg_908_0 == 2 then
				PlayerAction.UseStoryTrigger(1081013, 210810106, 1108106216, 2)
				arg_906_0:Play1108106218(arg_906_1)
			end

			arg_906_1:RecordChoiceLog(1108106216, 1002, 1003)
		end

		function arg_906_1.onSingleLineUpdate_(arg_909_0)
			if 0 < arg_906_1.time_ and arg_906_1.time_ <= 0 + arg_909_0 and not isNil(arg_906_1.actors_["1081ui_story"]) and arg_906_1.var_.characterEffect1081ui_story == nil then
				arg_906_1.var_.characterEffect1081ui_story = arg_906_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_909_0 = 0.200000002980232

			if 0 <= arg_906_1.time_ and arg_906_1.time_ < 0 + var_909_0 and not isNil(arg_906_1.actors_["1081ui_story"]) then
				if arg_906_1.var_.characterEffect1081ui_story and not isNil(arg_906_1.actors_["1081ui_story"]) then
					arg_906_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_906_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_906_1.time_ - 0) / var_909_0)
				end
			end

			if arg_906_1.time_ >= 0 + var_909_0 and arg_906_1.time_ < 0 + var_909_0 + arg_909_0 and not isNil(arg_906_1.actors_["1081ui_story"]) and arg_906_1.var_.characterEffect1081ui_story then
				arg_906_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_906_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_906_1.nodeConfigList_ = {}

		arg_906_1:InitPlayNodeList()
	end,
	Play1108106217 = function(arg_910_0, arg_910_1)
		arg_910_1.time_ = 0
		arg_910_1.frameCnt_ = 0
		arg_910_1.state_ = "playing"
		arg_910_1.curTalkId_ = 1108106217
		arg_910_1.duration_ = 5.5

		SetActive(arg_910_1.tipsGo_, false)

		function arg_910_1.onSingleLineFinish_()
			arg_910_1.onSingleLineUpdate_ = nil
			arg_910_1.onSingleLineFinish_ = nil
			arg_910_1.state_ = "waiting"
		end

		function arg_910_1.playNext_(arg_912_0)
			if arg_912_0 == 1 then
				arg_910_0:Play1108106219(arg_910_1)
			end
		end

		function arg_910_1.onSingleLineUpdate_(arg_913_0)
			if 0 < arg_910_1.time_ and arg_910_1.time_ <= 0 + arg_913_0 then
				arg_910_1.var_.moveOldPos1081ui_story = arg_910_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_913_0 = 0.001

			if 0 <= arg_910_1.time_ and arg_910_1.time_ < 0 + var_913_0 then
				arg_910_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_910_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_910_1.time_ - 0) / var_913_0)
				arg_910_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).z)
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles = arg_910_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_910_1.time_ >= 0 + var_913_0 and arg_910_1.time_ < 0 + var_913_0 + arg_913_0 then
				arg_910_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_910_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_910_1.actors_["1081ui_story"].transform.position).z)
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_910_1.actors_["1081ui_story"].transform.localEulerAngles = arg_910_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_913_1 = arg_910_1.actors_["1081ui_story"]

			if 0 < arg_910_1.time_ and arg_910_1.time_ <= 0 + arg_913_0 and not isNil(var_913_1) and arg_910_1.var_.characterEffect1081ui_story == nil then
				arg_910_1.var_.characterEffect1081ui_story = var_913_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_913_2 = 0.200000002980232

			if 0 <= arg_910_1.time_ and arg_910_1.time_ < 0 + var_913_2 and not isNil(var_913_1) then
				if arg_910_1.var_.characterEffect1081ui_story and not isNil(var_913_1) then
					arg_910_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_910_1.time_ >= 0 + var_913_2 and arg_910_1.time_ < 0 + var_913_2 + arg_913_0 and not isNil(var_913_1) and arg_910_1.var_.characterEffect1081ui_story then
				arg_910_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_910_1.time_ and arg_910_1.time_ <= 0 + arg_913_0 then
				arg_910_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			if 0 < arg_910_1.time_ and arg_910_1.time_ <= 0 + arg_913_0 then
				arg_910_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_913_4 = 0
			local var_913_5 = 0.5

			if 0 < arg_910_1.time_ and arg_910_1.time_ <= var_913_4 + arg_913_0 then
				arg_910_1.talkMaxDuration = 0
				arg_910_1.dialogCg_.alpha = 1

				arg_910_1.dialog_:SetActive(true)
				SetActive(arg_910_1.leftNameGo_, true)

				arg_910_1.leftNameTxt_.text = arg_910_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_910_1.leftNameTxt_.transform)

				arg_910_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_910_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_910_1:RecordName(arg_910_1.leftNameTxt_.text)
				SetActive(arg_910_1.iconTrs_.gameObject, false)
				arg_910_1.callingController_:SetSelectedState("normal")

				local var_913_6 = arg_910_1:GetWordFromCfg(1108106217)
				local var_913_7 = arg_910_1:FormatText(var_913_6.content)

				arg_910_1.text_.text = var_913_7

				LuaForUtil.ClearLinePrefixSymbol(arg_910_1.text_)

				local var_913_9 = 19 <= 0 and var_913_5 or var_913_5 * (utf8.len(var_913_7) / 19)

				if (19 <= 0 and var_913_5 or var_913_5 * (utf8.len(var_913_7) / 19)) > 0 and var_913_5 < var_913_9 then
					arg_910_1.talkMaxDuration = var_913_9

					if var_913_9 + var_913_4 > arg_910_1.duration_ then
						arg_910_1.duration_ = var_913_9 + var_913_4
					end
				end

				arg_910_1.text_.text = var_913_7
				arg_910_1.typewritter.percent = 0

				arg_910_1.typewritter:SetDirty()
				arg_910_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb") ~= 0 then
					local var_913_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb") / 1000

					if var_913_10 + var_913_4 > arg_910_1.duration_ then
						arg_910_1.duration_ = var_913_10 + var_913_4
					end

					if var_913_6.prefab_name ~= "" and arg_910_1.actors_[var_913_6.prefab_name] ~= nil then
						local var_913_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_910_1.actors_[var_913_6.prefab_name].transform, "story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")

						arg_910_1:RecordAudio("1108106217", var_913_11)
						arg_910_1:RecordAudio("1108106217", var_913_11)
					else
						arg_910_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")
					end

					arg_910_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")
				end

				arg_910_1:RecordContent(arg_910_1.text_.text)
			end

			local var_913_12 = math.max(var_913_5, arg_910_1.talkMaxDuration)

			if var_913_4 <= arg_910_1.time_ and arg_910_1.time_ < var_913_4 + var_913_12 then
				arg_910_1.typewritter.percent = (arg_910_1.time_ - var_913_4) / var_913_12

				arg_910_1.typewritter:SetDirty()
			end

			if arg_910_1.time_ >= var_913_4 + var_913_12 and arg_910_1.time_ < var_913_4 + var_913_12 + arg_913_0 then
				arg_910_1.typewritter.percent = 1

				arg_910_1.typewritter:SetDirty()
				arg_910_1:ShowNextGo(true)
			end
		end

		arg_910_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_910_1:InitPlayNodeList()
	end,
	Play1108106219 = function(arg_914_0, arg_914_1)
		arg_914_1.time_ = 0
		arg_914_1.frameCnt_ = 0
		arg_914_1.state_ = "playing"
		arg_914_1.curTalkId_ = 1108106219
		arg_914_1.duration_ = 2

		SetActive(arg_914_1.tipsGo_, false)

		function arg_914_1.onSingleLineFinish_()
			arg_914_1.onSingleLineUpdate_ = nil
			arg_914_1.onSingleLineFinish_ = nil
			arg_914_1.state_ = "waiting"
		end

		function arg_914_1.playNext_(arg_916_0)
			if arg_916_0 == 1 then
				arg_914_0:Play1108106220(arg_914_1)
			end
		end

		function arg_914_1.onSingleLineUpdate_(arg_917_0)
			if 0 < arg_914_1.time_ and arg_914_1.time_ <= 0 + arg_917_0 then
				arg_914_1.var_.moveOldPos1081ui_story = arg_914_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_917_0 = 0.001

			if 0 <= arg_914_1.time_ and arg_914_1.time_ < 0 + var_917_0 then
				arg_914_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_914_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_914_1.time_ - 0) / var_917_0)
				arg_914_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).z)
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles = arg_914_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_914_1.time_ >= 0 + var_917_0 and arg_914_1.time_ < 0 + var_917_0 + arg_917_0 then
				arg_914_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_914_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_914_1.actors_["1081ui_story"].transform.position).z)
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_914_1.actors_["1081ui_story"].transform.localEulerAngles = arg_914_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_917_1 = arg_914_1.actors_["1081ui_story"]

			if 0 < arg_914_1.time_ and arg_914_1.time_ <= 0 + arg_917_0 and not isNil(var_917_1) and arg_914_1.var_.characterEffect1081ui_story == nil then
				arg_914_1.var_.characterEffect1081ui_story = var_917_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_917_2 = 0.200000002980232

			if 0 <= arg_914_1.time_ and arg_914_1.time_ < 0 + var_917_2 and not isNil(var_917_1) then
				if arg_914_1.var_.characterEffect1081ui_story and not isNil(var_917_1) then
					arg_914_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_914_1.time_ >= 0 + var_917_2 and arg_914_1.time_ < 0 + var_917_2 + arg_917_0 and not isNil(var_917_1) and arg_914_1.var_.characterEffect1081ui_story then
				arg_914_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_914_1.time_ and arg_914_1.time_ <= 0 + arg_917_0 then
				arg_914_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_917_4 = 0
			local var_917_5 = 0.125

			if 0 < arg_914_1.time_ and arg_914_1.time_ <= var_917_4 + arg_917_0 then
				arg_914_1.talkMaxDuration = 0
				arg_914_1.dialogCg_.alpha = 1

				arg_914_1.dialog_:SetActive(true)
				SetActive(arg_914_1.leftNameGo_, true)

				arg_914_1.leftNameTxt_.text = arg_914_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_914_1.leftNameTxt_.transform)

				arg_914_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_914_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_914_1:RecordName(arg_914_1.leftNameTxt_.text)
				SetActive(arg_914_1.iconTrs_.gameObject, false)
				arg_914_1.callingController_:SetSelectedState("normal")

				local var_917_6 = arg_914_1:GetWordFromCfg(1108106219)
				local var_917_7 = arg_914_1:FormatText(var_917_6.content)

				arg_914_1.text_.text = var_917_7

				LuaForUtil.ClearLinePrefixSymbol(arg_914_1.text_)

				local var_917_9 = 5 <= 0 and var_917_5 or var_917_5 * (utf8.len(var_917_7) / 5)

				if (5 <= 0 and var_917_5 or var_917_5 * (utf8.len(var_917_7) / 5)) > 0 and var_917_5 < var_917_9 then
					arg_914_1.talkMaxDuration = var_917_9

					if var_917_9 + var_917_4 > arg_914_1.duration_ then
						arg_914_1.duration_ = var_917_9 + var_917_4
					end
				end

				arg_914_1.text_.text = var_917_7
				arg_914_1.typewritter.percent = 0

				arg_914_1.typewritter:SetDirty()
				arg_914_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb") ~= 0 then
					local var_917_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb") / 1000

					if var_917_10 + var_917_4 > arg_914_1.duration_ then
						arg_914_1.duration_ = var_917_10 + var_917_4
					end

					if var_917_6.prefab_name ~= "" and arg_914_1.actors_[var_917_6.prefab_name] ~= nil then
						local var_917_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_914_1.actors_[var_917_6.prefab_name].transform, "story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")

						arg_914_1:RecordAudio("1108106219", var_917_11)
						arg_914_1:RecordAudio("1108106219", var_917_11)
					else
						arg_914_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")
					end

					arg_914_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")
				end

				arg_914_1:RecordContent(arg_914_1.text_.text)
			end

			local var_917_12 = math.max(var_917_5, arg_914_1.talkMaxDuration)

			if var_917_4 <= arg_914_1.time_ and arg_914_1.time_ < var_917_4 + var_917_12 then
				arg_914_1.typewritter.percent = (arg_914_1.time_ - var_917_4) / var_917_12

				arg_914_1.typewritter:SetDirty()
			end

			if arg_914_1.time_ >= var_917_4 + var_917_12 and arg_914_1.time_ < var_917_4 + var_917_12 + arg_917_0 then
				arg_914_1.typewritter.percent = 1

				arg_914_1.typewritter:SetDirty()
				arg_914_1:ShowNextGo(true)
			end
		end

		arg_914_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_914_1:InitPlayNodeList()
	end,
	Play1108106220 = function(arg_918_0, arg_918_1)
		arg_918_1.time_ = 0
		arg_918_1.frameCnt_ = 0
		arg_918_1.state_ = "playing"
		arg_918_1.curTalkId_ = 1108106220
		arg_918_1.duration_ = 5

		SetActive(arg_918_1.tipsGo_, false)

		function arg_918_1.onSingleLineFinish_()
			arg_918_1.onSingleLineUpdate_ = nil
			arg_918_1.onSingleLineFinish_ = nil
			arg_918_1.state_ = "waiting"
		end

		function arg_918_1.playNext_(arg_920_0)
			if arg_920_0 == 1 then
				arg_918_0:Play1108106221(arg_918_1)
			end
		end

		function arg_918_1.onSingleLineUpdate_(arg_921_0)
			if 0 < arg_918_1.time_ and arg_918_1.time_ <= 0 + arg_921_0 and not isNil(arg_918_1.actors_["1081ui_story"]) and arg_918_1.var_.characterEffect1081ui_story == nil then
				arg_918_1.var_.characterEffect1081ui_story = arg_918_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_921_0 = 0.200000002980232

			if 0 <= arg_918_1.time_ and arg_918_1.time_ < 0 + var_921_0 and not isNil(arg_918_1.actors_["1081ui_story"]) then
				if arg_918_1.var_.characterEffect1081ui_story and not isNil(arg_918_1.actors_["1081ui_story"]) then
					arg_918_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_918_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_918_1.time_ - 0) / var_921_0)
				end
			end

			if arg_918_1.time_ >= 0 + var_921_0 and arg_918_1.time_ < 0 + var_921_0 + arg_921_0 and not isNil(arg_918_1.actors_["1081ui_story"]) and arg_918_1.var_.characterEffect1081ui_story then
				arg_918_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_918_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_921_1 = 0
			local var_921_2 = 0.7

			if 0 < arg_918_1.time_ and arg_918_1.time_ <= var_921_1 + arg_921_0 then
				arg_918_1.talkMaxDuration = 0
				arg_918_1.dialogCg_.alpha = 1

				arg_918_1.dialog_:SetActive(true)
				SetActive(arg_918_1.leftNameGo_, false)

				arg_918_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_918_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_918_1:RecordName(arg_918_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_918_1.iconTrs_.gameObject, false)
				arg_918_1.callingController_:SetSelectedState("normal")

				local var_921_3 = arg_918_1:FormatText(arg_918_1:GetWordFromCfg(1108106220).content)

				arg_918_1.text_.text = var_921_3

				LuaForUtil.ClearLinePrefixSymbol(arg_918_1.text_)

				local var_921_5 = 28 <= 0 and var_921_2 or var_921_2 * (utf8.len(var_921_3) / 28)

				if (28 <= 0 and var_921_2 or var_921_2 * (utf8.len(var_921_3) / 28)) > 0 and var_921_2 < var_921_5 then
					arg_918_1.talkMaxDuration = var_921_5

					if var_921_5 + var_921_1 > arg_918_1.duration_ then
						arg_918_1.duration_ = var_921_5 + var_921_1
					end
				end

				arg_918_1.text_.text = var_921_3
				arg_918_1.typewritter.percent = 0

				arg_918_1.typewritter:SetDirty()
				arg_918_1:ShowNextGo(false)
				arg_918_1:RecordContent(arg_918_1.text_.text)
			end

			local var_921_6 = math.max(var_921_2, arg_918_1.talkMaxDuration)

			if var_921_1 <= arg_918_1.time_ and arg_918_1.time_ < var_921_1 + var_921_6 then
				arg_918_1.typewritter.percent = (arg_918_1.time_ - var_921_1) / var_921_6

				arg_918_1.typewritter:SetDirty()
			end

			if arg_918_1.time_ >= var_921_1 + var_921_6 and arg_918_1.time_ < var_921_1 + var_921_6 + arg_921_0 then
				arg_918_1.typewritter.percent = 1

				arg_918_1.typewritter:SetDirty()
				arg_918_1:ShowNextGo(true)
			end
		end

		arg_918_1.nodeConfigList_ = {}

		arg_918_1:InitPlayNodeList()
	end,
	Play1108106221 = function(arg_922_0, arg_922_1)
		arg_922_1.time_ = 0
		arg_922_1.frameCnt_ = 0
		arg_922_1.state_ = "playing"
		arg_922_1.curTalkId_ = 1108106221
		arg_922_1.duration_ = 4.93

		SetActive(arg_922_1.tipsGo_, false)

		function arg_922_1.onSingleLineFinish_()
			arg_922_1.onSingleLineUpdate_ = nil
			arg_922_1.onSingleLineFinish_ = nil
			arg_922_1.state_ = "waiting"
		end

		function arg_922_1.playNext_(arg_924_0)
			if arg_924_0 == 1 then
				arg_922_0:Play1108106222(arg_922_1)
			end
		end

		function arg_922_1.onSingleLineUpdate_(arg_925_0)
			if 0 < arg_922_1.time_ and arg_922_1.time_ <= 0 + arg_925_0 then
				arg_922_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_925_0 = arg_922_1.actors_["1081ui_story"]

			if 0 < arg_922_1.time_ and arg_922_1.time_ <= 0 + arg_925_0 and not isNil(var_925_0) and arg_922_1.var_.characterEffect1081ui_story == nil then
				arg_922_1.var_.characterEffect1081ui_story = var_925_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_925_1 = 0.200000002980232

			if 0 <= arg_922_1.time_ and arg_922_1.time_ < 0 + var_925_1 and not isNil(var_925_0) then
				if arg_922_1.var_.characterEffect1081ui_story and not isNil(var_925_0) then
					arg_922_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_922_1.time_ >= 0 + var_925_1 and arg_922_1.time_ < 0 + var_925_1 + arg_925_0 and not isNil(var_925_0) and arg_922_1.var_.characterEffect1081ui_story then
				arg_922_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_925_3 = 0
			local var_925_4 = 0.675

			if 0 < arg_922_1.time_ and arg_922_1.time_ <= var_925_3 + arg_925_0 then
				arg_922_1.talkMaxDuration = 0
				arg_922_1.dialogCg_.alpha = 1

				arg_922_1.dialog_:SetActive(true)
				SetActive(arg_922_1.leftNameGo_, true)

				arg_922_1.leftNameTxt_.text = arg_922_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_922_1.leftNameTxt_.transform)

				arg_922_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_922_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_922_1:RecordName(arg_922_1.leftNameTxt_.text)
				SetActive(arg_922_1.iconTrs_.gameObject, false)
				arg_922_1.callingController_:SetSelectedState("normal")

				local var_925_5 = arg_922_1:GetWordFromCfg(1108106221)
				local var_925_6 = arg_922_1:FormatText(var_925_5.content)

				arg_922_1.text_.text = var_925_6

				LuaForUtil.ClearLinePrefixSymbol(arg_922_1.text_)

				local var_925_8 = 27 <= 0 and var_925_4 or var_925_4 * (utf8.len(var_925_6) / 27)

				if (27 <= 0 and var_925_4 or var_925_4 * (utf8.len(var_925_6) / 27)) > 0 and var_925_4 < var_925_8 then
					arg_922_1.talkMaxDuration = var_925_8

					if var_925_8 + var_925_3 > arg_922_1.duration_ then
						arg_922_1.duration_ = var_925_8 + var_925_3
					end
				end

				arg_922_1.text_.text = var_925_6
				arg_922_1.typewritter.percent = 0

				arg_922_1.typewritter:SetDirty()
				arg_922_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb") ~= 0 then
					local var_925_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb") / 1000

					if var_925_9 + var_925_3 > arg_922_1.duration_ then
						arg_922_1.duration_ = var_925_9 + var_925_3
					end

					if var_925_5.prefab_name ~= "" and arg_922_1.actors_[var_925_5.prefab_name] ~= nil then
						local var_925_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_922_1.actors_[var_925_5.prefab_name].transform, "story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")

						arg_922_1:RecordAudio("1108106221", var_925_10)
						arg_922_1:RecordAudio("1108106221", var_925_10)
					else
						arg_922_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")
					end

					arg_922_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")
				end

				arg_922_1:RecordContent(arg_922_1.text_.text)
			end

			local var_925_11 = math.max(var_925_4, arg_922_1.talkMaxDuration)

			if var_925_3 <= arg_922_1.time_ and arg_922_1.time_ < var_925_3 + var_925_11 then
				arg_922_1.typewritter.percent = (arg_922_1.time_ - var_925_3) / var_925_11

				arg_922_1.typewritter:SetDirty()
			end

			if arg_922_1.time_ >= var_925_3 + var_925_11 and arg_922_1.time_ < var_925_3 + var_925_11 + arg_925_0 then
				arg_922_1.typewritter.percent = 1

				arg_922_1.typewritter:SetDirty()
				arg_922_1:ShowNextGo(true)
			end
		end

		arg_922_1.nodeConfigList_ = {}

		arg_922_1:InitPlayNodeList()
	end,
	Play1108106222 = function(arg_926_0, arg_926_1)
		arg_926_1.time_ = 0
		arg_926_1.frameCnt_ = 0
		arg_926_1.state_ = "playing"
		arg_926_1.curTalkId_ = 1108106222
		arg_926_1.duration_ = 6.37

		SetActive(arg_926_1.tipsGo_, false)

		function arg_926_1.onSingleLineFinish_()
			arg_926_1.onSingleLineUpdate_ = nil
			arg_926_1.onSingleLineFinish_ = nil
			arg_926_1.state_ = "waiting"
		end

		function arg_926_1.playNext_(arg_928_0)
			if arg_928_0 == 1 then
				arg_926_0:Play1108106223(arg_926_1)
			end
		end

		function arg_926_1.onSingleLineUpdate_(arg_929_0)
			if 0 < arg_926_1.time_ and arg_926_1.time_ <= 0 + arg_929_0 then
				arg_926_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_926_1.time_ and arg_926_1.time_ <= 0 + arg_929_0 then
				arg_926_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_929_0 = 0
			local var_929_1 = 1.05

			if 0 < arg_926_1.time_ and arg_926_1.time_ <= var_929_0 + arg_929_0 then
				arg_926_1.talkMaxDuration = 0
				arg_926_1.dialogCg_.alpha = 1

				arg_926_1.dialog_:SetActive(true)
				SetActive(arg_926_1.leftNameGo_, true)

				arg_926_1.leftNameTxt_.text = arg_926_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_926_1.leftNameTxt_.transform)

				arg_926_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_926_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_926_1:RecordName(arg_926_1.leftNameTxt_.text)
				SetActive(arg_926_1.iconTrs_.gameObject, false)
				arg_926_1.callingController_:SetSelectedState("normal")

				local var_929_2 = arg_926_1:GetWordFromCfg(1108106222)
				local var_929_3 = arg_926_1:FormatText(var_929_2.content)

				arg_926_1.text_.text = var_929_3

				LuaForUtil.ClearLinePrefixSymbol(arg_926_1.text_)

				local var_929_5 = 42 <= 0 and var_929_1 or var_929_1 * (utf8.len(var_929_3) / 42)

				if (42 <= 0 and var_929_1 or var_929_1 * (utf8.len(var_929_3) / 42)) > 0 and var_929_1 < var_929_5 then
					arg_926_1.talkMaxDuration = var_929_5

					if var_929_5 + var_929_0 > arg_926_1.duration_ then
						arg_926_1.duration_ = var_929_5 + var_929_0
					end
				end

				arg_926_1.text_.text = var_929_3
				arg_926_1.typewritter.percent = 0

				arg_926_1.typewritter:SetDirty()
				arg_926_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb") ~= 0 then
					local var_929_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb") / 1000

					if var_929_6 + var_929_0 > arg_926_1.duration_ then
						arg_926_1.duration_ = var_929_6 + var_929_0
					end

					if var_929_2.prefab_name ~= "" and arg_926_1.actors_[var_929_2.prefab_name] ~= nil then
						local var_929_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_926_1.actors_[var_929_2.prefab_name].transform, "story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")

						arg_926_1:RecordAudio("1108106222", var_929_7)
						arg_926_1:RecordAudio("1108106222", var_929_7)
					else
						arg_926_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")
					end

					arg_926_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")
				end

				arg_926_1:RecordContent(arg_926_1.text_.text)
			end

			local var_929_8 = math.max(var_929_1, arg_926_1.talkMaxDuration)

			if var_929_0 <= arg_926_1.time_ and arg_926_1.time_ < var_929_0 + var_929_8 then
				arg_926_1.typewritter.percent = (arg_926_1.time_ - var_929_0) / var_929_8

				arg_926_1.typewritter:SetDirty()
			end

			if arg_926_1.time_ >= var_929_0 + var_929_8 and arg_926_1.time_ < var_929_0 + var_929_8 + arg_929_0 then
				arg_926_1.typewritter.percent = 1

				arg_926_1.typewritter:SetDirty()
				arg_926_1:ShowNextGo(true)
			end
		end

		arg_926_1.nodeConfigList_ = {}

		arg_926_1:InitPlayNodeList()
	end,
	Play1108106223 = function(arg_930_0, arg_930_1)
		arg_930_1.time_ = 0
		arg_930_1.frameCnt_ = 0
		arg_930_1.state_ = "playing"
		arg_930_1.curTalkId_ = 1108106223
		arg_930_1.duration_ = 2

		SetActive(arg_930_1.tipsGo_, true)

		arg_930_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_930_1.onSingleLineFinish_()
			arg_930_1.onSingleLineUpdate_ = nil
			arg_930_1.onSingleLineFinish_ = nil
			arg_930_1.state_ = "waiting"

			SetActive(arg_930_1.choicesGo_, true)

			for iter_931_0, iter_931_1 in ipairs(arg_930_1.choices_) do
				SetActive(iter_931_1.go, iter_931_0 <= 2)
			end

			arg_930_1.choices_[1].txt.text = arg_930_1:FormatText(StoryChoiceCfg[1004].name)
			arg_930_1.choices_[2].txt.text = arg_930_1:FormatText(StoryChoiceCfg[1005].name)
		end

		function arg_930_1.playNext_(arg_932_0)
			if arg_932_0 == 1 then
				arg_930_0:Play1108106224(arg_930_1)
			end

			if arg_932_0 == 2 then
				PlayerAction.UseStoryTrigger(1081014, 210810106, 1108106223, 2)
				arg_930_0:Play1108106224(arg_930_1)
			end

			arg_930_1:RecordChoiceLog(1108106223, 1004, 1005)
		end

		function arg_930_1.onSingleLineUpdate_(arg_933_0)
			if 0 < arg_930_1.time_ and arg_930_1.time_ <= 0 + arg_933_0 then
				arg_930_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_930_1.time_ and arg_930_1.time_ <= 0 + arg_933_0 then
				arg_930_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_933_0 = arg_930_1.actors_["1081ui_story"]

			if 0 < arg_930_1.time_ and arg_930_1.time_ <= 0 + arg_933_0 and not isNil(var_933_0) and arg_930_1.var_.characterEffect1081ui_story == nil then
				arg_930_1.var_.characterEffect1081ui_story = var_933_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_933_1 = 0.200000002980232

			if 0 <= arg_930_1.time_ and arg_930_1.time_ < 0 + var_933_1 and not isNil(var_933_0) then
				if arg_930_1.var_.characterEffect1081ui_story and not isNil(var_933_0) then
					arg_930_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_930_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_930_1.time_ - 0) / var_933_1)
				end
			end

			if arg_930_1.time_ >= 0 + var_933_1 and arg_930_1.time_ < 0 + var_933_1 + arg_933_0 and not isNil(var_933_0) and arg_930_1.var_.characterEffect1081ui_story then
				arg_930_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_930_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end
		end

		arg_930_1.nodeConfigList_ = {}

		arg_930_1:InitPlayNodeList()
	end,
	Play1108106224 = function(arg_934_0, arg_934_1)
		arg_934_1.time_ = 0
		arg_934_1.frameCnt_ = 0
		arg_934_1.state_ = "playing"
		arg_934_1.curTalkId_ = 1108106224
		arg_934_1.duration_ = 2

		SetActive(arg_934_1.tipsGo_, false)

		function arg_934_1.onSingleLineFinish_()
			arg_934_1.onSingleLineUpdate_ = nil
			arg_934_1.onSingleLineFinish_ = nil
			arg_934_1.state_ = "waiting"
		end

		function arg_934_1.playNext_(arg_936_0)
			if arg_936_0 == 1 then
				arg_934_0:Play1108106225(arg_934_1)
			end
		end

		function arg_934_1.onSingleLineUpdate_(arg_937_0)
			if arg_934_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_937_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_934_1.stage_.transform)

				var_937_0.name = "1081ui_story"
				var_937_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_934_1.actors_["1081ui_story"] = var_937_0

				local var_937_1 = var_937_0:GetComponentInChildren(typeof(CharacterEffect))

				var_937_1.enabled = true

				local var_937_2 = GameObjectTools.GetOrAddComponent(var_937_0, typeof(DynamicBoneHelper))

				if var_937_2 then
					var_937_2:EnableDynamicBone(false)
				end

				arg_934_1:ShowWeapon(var_937_1.transform, false)

				arg_934_1.var_["1081ui_story" .. "Animator"] = var_937_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_934_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_934_1.var_["1081ui_story" .. "LipSync"] = var_937_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_934_1.time_ and arg_934_1.time_ <= 0 + arg_937_0 then
				arg_934_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_937_3 = arg_934_1.actors_["1081ui_story"]

			if 0 < arg_934_1.time_ and arg_934_1.time_ <= 0 + arg_937_0 and not isNil(var_937_3) and arg_934_1.var_.characterEffect1081ui_story == nil then
				arg_934_1.var_.characterEffect1081ui_story = var_937_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_937_4 = 0.200000002980232

			if 0 <= arg_934_1.time_ and arg_934_1.time_ < 0 + var_937_4 and not isNil(var_937_3) then
				if arg_934_1.var_.characterEffect1081ui_story and not isNil(var_937_3) then
					arg_934_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_934_1.time_ >= 0 + var_937_4 and arg_934_1.time_ < 0 + var_937_4 + arg_937_0 and not isNil(var_937_3) and arg_934_1.var_.characterEffect1081ui_story then
				arg_934_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_937_6 = 0
			local var_937_7 = 0.075

			if 0 < arg_934_1.time_ and arg_934_1.time_ <= var_937_6 + arg_937_0 then
				arg_934_1.talkMaxDuration = 0
				arg_934_1.dialogCg_.alpha = 1

				arg_934_1.dialog_:SetActive(true)
				SetActive(arg_934_1.leftNameGo_, true)

				arg_934_1.leftNameTxt_.text = arg_934_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_934_1.leftNameTxt_.transform)

				arg_934_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_934_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_934_1:RecordName(arg_934_1.leftNameTxt_.text)
				SetActive(arg_934_1.iconTrs_.gameObject, false)
				arg_934_1.callingController_:SetSelectedState("normal")

				local var_937_8 = arg_934_1:GetWordFromCfg(1108106224)
				local var_937_9 = arg_934_1:FormatText(var_937_8.content)

				arg_934_1.text_.text = var_937_9

				LuaForUtil.ClearLinePrefixSymbol(arg_934_1.text_)

				local var_937_11 = 3 <= 0 and var_937_7 or var_937_7 * (utf8.len(var_937_9) / 3)

				if (3 <= 0 and var_937_7 or var_937_7 * (utf8.len(var_937_9) / 3)) > 0 and var_937_7 < var_937_11 then
					arg_934_1.talkMaxDuration = var_937_11

					if var_937_11 + var_937_6 > arg_934_1.duration_ then
						arg_934_1.duration_ = var_937_11 + var_937_6
					end
				end

				arg_934_1.text_.text = var_937_9
				arg_934_1.typewritter.percent = 0

				arg_934_1.typewritter:SetDirty()
				arg_934_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb") ~= 0 then
					local var_937_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb") / 1000

					if var_937_12 + var_937_6 > arg_934_1.duration_ then
						arg_934_1.duration_ = var_937_12 + var_937_6
					end

					if var_937_8.prefab_name ~= "" and arg_934_1.actors_[var_937_8.prefab_name] ~= nil then
						local var_937_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_934_1.actors_[var_937_8.prefab_name].transform, "story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")

						arg_934_1:RecordAudio("1108106224", var_937_13)
						arg_934_1:RecordAudio("1108106224", var_937_13)
					else
						arg_934_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")
					end

					arg_934_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")
				end

				arg_934_1:RecordContent(arg_934_1.text_.text)
			end

			local var_937_14 = math.max(var_937_7, arg_934_1.talkMaxDuration)

			if var_937_6 <= arg_934_1.time_ and arg_934_1.time_ < var_937_6 + var_937_14 then
				arg_934_1.typewritter.percent = (arg_934_1.time_ - var_937_6) / var_937_14

				arg_934_1.typewritter:SetDirty()
			end

			if arg_934_1.time_ >= var_937_6 + var_937_14 and arg_934_1.time_ < var_937_6 + var_937_14 + arg_937_0 then
				arg_934_1.typewritter.percent = 1

				arg_934_1.typewritter:SetDirty()
				arg_934_1:ShowNextGo(true)
			end
		end

		arg_934_1.nodeConfigList_ = {}

		arg_934_1:InitPlayNodeList()
	end,
	Play1108106225 = function(arg_938_0, arg_938_1)
		arg_938_1.time_ = 0
		arg_938_1.frameCnt_ = 0
		arg_938_1.state_ = "playing"
		arg_938_1.curTalkId_ = 1108106225
		arg_938_1.duration_ = 5

		SetActive(arg_938_1.tipsGo_, false)

		function arg_938_1.onSingleLineFinish_()
			arg_938_1.onSingleLineUpdate_ = nil
			arg_938_1.onSingleLineFinish_ = nil
			arg_938_1.state_ = "waiting"
		end

		function arg_938_1.playNext_(arg_940_0)
			if arg_940_0 == 1 then
				arg_938_0:Play1108106226(arg_938_1)
			end
		end

		function arg_938_1.onSingleLineUpdate_(arg_941_0)
			if 0 < arg_938_1.time_ and arg_938_1.time_ <= 0 + arg_941_0 then
				arg_938_1.var_.moveOldPos1081ui_story = arg_938_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_941_0 = 0.001

			if 0 <= arg_938_1.time_ and arg_938_1.time_ < 0 + var_941_0 then
				arg_938_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_938_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_938_1.time_ - 0) / var_941_0)
				arg_938_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).z)
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles = arg_938_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_938_1.time_ >= 0 + var_941_0 and arg_938_1.time_ < 0 + var_941_0 + arg_941_0 then
				arg_938_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_938_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_938_1.actors_["1081ui_story"].transform.position).z)
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_938_1.actors_["1081ui_story"].transform.localEulerAngles = arg_938_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_941_1 = 0
			local var_941_2 = 0.825

			if 0 < arg_938_1.time_ and arg_938_1.time_ <= var_941_1 + arg_941_0 then
				arg_938_1.talkMaxDuration = 0
				arg_938_1.dialogCg_.alpha = 1

				arg_938_1.dialog_:SetActive(true)
				SetActive(arg_938_1.leftNameGo_, false)

				arg_938_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_938_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_938_1:RecordName(arg_938_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_938_1.iconTrs_.gameObject, false)
				arg_938_1.callingController_:SetSelectedState("normal")

				local var_941_3 = arg_938_1:FormatText(arg_938_1:GetWordFromCfg(1108106225).content)

				arg_938_1.text_.text = var_941_3

				LuaForUtil.ClearLinePrefixSymbol(arg_938_1.text_)

				local var_941_5 = 33 <= 0 and var_941_2 or var_941_2 * (utf8.len(var_941_3) / 33)

				if (33 <= 0 and var_941_2 or var_941_2 * (utf8.len(var_941_3) / 33)) > 0 and var_941_2 < var_941_5 then
					arg_938_1.talkMaxDuration = var_941_5

					if var_941_5 + var_941_1 > arg_938_1.duration_ then
						arg_938_1.duration_ = var_941_5 + var_941_1
					end
				end

				arg_938_1.text_.text = var_941_3
				arg_938_1.typewritter.percent = 0

				arg_938_1.typewritter:SetDirty()
				arg_938_1:ShowNextGo(false)
				arg_938_1:RecordContent(arg_938_1.text_.text)
			end

			local var_941_6 = math.max(var_941_2, arg_938_1.talkMaxDuration)

			if var_941_1 <= arg_938_1.time_ and arg_938_1.time_ < var_941_1 + var_941_6 then
				arg_938_1.typewritter.percent = (arg_938_1.time_ - var_941_1) / var_941_6

				arg_938_1.typewritter:SetDirty()
			end

			if arg_938_1.time_ >= var_941_1 + var_941_6 and arg_938_1.time_ < var_941_1 + var_941_6 + arg_941_0 then
				arg_938_1.typewritter.percent = 1

				arg_938_1.typewritter:SetDirty()
				arg_938_1:ShowNextGo(true)
			end
		end

		arg_938_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_938_1:InitPlayNodeList()
	end,
	Play1108106226 = function(arg_942_0, arg_942_1)
		arg_942_1.time_ = 0
		arg_942_1.frameCnt_ = 0
		arg_942_1.state_ = "playing"
		arg_942_1.curTalkId_ = 1108106226
		arg_942_1.duration_ = 5

		SetActive(arg_942_1.tipsGo_, false)

		function arg_942_1.onSingleLineFinish_()
			arg_942_1.onSingleLineUpdate_ = nil
			arg_942_1.onSingleLineFinish_ = nil
			arg_942_1.state_ = "waiting"
		end

		function arg_942_1.playNext_(arg_944_0)
			if arg_944_0 == 1 then
				arg_942_0:Play1108106227(arg_942_1)
			end
		end

		function arg_942_1.onSingleLineUpdate_(arg_945_0)
			local var_945_0 = 0.8

			if 0 < arg_942_1.time_ and arg_942_1.time_ <= 0 + arg_945_0 then
				arg_942_1.talkMaxDuration = 0
				arg_942_1.dialogCg_.alpha = 1

				arg_942_1.dialog_:SetActive(true)
				SetActive(arg_942_1.leftNameGo_, false)

				arg_942_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_942_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_942_1:RecordName(arg_942_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_942_1.iconTrs_.gameObject, false)
				arg_942_1.callingController_:SetSelectedState("normal")

				local var_945_1 = arg_942_1:FormatText(arg_942_1:GetWordFromCfg(1108106226).content)

				arg_942_1.text_.text = var_945_1

				LuaForUtil.ClearLinePrefixSymbol(arg_942_1.text_)

				local var_945_3 = 32 <= 0 and var_945_0 or var_945_0 * (utf8.len(var_945_1) / 32)

				if (32 <= 0 and var_945_0 or var_945_0 * (utf8.len(var_945_1) / 32)) > 0 and var_945_0 < var_945_3 then
					arg_942_1.talkMaxDuration = var_945_3

					if var_945_3 + 0 > arg_942_1.duration_ then
						arg_942_1.duration_ = var_945_3 + 0
					end
				end

				arg_942_1.text_.text = var_945_1
				arg_942_1.typewritter.percent = 0

				arg_942_1.typewritter:SetDirty()
				arg_942_1:ShowNextGo(false)
				arg_942_1:RecordContent(arg_942_1.text_.text)
			end

			local var_945_4 = math.max(var_945_0, arg_942_1.talkMaxDuration)

			if 0 <= arg_942_1.time_ and arg_942_1.time_ < 0 + var_945_4 then
				arg_942_1.typewritter.percent = (arg_942_1.time_ - 0) / var_945_4

				arg_942_1.typewritter:SetDirty()
			end

			if arg_942_1.time_ >= 0 + var_945_4 and arg_942_1.time_ < 0 + var_945_4 + arg_945_0 then
				arg_942_1.typewritter.percent = 1

				arg_942_1.typewritter:SetDirty()
				arg_942_1:ShowNextGo(true)
			end
		end

		arg_942_1.nodeConfigList_ = {}

		arg_942_1:InitPlayNodeList()
	end,
	Play1108106227 = function(arg_946_0, arg_946_1)
		arg_946_1.time_ = 0
		arg_946_1.frameCnt_ = 0
		arg_946_1.state_ = "playing"
		arg_946_1.curTalkId_ = 1108106227
		arg_946_1.duration_ = 5

		SetActive(arg_946_1.tipsGo_, false)

		function arg_946_1.onSingleLineFinish_()
			arg_946_1.onSingleLineUpdate_ = nil
			arg_946_1.onSingleLineFinish_ = nil
			arg_946_1.state_ = "waiting"
		end

		function arg_946_1.playNext_(arg_948_0)
			if arg_948_0 == 1 then
				arg_946_0:Play1108106228(arg_946_1)
			end
		end

		function arg_946_1.onSingleLineUpdate_(arg_949_0)
			local var_949_0 = 1.35

			if 0 < arg_946_1.time_ and arg_946_1.time_ <= 0 + arg_949_0 then
				arg_946_1.talkMaxDuration = 0
				arg_946_1.dialogCg_.alpha = 1

				arg_946_1.dialog_:SetActive(true)
				SetActive(arg_946_1.leftNameGo_, false)

				arg_946_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_946_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_946_1:RecordName(arg_946_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_946_1.iconTrs_.gameObject, false)
				arg_946_1.callingController_:SetSelectedState("normal")

				local var_949_1 = arg_946_1:FormatText(arg_946_1:GetWordFromCfg(1108106227).content)

				arg_946_1.text_.text = var_949_1

				LuaForUtil.ClearLinePrefixSymbol(arg_946_1.text_)

				local var_949_3 = 54 <= 0 and var_949_0 or var_949_0 * (utf8.len(var_949_1) / 54)

				if (54 <= 0 and var_949_0 or var_949_0 * (utf8.len(var_949_1) / 54)) > 0 and var_949_0 < var_949_3 then
					arg_946_1.talkMaxDuration = var_949_3

					if var_949_3 + 0 > arg_946_1.duration_ then
						arg_946_1.duration_ = var_949_3 + 0
					end
				end

				arg_946_1.text_.text = var_949_1
				arg_946_1.typewritter.percent = 0

				arg_946_1.typewritter:SetDirty()
				arg_946_1:ShowNextGo(false)
				arg_946_1:RecordContent(arg_946_1.text_.text)
			end

			local var_949_4 = math.max(var_949_0, arg_946_1.talkMaxDuration)

			if 0 <= arg_946_1.time_ and arg_946_1.time_ < 0 + var_949_4 then
				arg_946_1.typewritter.percent = (arg_946_1.time_ - 0) / var_949_4

				arg_946_1.typewritter:SetDirty()
			end

			if arg_946_1.time_ >= 0 + var_949_4 and arg_946_1.time_ < 0 + var_949_4 + arg_949_0 then
				arg_946_1.typewritter.percent = 1

				arg_946_1.typewritter:SetDirty()
				arg_946_1:ShowNextGo(true)
			end
		end

		arg_946_1.nodeConfigList_ = {}

		arg_946_1:InitPlayNodeList()
	end,
	Play1108106228 = function(arg_950_0, arg_950_1)
		arg_950_1.time_ = 0
		arg_950_1.frameCnt_ = 0
		arg_950_1.state_ = "playing"
		arg_950_1.curTalkId_ = 1108106228
		arg_950_1.duration_ = 4.27

		SetActive(arg_950_1.tipsGo_, false)

		function arg_950_1.onSingleLineFinish_()
			arg_950_1.onSingleLineUpdate_ = nil
			arg_950_1.onSingleLineFinish_ = nil
			arg_950_1.state_ = "waiting"
		end

		function arg_950_1.playNext_(arg_952_0)
			if arg_952_0 == 1 then
				arg_950_0:Play1108106229(arg_950_1)
			end
		end

		function arg_950_1.onSingleLineUpdate_(arg_953_0)
			if 0 < arg_950_1.time_ and arg_950_1.time_ <= 0 + arg_953_0 then
				arg_950_1.var_.moveOldPos1081ui_story = arg_950_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_953_0 = 0.001

			if 0 <= arg_950_1.time_ and arg_950_1.time_ < 0 + var_953_0 then
				arg_950_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_950_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_950_1.time_ - 0) / var_953_0)
				arg_950_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).z)
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles = arg_950_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_950_1.time_ >= 0 + var_953_0 and arg_950_1.time_ < 0 + var_953_0 + arg_953_0 then
				arg_950_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_950_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_950_1.actors_["1081ui_story"].transform.position).z)
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_950_1.actors_["1081ui_story"].transform.localEulerAngles = arg_950_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_953_1 = arg_950_1.actors_["1081ui_story"]

			if 0 < arg_950_1.time_ and arg_950_1.time_ <= 0 + arg_953_0 and not isNil(var_953_1) and arg_950_1.var_.characterEffect1081ui_story == nil then
				arg_950_1.var_.characterEffect1081ui_story = var_953_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_953_2 = 0.200000002980232

			if 0 <= arg_950_1.time_ and arg_950_1.time_ < 0 + var_953_2 and not isNil(var_953_1) then
				if arg_950_1.var_.characterEffect1081ui_story and not isNil(var_953_1) then
					arg_950_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_950_1.time_ >= 0 + var_953_2 and arg_950_1.time_ < 0 + var_953_2 + arg_953_0 and not isNil(var_953_1) and arg_950_1.var_.characterEffect1081ui_story then
				arg_950_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_950_1.time_ and arg_950_1.time_ <= 0 + arg_953_0 then
				arg_950_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_950_1.time_ and arg_950_1.time_ <= 0 + arg_953_0 then
				arg_950_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_953_4 = 0
			local var_953_5 = 0.7

			if 0 < arg_950_1.time_ and arg_950_1.time_ <= var_953_4 + arg_953_0 then
				arg_950_1.talkMaxDuration = 0
				arg_950_1.dialogCg_.alpha = 1

				arg_950_1.dialog_:SetActive(true)
				SetActive(arg_950_1.leftNameGo_, true)

				arg_950_1.leftNameTxt_.text = arg_950_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_950_1.leftNameTxt_.transform)

				arg_950_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_950_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_950_1:RecordName(arg_950_1.leftNameTxt_.text)
				SetActive(arg_950_1.iconTrs_.gameObject, false)
				arg_950_1.callingController_:SetSelectedState("normal")

				local var_953_6 = arg_950_1:GetWordFromCfg(1108106228)
				local var_953_7 = arg_950_1:FormatText(var_953_6.content)

				arg_950_1.text_.text = var_953_7

				LuaForUtil.ClearLinePrefixSymbol(arg_950_1.text_)

				local var_953_9 = 28 <= 0 and var_953_5 or var_953_5 * (utf8.len(var_953_7) / 28)

				if (28 <= 0 and var_953_5 or var_953_5 * (utf8.len(var_953_7) / 28)) > 0 and var_953_5 < var_953_9 then
					arg_950_1.talkMaxDuration = var_953_9

					if var_953_9 + var_953_4 > arg_950_1.duration_ then
						arg_950_1.duration_ = var_953_9 + var_953_4
					end
				end

				arg_950_1.text_.text = var_953_7
				arg_950_1.typewritter.percent = 0

				arg_950_1.typewritter:SetDirty()
				arg_950_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb") ~= 0 then
					local var_953_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb") / 1000

					if var_953_10 + var_953_4 > arg_950_1.duration_ then
						arg_950_1.duration_ = var_953_10 + var_953_4
					end

					if var_953_6.prefab_name ~= "" and arg_950_1.actors_[var_953_6.prefab_name] ~= nil then
						local var_953_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_950_1.actors_[var_953_6.prefab_name].transform, "story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")

						arg_950_1:RecordAudio("1108106228", var_953_11)
						arg_950_1:RecordAudio("1108106228", var_953_11)
					else
						arg_950_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")
					end

					arg_950_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")
				end

				arg_950_1:RecordContent(arg_950_1.text_.text)
			end

			local var_953_12 = math.max(var_953_5, arg_950_1.talkMaxDuration)

			if var_953_4 <= arg_950_1.time_ and arg_950_1.time_ < var_953_4 + var_953_12 then
				arg_950_1.typewritter.percent = (arg_950_1.time_ - var_953_4) / var_953_12

				arg_950_1.typewritter:SetDirty()
			end

			if arg_950_1.time_ >= var_953_4 + var_953_12 and arg_950_1.time_ < var_953_4 + var_953_12 + arg_953_0 then
				arg_950_1.typewritter.percent = 1

				arg_950_1.typewritter:SetDirty()
				arg_950_1:ShowNextGo(true)
			end
		end

		arg_950_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_950_1:InitPlayNodeList()
	end,
	Play1108106229 = function(arg_954_0, arg_954_1)
		arg_954_1.time_ = 0
		arg_954_1.frameCnt_ = 0
		arg_954_1.state_ = "playing"
		arg_954_1.curTalkId_ = 1108106229
		arg_954_1.duration_ = 4.03

		SetActive(arg_954_1.tipsGo_, false)

		function arg_954_1.onSingleLineFinish_()
			arg_954_1.onSingleLineUpdate_ = nil
			arg_954_1.onSingleLineFinish_ = nil
			arg_954_1.state_ = "waiting"
		end

		function arg_954_1.playNext_(arg_956_0)
			if arg_956_0 == 1 then
				arg_954_0:Play1108106230(arg_954_1)
			end
		end

		function arg_954_1.onSingleLineUpdate_(arg_957_0)
			if 0 < arg_954_1.time_ and arg_954_1.time_ <= 0 + arg_957_0 then
				arg_954_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_954_1.time_ and arg_954_1.time_ <= 0 + arg_957_0 then
				arg_954_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_957_0 = 0
			local var_957_1 = 0.525

			if 0 < arg_954_1.time_ and arg_954_1.time_ <= var_957_0 + arg_957_0 then
				arg_954_1.talkMaxDuration = 0
				arg_954_1.dialogCg_.alpha = 1

				arg_954_1.dialog_:SetActive(true)
				SetActive(arg_954_1.leftNameGo_, true)

				arg_954_1.leftNameTxt_.text = arg_954_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_954_1.leftNameTxt_.transform)

				arg_954_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_954_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_954_1:RecordName(arg_954_1.leftNameTxt_.text)
				SetActive(arg_954_1.iconTrs_.gameObject, false)
				arg_954_1.callingController_:SetSelectedState("normal")

				local var_957_2 = arg_954_1:GetWordFromCfg(1108106229)
				local var_957_3 = arg_954_1:FormatText(var_957_2.content)

				arg_954_1.text_.text = var_957_3

				LuaForUtil.ClearLinePrefixSymbol(arg_954_1.text_)

				local var_957_5 = 21 <= 0 and var_957_1 or var_957_1 * (utf8.len(var_957_3) / 21)

				if (21 <= 0 and var_957_1 or var_957_1 * (utf8.len(var_957_3) / 21)) > 0 and var_957_1 < var_957_5 then
					arg_954_1.talkMaxDuration = var_957_5

					if var_957_5 + var_957_0 > arg_954_1.duration_ then
						arg_954_1.duration_ = var_957_5 + var_957_0
					end
				end

				arg_954_1.text_.text = var_957_3
				arg_954_1.typewritter.percent = 0

				arg_954_1.typewritter:SetDirty()
				arg_954_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb") ~= 0 then
					local var_957_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb") / 1000

					if var_957_6 + var_957_0 > arg_954_1.duration_ then
						arg_954_1.duration_ = var_957_6 + var_957_0
					end

					if var_957_2.prefab_name ~= "" and arg_954_1.actors_[var_957_2.prefab_name] ~= nil then
						local var_957_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_954_1.actors_[var_957_2.prefab_name].transform, "story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")

						arg_954_1:RecordAudio("1108106229", var_957_7)
						arg_954_1:RecordAudio("1108106229", var_957_7)
					else
						arg_954_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")
					end

					arg_954_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")
				end

				arg_954_1:RecordContent(arg_954_1.text_.text)
			end

			local var_957_8 = math.max(var_957_1, arg_954_1.talkMaxDuration)

			if var_957_0 <= arg_954_1.time_ and arg_954_1.time_ < var_957_0 + var_957_8 then
				arg_954_1.typewritter.percent = (arg_954_1.time_ - var_957_0) / var_957_8

				arg_954_1.typewritter:SetDirty()
			end

			if arg_954_1.time_ >= var_957_0 + var_957_8 and arg_954_1.time_ < var_957_0 + var_957_8 + arg_957_0 then
				arg_954_1.typewritter.percent = 1

				arg_954_1.typewritter:SetDirty()
				arg_954_1:ShowNextGo(true)
			end
		end

		arg_954_1.nodeConfigList_ = {}

		arg_954_1:InitPlayNodeList()
	end,
	Play1108106230 = function(arg_958_0, arg_958_1)
		arg_958_1.time_ = 0
		arg_958_1.frameCnt_ = 0
		arg_958_1.state_ = "playing"
		arg_958_1.curTalkId_ = 1108106230
		arg_958_1.duration_ = 4.03

		SetActive(arg_958_1.tipsGo_, false)

		function arg_958_1.onSingleLineFinish_()
			arg_958_1.onSingleLineUpdate_ = nil
			arg_958_1.onSingleLineFinish_ = nil
			arg_958_1.state_ = "waiting"
		end

		function arg_958_1.playNext_(arg_960_0)
			if arg_960_0 == 1 then
				arg_958_0:Play1108106231(arg_958_1)
			end
		end

		function arg_958_1.onSingleLineUpdate_(arg_961_0)
			local var_961_0 = 0.475

			if 0 < arg_958_1.time_ and arg_958_1.time_ <= 0 + arg_961_0 then
				arg_958_1.talkMaxDuration = 0
				arg_958_1.dialogCg_.alpha = 1

				arg_958_1.dialog_:SetActive(true)
				SetActive(arg_958_1.leftNameGo_, true)

				arg_958_1.leftNameTxt_.text = arg_958_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_958_1.leftNameTxt_.transform)

				arg_958_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_958_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_958_1:RecordName(arg_958_1.leftNameTxt_.text)
				SetActive(arg_958_1.iconTrs_.gameObject, false)
				arg_958_1.callingController_:SetSelectedState("normal")

				local var_961_1 = arg_958_1:GetWordFromCfg(1108106230)
				local var_961_2 = arg_958_1:FormatText(var_961_1.content)

				arg_958_1.text_.text = var_961_2

				LuaForUtil.ClearLinePrefixSymbol(arg_958_1.text_)

				local var_961_4 = 19 <= 0 and var_961_0 or var_961_0 * (utf8.len(var_961_2) / 19)

				if (19 <= 0 and var_961_0 or var_961_0 * (utf8.len(var_961_2) / 19)) > 0 and var_961_0 < var_961_4 then
					arg_958_1.talkMaxDuration = var_961_4

					if var_961_4 + 0 > arg_958_1.duration_ then
						arg_958_1.duration_ = var_961_4 + 0
					end
				end

				arg_958_1.text_.text = var_961_2
				arg_958_1.typewritter.percent = 0

				arg_958_1.typewritter:SetDirty()
				arg_958_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb") ~= 0 then
					local var_961_5 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb") / 1000

					if var_961_5 + 0 > arg_958_1.duration_ then
						arg_958_1.duration_ = var_961_5 + 0
					end

					if var_961_1.prefab_name ~= "" and arg_958_1.actors_[var_961_1.prefab_name] ~= nil then
						local var_961_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_958_1.actors_[var_961_1.prefab_name].transform, "story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")

						arg_958_1:RecordAudio("1108106230", var_961_6)
						arg_958_1:RecordAudio("1108106230", var_961_6)
					else
						arg_958_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")
					end

					arg_958_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")
				end

				arg_958_1:RecordContent(arg_958_1.text_.text)
			end

			local var_961_7 = math.max(var_961_0, arg_958_1.talkMaxDuration)

			if 0 <= arg_958_1.time_ and arg_958_1.time_ < 0 + var_961_7 then
				arg_958_1.typewritter.percent = (arg_958_1.time_ - 0) / var_961_7

				arg_958_1.typewritter:SetDirty()
			end

			if arg_958_1.time_ >= 0 + var_961_7 and arg_958_1.time_ < 0 + var_961_7 + arg_961_0 then
				arg_958_1.typewritter.percent = 1

				arg_958_1.typewritter:SetDirty()
				arg_958_1:ShowNextGo(true)
			end
		end

		arg_958_1.nodeConfigList_ = {}

		arg_958_1:InitPlayNodeList()
	end,
	Play1108106231 = function(arg_962_0, arg_962_1)
		arg_962_1.time_ = 0
		arg_962_1.frameCnt_ = 0
		arg_962_1.state_ = "playing"
		arg_962_1.curTalkId_ = 1108106231
		arg_962_1.duration_ = 3.6

		SetActive(arg_962_1.tipsGo_, false)

		function arg_962_1.onSingleLineFinish_()
			arg_962_1.onSingleLineUpdate_ = nil
			arg_962_1.onSingleLineFinish_ = nil
			arg_962_1.state_ = "waiting"
			arg_962_1.auto_ = false
		end

		function arg_962_1.playNext_(arg_964_0)
			arg_962_1.onStoryFinished_()
		end

		function arg_962_1.onSingleLineUpdate_(arg_965_0)
			if 0 < arg_962_1.time_ and arg_962_1.time_ <= 0 + arg_965_0 then
				arg_962_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			if 0 < arg_962_1.time_ and arg_962_1.time_ <= 0 + arg_965_0 then
				arg_962_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_965_0 = 0
			local var_965_1 = 0.275

			if 0 < arg_962_1.time_ and arg_962_1.time_ <= var_965_0 + arg_965_0 then
				arg_962_1.talkMaxDuration = 0
				arg_962_1.dialogCg_.alpha = 1

				arg_962_1.dialog_:SetActive(true)
				SetActive(arg_962_1.leftNameGo_, true)

				arg_962_1.leftNameTxt_.text = arg_962_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_962_1.leftNameTxt_.transform)

				arg_962_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_962_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_962_1:RecordName(arg_962_1.leftNameTxt_.text)
				SetActive(arg_962_1.iconTrs_.gameObject, false)
				arg_962_1.callingController_:SetSelectedState("normal")

				local var_965_2 = arg_962_1:GetWordFromCfg(1108106231)
				local var_965_3 = arg_962_1:FormatText(var_965_2.content)

				arg_962_1.text_.text = var_965_3

				LuaForUtil.ClearLinePrefixSymbol(arg_962_1.text_)

				local var_965_5 = 11 <= 0 and var_965_1 or var_965_1 * (utf8.len(var_965_3) / 11)

				if (11 <= 0 and var_965_1 or var_965_1 * (utf8.len(var_965_3) / 11)) > 0 and var_965_1 < var_965_5 then
					arg_962_1.talkMaxDuration = var_965_5

					if var_965_5 + var_965_0 > arg_962_1.duration_ then
						arg_962_1.duration_ = var_965_5 + var_965_0
					end
				end

				arg_962_1.text_.text = var_965_3
				arg_962_1.typewritter.percent = 0

				arg_962_1.typewritter:SetDirty()
				arg_962_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb") ~= 0 then
					local var_965_6 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb") / 1000

					if var_965_6 + var_965_0 > arg_962_1.duration_ then
						arg_962_1.duration_ = var_965_6 + var_965_0
					end

					if var_965_2.prefab_name ~= "" and arg_962_1.actors_[var_965_2.prefab_name] ~= nil then
						local var_965_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_962_1.actors_[var_965_2.prefab_name].transform, "story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")

						arg_962_1:RecordAudio("1108106231", var_965_7)
						arg_962_1:RecordAudio("1108106231", var_965_7)
					else
						arg_962_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")
					end

					arg_962_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")
				end

				arg_962_1:RecordContent(arg_962_1.text_.text)
			end

			local var_965_8 = math.max(var_965_1, arg_962_1.talkMaxDuration)

			if var_965_0 <= arg_962_1.time_ and arg_962_1.time_ < var_965_0 + var_965_8 then
				arg_962_1.typewritter.percent = (arg_962_1.time_ - var_965_0) / var_965_8

				arg_962_1.typewritter:SetDirty()
			end

			if arg_962_1.time_ >= var_965_0 + var_965_8 and arg_962_1.time_ < var_965_0 + var_965_8 + arg_965_0 then
				arg_962_1.typewritter.percent = 1

				arg_962_1.typewritter:SetDirty()
				arg_962_1:ShowNextGo(true)
			end
		end

		arg_962_1.nodeConfigList_ = {}

		arg_962_1:InitPlayNodeList()
	end,
	Play1108106218 = function(arg_966_0, arg_966_1)
		arg_966_1.time_ = 0
		arg_966_1.frameCnt_ = 0
		arg_966_1.state_ = "playing"
		arg_966_1.curTalkId_ = 1108106218
		arg_966_1.duration_ = 2.67

		SetActive(arg_966_1.tipsGo_, false)

		function arg_966_1.onSingleLineFinish_()
			arg_966_1.onSingleLineUpdate_ = nil
			arg_966_1.onSingleLineFinish_ = nil
			arg_966_1.state_ = "waiting"
		end

		function arg_966_1.playNext_(arg_968_0)
			if arg_968_0 == 1 then
				arg_966_0:Play1108106219(arg_966_1)
			end
		end

		function arg_966_1.onSingleLineUpdate_(arg_969_0)
			if arg_966_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_969_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_966_1.stage_.transform)

				var_969_0.name = "1081ui_story"
				var_969_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_966_1.actors_["1081ui_story"] = var_969_0

				local var_969_1 = var_969_0:GetComponentInChildren(typeof(CharacterEffect))

				var_969_1.enabled = true

				local var_969_2 = GameObjectTools.GetOrAddComponent(var_969_0, typeof(DynamicBoneHelper))

				if var_969_2 then
					var_969_2:EnableDynamicBone(false)
				end

				arg_966_1:ShowWeapon(var_969_1.transform, false)

				arg_966_1.var_["1081ui_story" .. "Animator"] = var_969_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_966_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_966_1.var_["1081ui_story" .. "LipSync"] = var_969_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_966_1.time_ and arg_966_1.time_ <= 0 + arg_969_0 then
				arg_966_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			local var_969_3 = "1081ui_story"

			if arg_966_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_969_4 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_966_1.stage_.transform)

				var_969_4.name = var_969_3
				var_969_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_966_1.actors_[var_969_3] = var_969_4

				local var_969_5 = var_969_4:GetComponentInChildren(typeof(CharacterEffect))

				var_969_5.enabled = true

				local var_969_6 = GameObjectTools.GetOrAddComponent(var_969_4, typeof(DynamicBoneHelper))

				if var_969_6 then
					var_969_6:EnableDynamicBone(false)
				end

				arg_966_1:ShowWeapon(var_969_5.transform, false)

				arg_966_1.var_[var_969_3 .. "Animator"] = var_969_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_966_1.var_[var_969_3 .. "Animator"].applyRootMotion = true
				arg_966_1.var_[var_969_3 .. "LipSync"] = var_969_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_966_1.time_ and arg_966_1.time_ <= 0 + arg_969_0 then
				arg_966_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_969_7 = arg_966_1.actors_["1081ui_story"]

			if 0 < arg_966_1.time_ and arg_966_1.time_ <= 0 + arg_969_0 and not isNil(var_969_7) and arg_966_1.var_.characterEffect1081ui_story == nil then
				arg_966_1.var_.characterEffect1081ui_story = var_969_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_969_8 = 0.200000002980232

			if 0 <= arg_966_1.time_ and arg_966_1.time_ < 0 + var_969_8 and not isNil(var_969_7) then
				if arg_966_1.var_.characterEffect1081ui_story and not isNil(var_969_7) then
					arg_966_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_966_1.time_ >= 0 + var_969_8 and arg_966_1.time_ < 0 + var_969_8 + arg_969_0 and not isNil(var_969_7) and arg_966_1.var_.characterEffect1081ui_story then
				arg_966_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_969_10 = 0
			local var_969_11 = 0.225

			if 0 < arg_966_1.time_ and arg_966_1.time_ <= var_969_10 + arg_969_0 then
				arg_966_1.talkMaxDuration = 0
				arg_966_1.dialogCg_.alpha = 1

				arg_966_1.dialog_:SetActive(true)
				SetActive(arg_966_1.leftNameGo_, true)

				arg_966_1.leftNameTxt_.text = arg_966_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_966_1.leftNameTxt_.transform)

				arg_966_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_966_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_966_1:RecordName(arg_966_1.leftNameTxt_.text)
				SetActive(arg_966_1.iconTrs_.gameObject, false)
				arg_966_1.callingController_:SetSelectedState("normal")

				local var_969_12 = arg_966_1:GetWordFromCfg(1108106218)
				local var_969_13 = arg_966_1:FormatText(var_969_12.content)

				arg_966_1.text_.text = var_969_13

				LuaForUtil.ClearLinePrefixSymbol(arg_966_1.text_)

				local var_969_15 = 9 <= 0 and var_969_11 or var_969_11 * (utf8.len(var_969_13) / 9)

				if (9 <= 0 and var_969_11 or var_969_11 * (utf8.len(var_969_13) / 9)) > 0 and var_969_11 < var_969_15 then
					arg_966_1.talkMaxDuration = var_969_15

					if var_969_15 + var_969_10 > arg_966_1.duration_ then
						arg_966_1.duration_ = var_969_15 + var_969_10
					end
				end

				arg_966_1.text_.text = var_969_13
				arg_966_1.typewritter.percent = 0

				arg_966_1.typewritter:SetDirty()
				arg_966_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb") ~= 0 then
					local var_969_16 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb") / 1000

					if var_969_16 + var_969_10 > arg_966_1.duration_ then
						arg_966_1.duration_ = var_969_16 + var_969_10
					end

					if var_969_12.prefab_name ~= "" and arg_966_1.actors_[var_969_12.prefab_name] ~= nil then
						local var_969_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_966_1.actors_[var_969_12.prefab_name].transform, "story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")

						arg_966_1:RecordAudio("1108106218", var_969_17)
						arg_966_1:RecordAudio("1108106218", var_969_17)
					else
						arg_966_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")
					end

					arg_966_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")
				end

				arg_966_1:RecordContent(arg_966_1.text_.text)
			end

			local var_969_18 = math.max(var_969_11, arg_966_1.talkMaxDuration)

			if var_969_10 <= arg_966_1.time_ and arg_966_1.time_ < var_969_10 + var_969_18 then
				arg_966_1.typewritter.percent = (arg_966_1.time_ - var_969_10) / var_969_18

				arg_966_1.typewritter:SetDirty()
			end

			if arg_966_1.time_ >= var_969_10 + var_969_18 and arg_966_1.time_ < var_969_10 + var_969_18 + arg_969_0 then
				arg_966_1.typewritter.percent = 1

				arg_966_1.typewritter:SetDirty()
				arg_966_1:ShowNextGo(true)
			end
		end

		arg_966_1.nodeConfigList_ = {}

		arg_966_1:InitPlayNodeList()
	end,
	Play1108106009 = function(arg_970_0, arg_970_1)
		arg_970_1.time_ = 0
		arg_970_1.frameCnt_ = 0
		arg_970_1.state_ = "playing"
		arg_970_1.curTalkId_ = 1108106009
		arg_970_1.duration_ = 6.93

		SetActive(arg_970_1.tipsGo_, false)

		function arg_970_1.onSingleLineFinish_()
			arg_970_1.onSingleLineUpdate_ = nil
			arg_970_1.onSingleLineFinish_ = nil
			arg_970_1.state_ = "waiting"
		end

		function arg_970_1.playNext_(arg_972_0)
			if arg_972_0 == 1 then
				arg_970_0:Play1108106010(arg_970_1)
			end
		end

		function arg_970_1.onSingleLineUpdate_(arg_973_0)
			if arg_970_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_973_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_970_1.stage_.transform)

				var_973_0.name = "1081ui_story"
				var_973_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_970_1.actors_["1081ui_story"] = var_973_0

				local var_973_1 = var_973_0:GetComponentInChildren(typeof(CharacterEffect))

				var_973_1.enabled = true

				local var_973_2 = GameObjectTools.GetOrAddComponent(var_973_0, typeof(DynamicBoneHelper))

				if var_973_2 then
					var_973_2:EnableDynamicBone(false)
				end

				arg_970_1:ShowWeapon(var_973_1.transform, false)

				arg_970_1.var_["1081ui_story" .. "Animator"] = var_973_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_970_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_970_1.var_["1081ui_story" .. "LipSync"] = var_973_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_970_1.time_ and arg_970_1.time_ <= 0 + arg_973_0 then
				arg_970_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_973_3 = arg_970_1.actors_["1081ui_story"]

			if 0 < arg_970_1.time_ and arg_970_1.time_ <= 0 + arg_973_0 and not isNil(var_973_3) and arg_970_1.var_.characterEffect1081ui_story == nil then
				arg_970_1.var_.characterEffect1081ui_story = var_973_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_973_4 = 0.2

			if 0 <= arg_970_1.time_ and arg_970_1.time_ < 0 + var_973_4 and not isNil(var_973_3) then
				if arg_970_1.var_.characterEffect1081ui_story and not isNil(var_973_3) then
					arg_970_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_970_1.time_ >= 0 + var_973_4 and arg_970_1.time_ < 0 + var_973_4 + arg_973_0 and not isNil(var_973_3) and arg_970_1.var_.characterEffect1081ui_story then
				arg_970_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_973_6 = 0
			local var_973_7 = 0.625

			if 0 < arg_970_1.time_ and arg_970_1.time_ <= var_973_6 + arg_973_0 then
				arg_970_1.talkMaxDuration = 0
				arg_970_1.dialogCg_.alpha = 1

				arg_970_1.dialog_:SetActive(true)
				SetActive(arg_970_1.leftNameGo_, true)

				arg_970_1.leftNameTxt_.text = arg_970_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_970_1.leftNameTxt_.transform)

				arg_970_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_970_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_970_1:RecordName(arg_970_1.leftNameTxt_.text)
				SetActive(arg_970_1.iconTrs_.gameObject, false)
				arg_970_1.callingController_:SetSelectedState("normal")

				local var_973_8 = arg_970_1:GetWordFromCfg(1108106009)
				local var_973_9 = arg_970_1:FormatText(var_973_8.content)

				arg_970_1.text_.text = var_973_9

				LuaForUtil.ClearLinePrefixSymbol(arg_970_1.text_)

				local var_973_11 = 25 <= 0 and var_973_7 or var_973_7 * (utf8.len(var_973_9) / 25)

				if (25 <= 0 and var_973_7 or var_973_7 * (utf8.len(var_973_9) / 25)) > 0 and var_973_7 < var_973_11 then
					arg_970_1.talkMaxDuration = var_973_11

					if var_973_11 + var_973_6 > arg_970_1.duration_ then
						arg_970_1.duration_ = var_973_11 + var_973_6
					end
				end

				arg_970_1.text_.text = var_973_9
				arg_970_1.typewritter.percent = 0

				arg_970_1.typewritter:SetDirty()
				arg_970_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb") ~= 0 then
					local var_973_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb") / 1000

					if var_973_12 + var_973_6 > arg_970_1.duration_ then
						arg_970_1.duration_ = var_973_12 + var_973_6
					end

					if var_973_8.prefab_name ~= "" and arg_970_1.actors_[var_973_8.prefab_name] ~= nil then
						local var_973_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_970_1.actors_[var_973_8.prefab_name].transform, "story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")

						arg_970_1:RecordAudio("1108106009", var_973_13)
						arg_970_1:RecordAudio("1108106009", var_973_13)
					else
						arg_970_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")
					end

					arg_970_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")
				end

				arg_970_1:RecordContent(arg_970_1.text_.text)
			end

			local var_973_14 = math.max(var_973_7, arg_970_1.talkMaxDuration)

			if var_973_6 <= arg_970_1.time_ and arg_970_1.time_ < var_973_6 + var_973_14 then
				arg_970_1.typewritter.percent = (arg_970_1.time_ - var_973_6) / var_973_14

				arg_970_1.typewritter:SetDirty()
			end

			if arg_970_1.time_ >= var_973_6 + var_973_14 and arg_970_1.time_ < var_973_6 + var_973_14 + arg_973_0 then
				arg_970_1.typewritter.percent = 1

				arg_970_1.typewritter:SetDirty()
				arg_970_1:ShowNextGo(true)
			end
		end

		arg_970_1.nodeConfigList_ = {}

		arg_970_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0402a",
		"TextureConfig/Background/ST0401",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/H01b",
		"TextureConfig/Background/R8102a",
		"TextureConfig/Background/R8102",
		"TextureConfig/Background/R8102b",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST07b"
	},
	voices = {
		"story_v_side_new_1108106.awb"
	}
}
